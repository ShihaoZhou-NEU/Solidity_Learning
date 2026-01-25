// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Event {
    event Log(address indexed sender, string message);
    event AnotherLog();

    function test() public {
        emit Log(msg.sender, "hello");
        emit AnotherLog();
    }

    // 对正确的事件参数进行索引，以实现高效的筛选和搜索。地址通常需要索引，而金额一般不需要。
    // 避免发出底层库或合约已经涵盖的事件，从而避免冗余事件。
    // 事件不能用于view函数pure，因为它们会通过存储日志来改变区块链的状态。
}
