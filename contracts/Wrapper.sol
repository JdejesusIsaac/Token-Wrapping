// SPDX-License-Identifier: MIT
pragma solidity>=0.7.0;

import "./WrapperToken.sol";

//Users can swap two ERC20 TOKENS for a single token
// ex, you can swap token A(frenchToken) or token B(ranchToken) for token C (wrapperToken)
// Swaps are possble in reverse, token exchange rate 1to1
// wrappper contract is able to mint new Token c (wrapperToken) exclusively from inside,
// only wrapperToken can be minted inside.

contract Wrapper {
    WrapperToken internal wrapperToken;
    address public frenchToken;
    address public ranchToken;

    constructor(address _ranchToken, address _frenchToken) {
        wrapperToken = new WrapperToken();
        ranchToken = _ranchToken;
        frenchToken = _frenchToken;
    }

    modifier isSupportedToken(address _token) {
        require(
            _token == ranchToken || _token == frenchToken,
            "Unsupported ERC20 token"
        );
        _;
    }

    function swap(address _token, uint256 _amount)
        external
        isSupportedToken(_token)
    {
        require(
            IERC20(_token).balanceOf(msg.sender) >= _amount,
            "Insufficient balance"
        );
        require(
            IERC20(_token).allowance(msg.sender, address(this)) >= _amount,
            "Insufficent Allowance"
        );

        _safeTransferFrom(_token, msg.sender, _amount);
        wrapperToken.mint(msg.sender, _amount);
    }

    function unswap(address _token, uint256 _amount)
        external
        isSupportedToken(_token)
    {
        require(
            wrapperToken.balanceOf(msg.sender) >= _amount,
            "Insufficient balance"
        );

        _safeTransferFrom(msg.sender, address(wrapperToken), _amount);
        _safeTransferFrom(address(this), _token, _amount);

        // burn tokens since we have swapped back, regulating supply
        wrapperToken.burn(address(this), _amount);
    }

    

    function _safeTransferFrom(
        address _sender,
        address _token,
        uint256 _amount
    ) private {
        bool sent = IERC20(_token).transferFrom(
            _sender,
            address(this),
            _amount
        );
        require(sent, "Transaction failed");
    }


}
