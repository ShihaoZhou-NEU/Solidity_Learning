// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Todos{
    // Structs can be declared outside of a contract and imported in another contract.
    // 跟别的自定义类型，或者ENUM一样可以放在别的文件中，用import实现
    struct Todo{
        string text;
        bool completed;
    }


    Todo[] public todos;

    function create(string calldata _text) public{
        // 三种初始化一个 Struct 的方法
        todos.push(Todo(_text,false));

        todos.push(Todo({text: _text, completed: false}));

        Todo memory todo;
        todo.text = _text;
        todos.push(todo);
    }

    // Solidity 会自动创建一个 getter，所以其实不需要写这个 get()
    // 但是自定义的可以加别的逻辑在里面，处理get
    function get(uint256 _index) public view returns(string memory text, bool completed){
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }

    function update(uint256 _index, string calldata _text) public {
        Todo storage todo = todos[_index];
        todo.text = _text;

        // todos[_index].text = _text; <- 为什么不能像这样赋值？
        // 1. 没有 storage 的话，引用不明确，这是可以做但是不推荐（storage 是直接引用指向原始版本，不是副本）
        // 2. 如果重复读取，gas 比较高
    }

    function toggleCompleted(uint256 _index) public{
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }
}