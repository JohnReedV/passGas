//SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract passGas {
    address owner = msg.sender;

    uint256 contractBalance;

    mapping(uint256 => bool) usedNonces;

    function fund() public payable {
        contractBalance = contractBalance + msg.value;
    }

    function claimPayment(uint256 amount, uint256 nonce, bytes memory sig) public {
        require(!usedNonces[nonce]);
        usedNonces[nonce] = true;

        // This recreates the message that was signed on the client.
        bytes32 message = keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32",
        (keccak256(abi.encodePacked(msg.sender, amount, nonce, this)))));

        require(recoverSigner(message, sig) == owner);

        bool sent = payable(msg.sender).send(amount);
        require(sent, "Failed to send Ether");
    }

    // Destroy contract and reclaim leftover funds.
    function kill() public {
        require(msg.sender == owner);
        selfdestruct(payable(msg.sender));
    }


    // Signature methods

    function splitSignature(bytes memory sig)
        internal
        pure
        returns (uint8, bytes32, bytes32)
    {
        require(sig.length == 65);

        bytes32 r;
        bytes32 s;
        uint8 v;

        assembly {
            // first 32 bytes, after the length prefix
            r := mload(add(sig, 32))
            // second 32 bytes
            s := mload(add(sig, 64))
            // final byte (first byte of the next 32 bytes)
            v := byte(0, mload(add(sig, 96)))
        }

        return (v, r, s);
    }

    function recoverSigner(bytes32 message, bytes memory sig)
        internal
        pure
        returns (address)
    {
        uint8 v;
        bytes32 r;
        bytes32 s;

        (v, r, s) = splitSignature(sig);

        return ecrecover(message, v, r, s);
    }
}