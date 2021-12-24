// SPDX-License-Identifier: MIT
pragma solidity>=0.7.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract RanchToken is ERC20 {
    constructor() ERC20("Ranch Token", "RTK") {
        _mint(msg.sender, 100 * 10 **uint(decimals()));
    }
}