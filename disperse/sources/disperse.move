
module disperse::disperse {
    use sui::coin::{Self};
    use sui::transfer;
    use sui::pay;
    use sui::tx_context::{Self, TxContext};
    use std::vector;

    /// values and recipients data length are not same
    const EMissmatchInput: u64 = 0;
    /// For when trying to withdraw more than there is.
    const ENotEnough: u64 = 1;
 
     /// Split coin into multiple coins, each with balance specified
    public entry fun disperseToken<T>(coin: coin::Coin<T>, values: vector<u64>, recipients: vector<address>, ctx: &mut TxContext) {
            let (i, total_value, len) = (0, 0, vector::length(&values));
            let balance = coin::value(&coin);
            assert!(len == vector::length(&recipients), EMissmatchInput);

            while (i < len) {
            total_value = total_value + *vector::borrow(&values, i);
             i = i + 1;
            };
            
            assert!(total_value <= balance, ENotEnough);

            let k = 0;
            while (k < len) {
            pay::split_and_transfer<T>(&mut coin, *vector::borrow(&values, k), *vector::borrow(&recipients, k), ctx);
            k = k + 1;
            };

            transfer::public_transfer(coin, tx_context::sender(ctx))
    }
  
}
