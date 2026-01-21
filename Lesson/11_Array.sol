// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Array {
    uint256[] public arr;
    uint256[] public arr2 = [1, 2, 3, 4, 5];
    uint256[10] public arr3; // 会默认生成一个固定10长度的默认值为0的数组

    function get(uint256 i) public view returns (uint256) {
        return arr[i];
    }

    function getArr() public view returns (uint256[] memory) {
        // 这个方法要避免，有可能返回一个很长的数组，导致消耗大量 gas
        return arr;
        // 1. 可以直接索引访问单个元素
        // 2. 可以分页 offset limit
    }

    function push(uint256 i) public {
        arr.push(i);
    }

    function pop() public {
        // 弹出最后的元素
        // 无法取到弹出的元素
        arr.pop();
    }

    function getLength() public view returns (uint256) {
        return arr.length;
    }

    function remove(uint256 index) public {
        delete arr[index];
        // reset 这个index上的值到默认值
    }

    function example() external pure {
        // 创建一个放在 memory 的数组，这个数组一定要是固定长度的
        uint256[] memory a = new uint256[](5);

        uint256[][] memory b = new uint256[][](2);
        // 禁止的行为：以下操作在 memory 数组中都是不允许的，会导致编译错误
        // tempArr.push(30);     // 错误：memory数组不能使用push
        // tempArr.pop();        // 错误：memory数组不能使用pop
        // tempArr.length = 5;   // 错误：memory数组长度不可变
        uint256 b_len = b.length;
        for (uint256 i = 0; i < b_len; i++) {
            b[i] = new uint256[](3);
        }

        uint256 n = 10;
        for (uint256 i = 0; i < 2; i++) {
            for (uint256 j = 0; j < 3; j++) {
                b[i][j] = n;
                n--;
            }
        }
    }
}

contract ArrayRemoveByShifting {
    uint256[] public arr;
    // [1, 2, 3] -- remove(1) --> [1, 3, 3] --> [1, 3]
    // [1, 2, 3, 4, 5, 6] -- remove(2) --> [1, 2, 4, 5, 6, 6] --> [1, 2, 4, 5, 6]
    // [1, 2, 3, 4, 5, 6] -- remove(0) --> [2, 3, 4, 5, 6, 6] --> [2, 3, 4, 5, 6]
    // [1] -- remove(0) --> [1] --> []

    function remove(uint256 _index) public {
        // 删除当前 index 的元素，其实是将该元素之后的所有元素向前移动一位，最后弹出最后一个元素
        require(_index < arr.length, "index out of bounds");
        uint256 arr_length = arr.length;
        for (uint256 i = 0; i < arr_length; i++) {
            arr[i] = arr[i + 1];
        }
        arr.pop();
    }

    function test() external {
        arr = [1, 2, 3, 4, 5];
        remove(2);
        // [1, 2, 4, 5]
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        assert(arr.length == 4);

        arr = [1];
        remove(0);
        // []
        assert(arr.length == 0);
    }
}


contract ArrayReplaceFromEnd{
    uint256[] public arr;

    function remove(uint256 _index) public{
        arr[_index] = arr[arr.length - 1];
        arr.pop();
    }
    // [1,2,3,4,5]
    // remove(1)
    // [1,5,3,4]
    // 是否需要删除数组元素？
    //         ↓
    // 业务逻辑是否要求保持严格顺序？
    //         ↓
    // 是 → 使用【传统移位法】（for循环）
    //         ↓
    // 否 → 使用【末尾替换法】（Swap and Pop）← 更省Gas
    //         ↓
    // 添加必要的安全检查（索引检查等）
}