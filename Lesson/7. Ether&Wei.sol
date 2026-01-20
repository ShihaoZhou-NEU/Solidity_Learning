// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract EtherUnits{
    uint256 public oneWei = 1;
    uint256 public oneWei2 = 1 wei;

    uint256 public oneGwei = 1 gwei;
    uint256 public oneGwei2 = 1e9; // 1 gwei = 1e9 wei

    uint256 public oneEther = 1 ether;
    uint256 public oneEther2 = 1e18; // 1 ether = 1e18 wei
    bool public isEqualOneEther = (oneEther == oneEther2);
}