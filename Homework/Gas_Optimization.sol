// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Gas_Optimization {
    // 在 EVM 中，每条指令都需要消耗固定的 gas，详情可参考：https://www.evm.codes/

    // ######################################################

    // 使用位压缩（Bit Packing）
    uint256 a;
    uint256 b;
    // 多个变量压缩到一个 uint256 中
    // 在允许的情况下，可以使用更小的数据类型
    struct Packed {
        uint256 a_op;
        uint256 b_op;
    }

    // ######################################################

    // 减少存储操作（Storage Write）
    mapping(address => uint256) public balances;
    // 非优化
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    // 伪代码表示 EVM 操作
    //     1. SLOAD balance_slot  // 读取当前余额到栈（第一次读）
    //     2. CALLVALUE          // 获取 msg.value
    //     3. ADD                // 计算 newBalance = oldBalance + msg.value
    //     4. SLOAD balance_slot  // 再次读取当前余额（冗余的第二次读）
    //     5. SSTORE balance_slot // 存储新值（一次写）

    // 为什么会有 两次读取？这是因为 Solidity 编译器在处理 += 操作符时：
    //     首先读取当前值用于计算
    //     然后由于映射的特性，需要再次确认存储位置
    //     最后写入新值

    // Gas 消耗（近似值）：
    //     第一次 SLOAD: ~2100 gas（如果是冷访问）
    //     第二次 SLOAD: ~100 gas（如果是热访问）
    //     最后一次 SSTORE: 20000 gas（如果是从 0 到非 0）

    // 优化写法
    function deposit_op() public payable {
        uint256 current_balance = balances[msg.sender];
        balances[msg.sender] = current_balance + msg.value;
    }
    // 伪代码表示 EVM 操作
    //     1. SLOAD balance_slot  // 读取当前余额到栈（一次读）
    //     2. CALLVALUE          // 获取 msg.value
    //     3. ADD                // 计算 newBalance = oldBalance + msg.value
    //     4. SSTORE balance_slot // 存储新值（一次写）

    // ######################################################

    // 循环优化
    uint256[] public arr = [1,2,3,4,5,6,7,8,9,10];
    function loop() public view returns(uint256) {
        // ❌ 非优化
        uint sum = 0;
        for (uint256 i = 0; i < arr.length; i++) {
            sum += arr[i];
        }
        return sum;
        // EVM 操作分析：
        //     每次迭代都需要重新获取 arr.length
        //     这会产生一个 LOAD/MLOAD/SLOAD 操作码，取决于 arr 的数据位置
        //     编译器无法自动优化这个读取，因为循环可能会修改数组长度
    }

    function loop_op() public view returns(uint256){
        // ✅ 优化
        uint sum = 0;
        uint256 len = arr.length;
        for (uint i = 0; i < len; ++i) {
            sum += arr[i];
        }
        return sum;
        // EVM 操作分析：
        //     只在循环开始前读取一次长度
        //     每次迭代检查 i < len 时使用栈变量（几乎零成本）
    }

    // ######################################################

    // 函数可见性选择
    // external 比 public 更节省 gas，适用于仅被外部调用的函数。
}
