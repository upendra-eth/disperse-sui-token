Certainly! Here is the README content in raw form:

```markdown
# Disperse SUI Token Smart Contract

## Overview

This repository contains the Move smart contract code for a token dispenser implementing the "disperse" functionality for SUI tokens. The smart contract allows splitting a token into multiple coins and distributing them to specified recipients.

## Smart Contract Details

### Module: disperse::disperse

- **Dependencies:**
  - `sui::coin::{Self}`
  - `sui::transfer`
  - `sui::pay`
  - `sui::tx_context::{Self, TxContext}`
  - `std::vector`

### Constants:

- `EMissmatchInput (u64)`: Error code for values and recipients data length mismatch.
- `ENotEnough (u64)`: Error code for trying to withdraw more than the available balance.

### Public Entry Function:

#### `disperseToken<T>(coin: coin::Coin<T>, values: vector<u64>, recipients: vector<address>, ctx: &mut TxContext)`

This function splits a coin into multiple coins, each with a specified balance, and transfers them to the provided recipients.

**Parameters:**
- `coin`: The token coin to be dispersed.
- `values`: Vector of u64 values representing the balances for each recipient.
- `recipients`: Vector of addresses representing the recipients of the dispersed coins.
- `ctx`: Mutable reference to the transaction context.

**Error Handling:**
- `EMissmatchInput`: Values and recipients data length mismatch.
- `ENotEnough`: Attempt to withdraw more than the available balance.

## How to Use

1. Deploy the smart contract on the Move blockchain.
2. Call the `disperseToken` function with the appropriate parameters to disperse tokens.

## License

This project is licensed under the [MIT License](LICENSE).

## Contribution

Contributions are welcome! If you find any issues or want to improve the code, feel free to open a pull request.
```

Feel free to customize it further according to your specific project details and preferences.