# passGas Smart Contract

This is a simple Solidity contract that allows an owner to send Ether to someone who provides a valid signature.

## Contract Details

- SPDX-License-Identifier: MIT
- pragma solidity ^0.8.12;

### Contract Functions

1. `claimPayment(uint256 amount, uint256 nonce, bytes memory sig)`:
    - Allows anyone to claim a payment if they have a valid signature from the contract owner.
    - Ensures that the same nonce is not used twice.

2. `kill()`:
    - Destroys the contract and reclaims any leftover funds.
    - Can only be called by the contract owner.

### Signature Methods

1. `splitSignature(bytes memory sig)`:
    - Splits a given signature into its components: `v`, `r`, and `s`.

2. `recoverSigner(bytes32 message, bytes memory sig)`:
    - Recovers the signer's address from a given message and signature.

## Example Usage

A user can claim a payment by providing the required `amount`, `nonce`, and `signature` to the `claimPayment` function. If the provided signature is valid and the nonce has not been used before, the Ether will be sent to the user.

The contract owner can destroy the contract and reclaim any remaining funds by calling the `kill` function.
