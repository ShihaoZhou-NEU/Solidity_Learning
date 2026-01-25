// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FunctionModifier{
    address public owner;
    uint256 public x = 10;
    bool transient public locked;

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Not onwer");
        // 使用下划线，可以执行函数中剩下的代码
        // 智能在 Function Modifier 内使用 
        _;
    }

    modifier validAddress(address _newAddress){
        require(_newAddress == address(0), "Not Valid Address");
        _;
    }

    function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner){
        owner = _newOwner;
    }

    // Modifiers can be called before and / or after a function.
    // This modifier prevents a function from being called while
    // it is still executing.
    modifier antiReentrancy(){
        require(!locked, "No reentrancy");

        locked = true;
        _;
        locked = false;
    }

    function decrement(uint256 i) public antiReentrancy {
        x -= i;

        if (i > 1) {
            decrement(i - 1);
        }
    }
}