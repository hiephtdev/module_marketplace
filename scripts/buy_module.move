script {

    use Marketplace::Marketplace;
    use aptos_framework::aptos_coin::AptosCoin;
    use aptos_framework::coin;

    fun main(buyer: &signer, module_id: u64) {
        let amount = coin::withdraw<AptosCoin>(buyer, 1000); // Rút 1000 AptosCoin từ tài khoản người mua
        Marketplace::buy_module(buyer, module_id, amount);
    }
}
