// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

 contract Mapping{
    mapping(address=>uint256) public balance;

    function get(address _addr) public view returns(uint256){
        // mapping 会返回一个值，如果没有赋值，那么会返回默认值
        return balance[_addr];
    
    }

    function set(address _addr, uint256 amount) public {
        balance[_addr] = amount;
    }

    function remove(address _addr) public {
        delete balance[_addr];
        // 没有真的删除，是设置为默认值
    }

 }


 contract NestedMapping {
    mapping(address => mapping(address=>uint256)) public allowance;

    function set(address owner, address spender, uint256 amount) public {
        allowance[owner][spender] = amount;
    }

    function get(address owner, address spender) public view returns(uint256){
        return allowance[owner][spender];
    }

 }