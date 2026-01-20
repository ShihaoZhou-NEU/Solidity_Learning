// There are 3 types of variables in Solidity

// local
// declared inside a function
// not stored on the blockchain

// state
// declared outside a function
// stored on the blockchain

// global (provides information about the blockchain)

pragma solidity ^0.8.26;

contract Variables{
    // state 变量会被存储到区块链中
    string public text = "Hello";
    uint public number = 123;
    bool public boolean = true;

    function example() public view returns (address){
        uint256 i = 456;
        // local 变量不会被存储到区块链中
        // 它只会被存储在内存中
        // 它只能在函数内部使用
        // 它不能被其他函数访问

        // global 变量提供关于区块链的信息
        // 例如 block.timestamp、msg.sender、tx.gasprice
        // 这些变量不能被修改
        // 它们只能被读取
        uint256 timestamp = block.timestamp;
        address sender = msg.sender;
        return sender;
    }
}