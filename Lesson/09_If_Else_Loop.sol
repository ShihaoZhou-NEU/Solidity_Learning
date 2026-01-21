// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract IfElseLoop {
    function foo(uint256 x) public pure returns (uint256) {
        if (x < 10) {
            return 0;
        } else {
            return 1;
        }

        // return x < 10 ? 0 : 2; ternary operator
    }

    function loop(uint256 i) public pure returns (uint256) {
        for (i; i < 10; i++) {
            if (i == 5) {
                continue;
            }
            if (i == 7) {
                break;
            }
        }

        while (i < 20) {
            i++;
        }
        return i;
    }
}
