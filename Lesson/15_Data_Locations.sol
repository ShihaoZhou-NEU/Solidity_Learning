// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Variables are declared as either storage, memory or calldata to explicitly specify the location of the data.

// storage - variable is a state variable (stored on the blockchain)
// memory - variable is in memory and it exists while a function is being called
// calldata - special data location that contains function arguments

contract DataLocations{
    uint256[] public arr;
    mapping(uint256 => address) map;

    struct Mystruct{
        uint256 foo;
    }

    mapping(uint256=>Mystruct) myStructs;

    function f() public view{
        uint256[] memory memoArr = _f(arr);

        Mystruct memory myStruct = myStructs[1];

    }

    function _f(uint256[] storage _arr) internal pure returns(uint256[] memory ){
        uint256[] memory _memoArr = _arr;
        return _memoArr;
    }
}