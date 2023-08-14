# Pass Gass

## Description

This contract, `passGas`, leverages the concept of meta-transactions, allowing users to send transactions without incurring gas fees. Instead, another entity (e.g., the contract owner) pays for the gas. The system works by having the user sign a message off-chain. The signed message is then sent to the contract, where it gets verified. If the verification is successful, the desired transaction is processed.

## Key Features

- **Meta-transactions:** Users don't need to hold or spend ETH for gas fees.
- **Nonces:** Ensures a particular signature can only be used once, preventing replay attacks.
- **Self Destruct:** A mechanism for the contract owner to destroy the contract and recover any remaining funds.

## Contract

- `passGas.sol`: The smart contract enabling meta-transactions.

## Functions

- `claimPayment(uint256 amount, uint256 nonce, bytes memory sig)`: Claim ether based on a valid off-chain signature.
- `kill()`: Allows the contract owner to safely destroy the contract.

## Interacting with the Contract

- To claim a payment:
  ```solidity
  function claimPayment(uint256 amount, uint256 nonce, bytes memory sig) public
  ```

- To terminate the contract (owner only):
  ```solidity
  function kill() public
  ```

## Deployment

1. Compile and deploy the contract using tools like Remix or Truffle.
2. Ensure that the contract has enough funds (ETH) if you're planning to let users claim payments.
3. Set up a system where users can sign messages off-chain and send the signatures to the contract to claim their payments.

## Security Considerations

- Keep the off-chain signing mechanism secure.
- Use a fresh nonce for every transaction to prevent replay attacks.
- Only the owner can destroy the contract, so be cautious with this power.

## License

MIT
