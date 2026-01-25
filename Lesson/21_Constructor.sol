// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract contract_X {
    string text;

    constructor(string memory _text) {
        text = _text;
    }
}

contract contract_Y {
    string text_Y;
    constructor(string memory _text) {
        text_Y = _text;
    }
}

contract contract_B is contract_X("to X"), contract_Y("tp Y") {}

contract contract_C is contract_X, contract_Y {
    constructor(string memory _text) contract_X(_text) contract_Y(_text) {}
}
