// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// total amount = gas used + gas price
// 每一个操作都有固定的 gas 需要使用 可以参考 https://www.evm.codes/
// gas 是一个计算操作的单位
// gas used 真正使用的数量
// gas price 是愿意花多少钱在每个 gas 上，在 EIP-4844，Dencun 升级之后202403

// gas limit 是用户最多愿意支付的 total amount，由用户设置
// block gas limit 是一个区块中最多可以包含的 gas，由网络设置

contract Gas {
    uint256 public i = 0;

    // gas 用光之后，如果合约还没跑完，那么交易失败
    // 同时状态不改变
    // gas 不返还

    function forever_loop() public {
        while (true) {
            i += 1;
        }
    }
    // transact to Gas.forever_loop errored: Error occurred: out of gas.
    // out of gas
    //      The transaction ran out of gas. Please increase the Gas Limit.
    // If the transaction failed for not having enough gas, try increasing the gas limit gently.

    // gas 优化固然重要，但是合约的逻辑安全更重要
}
