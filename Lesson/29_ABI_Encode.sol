// abi.encode 的核心作用：
// 合约间通信 - 创建函数调用的 calldata
// 数据序列化 - 将复杂数据转换为字节序列
// 哈希计算 - 为数字签名创建确定性的消息哈希
// 错误处理 - 创建自定义错误的编码数据
// 存储优化 - 编码后存储节省空间
// 需要做什么？ 
// ├── 调用其他合约函数 → encodeWithSignature()
// ├── 计算安全哈希 → encode() + keccak256()
// ├── 简单连接数据 → encodePacked()
// ├── 存储复杂数据 → encode() 然后存储
// └── 创建签名消息 → encode() + "\x19Ethereum Signed Message..."

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface IERC20 {
    function transfer(address, uint256) external;
}

contract Token {
    function transfer(address, uint256) external {}
}

contract AbiEncode {
    function test(address _contract, bytes calldata data) external {
        (bool ok,) = _contract.call(data);
        require(ok, "call failed");
    }

    function encodeWithSignature(address to, uint256 amount)
        external
        pure
        returns (bytes memory)
    {
        // Typo is not checked - "transfer(address, uint)"
        return abi.encodeWithSignature("transfer(address,uint256)", to, amount);
    }

    function encodeWithSelector(address to, uint256 amount)
        external
        pure
        returns (bytes memory)
    {
        // Type is not checked - (IERC20.transfer.selector, true, amount)
        return abi.encodeWithSelector(IERC20.transfer.selector, to, amount);
    }

    function encodeCall(address to, uint256 amount)
        external
        pure
        returns (bytes memory)
    {
        // Typo and type errors will not compile
        return abi.encodeCall(IERC20.transfer, (to, amount));
    }
}
