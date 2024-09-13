script {

    use std::vector;
    use std::string;
    use Marketplace::Marketplace;

    fun main(account: &signer) {
        let name = string::utf8(b"MyModule");
        let description = string::utf8(b"This is a sample module");
        let price = 1000; // Giá của module (giả sử đơn vị là AptosCoin)

        // Mã bytecode của module (giả định)
        let code = vector::empty<u8>();

        Marketplace::register_module(account, name, description, price, code);
    }
}
