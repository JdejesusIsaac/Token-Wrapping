// SPDX-License-Identifier: MIT
pragma solidity>=0.7.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract FrenchToken is ERC20 {
    constructor() ERC20("French Token", "FTK") {
        _mint(msg.sender, 100 * 10 **uint(decimals()));
    }
}


