// SPDX-License-Identifier: MIT
pragma solidity>=0.7.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract WrapperToken is ERC20, Ownable {
    constructor() ERC20("Wrapper Token", "WTK") {
        _mint(msg.sender, 100 * 10**uint256(decimals()));
    }

    function mint(address _recipient, uint256 _amount) external onlyOwner {
        _mint(_recipient, _amount);
    }

    function burn(address _account, uint256 _amount) external onlyOwner {
        _burn(_account, _amount);
    }
}
