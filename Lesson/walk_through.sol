// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ERC20 {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    address public owner;
    // 需要链上存储的数据

    mapping(address => uint256) private _balance;
    // 想一个账本，某个地址代币的数量
    mapping(address => mapping(address => uint256)) private _allowance;
    // 授权给某个地址可以使用代币

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply,
        uint8 _decimals
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        owner = msg.sender;
        _balance[msg.sender] = _totalSupply;
    }

    function get_totalSupply() external view returns (uint256) {
        return totalSupply;
    }

    function balanceOf(address _account) external view returns (uint256) {
        return _balance[_account];
    }

    function transfer(address _to, uint256 _amount) external returns (bool) {
        require(_amount > 0, "Amount must be greater than zero");
        // 错误回滚方法 require
        require(_to != address(0), "ERC20: to zero address");

        uint256 fromBalance = _balance[msg.sender];
        require(fromBalance >= _amount, "ERC20: insufficient balance");
        _balance[msg.sender] = fromBalance - _amount;
        _balance[_to] += _amount;

        emit Transfer(msg.sender, _to, _amount);
        return true;
    }

    function approve(
        address _spender,
        uint256 _amount
    ) external returns (bool) {
        require(_amount > 0, "Amount must be greater than zero");
        // 错误回滚方法 require
        require(_spender != address(0), "ERC20: to zero address");

        uint256 ownerBalance = _balance[msg.sender];
        require(ownerBalance >= _amount, "ERC20: insufficient balance");

        _allowance[msg.sender][_spender] = _amount;
        emit Approval(msg.sender, _spender, _amount);
        return true;
    }
}
