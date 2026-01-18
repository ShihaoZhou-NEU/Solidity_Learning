// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {
    // 这个变量用来存一个数字
    uint256 public myNumber;

    function plusOne(uint256 _num) private pure returns (uint256){
        _num = _num +1;
        return _num;
    }

    // 写入函数：把数字存进去 (要花 Gas)
    function store(uint256 _num) public {
        myNumber = plusOne(_num);
    }

    // 读取函数：把数字读出来 (免费)
    function retrieve() public view returns (uint256) {
        return myNumber;
    }
}