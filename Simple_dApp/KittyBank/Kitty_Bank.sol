// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract KittyBank {
    address public owner;
    
    event Deposit(address indexed sender, uint256 amount);
    event Withdraw(uint256 amount);

    // 构造函数：部署合约的人自动成为主人
    constructor() {
        owner = msg.sender;
    }

    // 修饰符：限制只有主人可以执行
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the cat owner can do this!");
        _;
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function deposit() public payable {
        require(msg.value > 0, "Feed me some ETH!");
        emit Deposit(msg.sender, msg.value);
    }

    // 提款函数：将所有余额发送给主人
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "Bank is empty!");
        
        (bool success, ) = payable(owner).call{value: balance}("");
        require(success, "Transfer failed");
        
        emit Withdraw(balance);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}