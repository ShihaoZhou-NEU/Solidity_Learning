// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Primitives{
    bool public boo = true;
    bool public boo2 = false; // 默认是false

    // uint 非负整数，有不同的size
    /*
    uint stands for unsigned integer, meaning non negative integers
    different sizes are available
        uint8   ranges from 0 to 2 ** 8 - 1
        uint16  ranges from 0 to 2 ** 16 - 1
        ...
        uint256 ranges from 0 to 2 ** 256 - 1
    */

    uint public u = 123; // uint 就是 uint256


    /*
    Negative numbers are allowed for int types.
    Like uint, different ranges are available from int8 to int256
    
    int256 ranges from -2 ** 255 to 2 ** 255 - 1
    int128 ranges from -2 ** 127 to 2 ** 127 - 1
    */
    int8 public i8 = -1;
    int256 public i256 = 456;
    int256 public i = -123; // int is same as int256


    int256 public minInt256 = type(int256).min;
    int256 public maxInt256 = type(int256).max;

    // 大小：20 字节（160 位），例如： 0x742d35Cc6634C0532925a3b844Bc454e4438f44e
    // 默认值：0x000...000（全零地址，通常表示“空地址”）。
    address public addr = 0x742d35Cc6634C0532925a3b844Bc454e4438f44e;
    uint balance = addr.balance;

    // bytes1 是 Solidity 中的固定长度字节数组，长度为 1 字节（8 位），用于存储单个字节的数据（如 ASCII 字符、十六进制值等）。
    bytes1 public b1 = 0x41;
    bytes1 public b2 = 0x65;

    bytes1 public defaultByte;      // 默认 0x00

    // bytes 可以继续深入学习

}