// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;
import "./12.1. EnumDeclaration.sol";

contract Enum{
    enum Status{
        Pending,
        Shipped,
        Accepted,
        Rejected,
        Canceled
    }

    Status_Out public status_out;

    Status public status;
    // 默认值是第一个值，也就是Pending

    // Returns uint
    // Pending  - 0
    // Shipped  - 1
    // Accepted - 2
    // Rejected - 3
    // Canceled - 4

    function get() public view returns(Status) {
        return status;
        // 会得到一个 uint
    }   

    function set(Status _status) public{
        // 需要用 uint 赋值
        status = _status;
    }

    function cancel() public{
        status = Status.Canceled;
        status_out = Status_Out.Canceled;
    }
}