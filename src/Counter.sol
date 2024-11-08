// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// publicInputHash
bytes32 constant publicInputHash = 0xdb2606d8ecfcc6c05f4d0c0c5f74b41db74f437df333203711f8ff6e11190e8a;
// blockhash(0)
bytes32 constant blockhash_0 = 0x7983c69e31da54b8d244d8fef4714ee7a8ed25d873ebef204a56f082a73c9f1e;
// blockhash(1)
bytes32 constant blockhash_1 = 0x2eb807ab25654412ad4d346f31a7b4ce2aa8f0d9e683a60b02395a742c1da7a2;

/// @dev Refference implementation of 
/// https://github.com/NethermindEth/surge-taiko-mono/blob/963cc20c9b8f05f08e5da1c0c33a8ad3832f9063/packages/protocol/contracts/layer2/based/TaikoL2.sol#L354
contract Counter {
    function calcPublicInputHash()
        public
        pure
        returns (bytes32 publicInputHashOld, bytes32 publicInputHashNew)
    {
        //uint256 _blockId = 1;
        bytes32[256] memory inputs;

        // Unchecked is safe because it cannot overflow.
        unchecked {
            // Put the previous 255 blockhashes (excluding the parent's) into a
            // ring buffer.
            /*for (uint256 i; i < 255 && _blockId >= i + 1; ++i) {
                uint256 j = _blockId - i - 1;
                inputs[j % 255] = blockhash(j);
            }*/
            //inputs[0] = blockhash_0;
        }

        uint cainid = 167000;
        inputs[255] = bytes32(cainid);//bytes32(block.chainid);

        assembly {
            publicInputHashOld := keccak256(inputs, 8192 /*mul(256, 32)*/ )
        }

        //inputs[_blockId % 255] = blockhash(_blockId);
        inputs[0] = blockhash_0;
        assembly {
            publicInputHashNew := keccak256(inputs, 8192 /*mul(256, 32)*/ )
        }
    }

    /// @dev Calculate initial publicInputHash value by chainId
    function calcInitialPublicInputHash(uint256 chainId)
        public
        pure
        returns (bytes32 publicInputHashOld)
    {
        bytes32[256] memory inputs;

        inputs[255] = bytes32(chainId);//bytes32(block.chainid);

        assembly {
            publicInputHashOld := keccak256(inputs, 8192 /*mul(256, 32)*/ )
        }
    }

}
