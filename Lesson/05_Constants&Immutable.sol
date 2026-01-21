// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Constants_Immutable {
    // 特性	    Constant (常量)	        Immutable (不可变量)
    // 赋值时机	编译时确定	            部署时确定（在构造函数中）
    // 赋值次数	定义时必须赋值	        只能在构造函数中赋值一次
    // gas成本	最低（直接内联到字节码）    较低（存储在合约代码而非存储槽）
    // 存储位置	字节码中	                合约代码的特殊区域

    address public constant MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
    uint256 public constant MY_UINT = 123;

    address public immutable myAddres;
    uint256 public immutable myUnit;

    constructor(uint256 _myUnit){
        myAddres = msg.sender;
        myUnit = _myUnit;
    }
}
