// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// Make sure EVM version and VM set to Cancun

// Storage - data is stored on the blockchain
// Memory - data is cleared out after a function call
// Transient storage - data is cleared out after a transaction

contract TransientStorage{
    // Transient 瞬态存储（交易内临时）
    address transient public _tempHighestBidder;
    uint256 transient _tempHighestBid;

    // transient storage 是智能合约开发的重大优化，特别适合重入锁、跨函数临时数据、复杂交易中间状态等场景。
    // 它让“临时但需跨函数共享”的数据存储变得既安全又廉价，是编写高效合约的新利器

}