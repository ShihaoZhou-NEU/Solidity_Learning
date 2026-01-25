// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract checkError {
    // You can throw an error by calling require, revert or assert.

    // require is used to validate inputs and conditions before execution.
    // revert is similar to require. See the code below for details.
    // assert is used to check for code that should never be false. Failing assertion probably means that there is a bug.
    // Use custom error to save gas.
    function testRequire(uint256 _i) public pure {
        require(_i > 10, "i should be greater than 10.");
        // 不满足前面的条件，报错
    }

    function testRevert(uint256 _i) public pure {
        if (_i < 10) {
            revert("Input must be greater than 10");
        }
    }

    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function testInsufficientBalance(uint256 _withdrawAmount) public view {
        uint256 bal = address(this).balance;
        if (bal < _withdrawAmount) {
            revert InsufficientBalance({
                balance: bal,
                withdrawAmount: _withdrawAmount
            });
        }
    }
}
