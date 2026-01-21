// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Counter {
    uint256 public count;
    // 类型：无符号整数（unsigned integer），占 256 位（即 32 字节），范围为 0 到 2²⁵⁶-1（约 1.15e77）。
    // 默认值：未初始化的 uint256 默认为 0。
    // 用途：常用于计数、余额、时间戳等非负数场景。
    // 如需节省 gas，可用更小的类型（如 uint8/uint16），但避免频繁类型转换。

    // Function to get the current count
    // public
    // view：Indicates the function does not modify the blockchain state (no gas cost if called externally)
    // returns
    function get() public view returns (uint256) {
        return count;
    }

    // Function to increment count by 1
    function inc() public {
        count += 1;
    }

    // Function to decrement count by 1
    function dec() public {
        // This function will fail if count = 0
        count -= 1;
    }
}
