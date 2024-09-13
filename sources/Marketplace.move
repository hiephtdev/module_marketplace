module Marketplace::Marketplace {

    use std::signer;
    use std::vector;
    use std::string;
    use std::address;
    use aptos_framework::coin::Coin;
    use aptos_framework::aptos_coin::AptosCoin;
    use aptos_framework::event::{EventHandle, emit_event};

    /// Sự kiện khi một module được đăng ký
    struct ModuleRegisteredEvent has copy, drop, store {
        id: u64,
        owner: address,
        name: string::String,
    }

    /// Sự kiện khi một module được chuyển giao
    struct ModuleTransferredEvent has copy, drop, store {
        id: u64,
        from: address,
        to: address,
    }

    /// Cấu trúc đại diện cho một module Move được đăng ký trên Marketplace
    struct ModuleInfo has key, store {
        id: u64,
        name: string::String,
        description: string::String,
        owner: address,
        price: u64,
        code: vector<u8>,
    }

    /// Bảng lưu trữ tất cả các ModuleInfo đã đăng ký
    struct ModuleRegistry has key {
        next_id: u64,
        modules: vector<ModuleInfo>,
        register_event: EventHandle<ModuleRegisteredEvent>,
        transfer_event: EventHandle<ModuleTransferredEvent>,
    }

    /// Khởi tạo ModuleRegistry cho tài khoản
    public fun init_registry(account: &signer) {
        let register_event = EventHandle::new<vector<u8>>(account, 0);
        let transfer_event = EventHandle::new<vector<u8>>(account, 0);

        let registry = ModuleRegistry {
            next_id: 0,
            modules: vector::empty<ModuleInfo>(),
            register_event,
            transfer_event,
        };
        move_to(account, registry);
    }

    /// Đăng ký một module mới lên Marketplace
    public fun register_module(
        account: &signer,
        name: string::String,
        description: string::String,
        price: u64,
        code: vector<u8>
    ) acquires ModuleRegistry {
        let addr = signer::address_of(account);

        // Kiểm tra xem ModuleRegistry đã được khởi tạo chưa
        if (!exists<ModuleRegistry>(@Marketplace)) {
            init_registry(&create_signer(@Marketplace));
        }

        let registry = borrow_global_mut<ModuleRegistry>(@Marketplace);

        let module_info = ModuleInfo {
            id: registry.next_id,
            name: name.clone(),
            description,
            owner: addr,
            price,
            code,
        };

        vector::push_back(&mut registry.modules, module_info);
        registry.next_id = registry.next_id + 1;

        // Phát sự kiện đăng ký
        let event = ModuleRegisteredEvent {
            id: registry.next_id - 1,
            owner: addr,
            name,
        };
        emit_event(&mut registry.register_event, event);
    }

    /// Lấy danh sách tất cả các module đã đăng ký
    public fun get_modules(): vector<ModuleInfo> acquires ModuleRegistry {
        if (!exists<ModuleRegistry>(@Marketplace)) {
            // Trả về danh sách rỗng nếu chưa có ModuleRegistry
            return vector::empty<ModuleInfo>();
        }

        let registry = borrow_global<ModuleRegistry>(@Marketplace);
        vector::copy(&registry.modules)
    }

    /// Mua module từ chủ sở hữu
    public fun buy_module(
        buyer: &signer,
        module_id: u64,
        amount: Coin<AptosCoin>
    ) acquires ModuleRegistry, Coin<AptosCoin> {
        let registry = borrow_global_mut<ModuleRegistry>(@Marketplace);

        let len = vector::length(&registry.modules);
        let mut i = 0;
        while (i < len) {
            let module_ref = vector::borrow_mut(&mut registry.modules, i);
            if (module_ref.id == module_id) {
                // Kiểm tra xem người mua có đủ tiền không
                assert!(module_ref.price <= Coin::value(&amount), 1);

                let seller_address = module_ref.owner;

                // Chuyển tiền cho người bán
                Coin::deposit(&seller_address, amount);

                // Cập nhật chủ sở hữu mới
                module_ref.owner = signer::address_of(buyer);

                // Phát sự kiện chuyển giao
                let event = ModuleTransferredEvent {
                    id: module_id,
                    from: seller_address,
                    to: signer::address_of(buyer),
                };
                emit_event(&mut registry.transfer_event, event);

                return;
            }
            i = i + 1;
        }
        // Nếu không tìm thấy module
        abort 2;
    }
}
