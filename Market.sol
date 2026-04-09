// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Market
 * @dev Manages YES/NO shares for a specific prediction event.
 */
contract Market is Ownable {
    IERC20 public collateralToken;
    bool public resolved;
    bool public outcome; // true = YES, false = NO

    mapping(address => uint256) public yesShares;
    mapping(address => uint256) public noShares;

    event SharesPurchased(address indexed buyer, bool isYes, uint256 amount);
    event MarketResolved(bool finalOutcome);

    constructor(address _collateral) Ownable(msg.sender) {
        collateralToken = IERC20(_collateral);
    }

    /**
     * @dev Simple 1:1 minting for this template.
     */
    function buyShares(bool _isYes, uint256 _amount) external {
        require(!resolved, "Market already resolved");
        collateralToken.transferFrom(msg.sender, address(this), _amount);
        
        if (_isYes) yesShares[msg.sender] += _amount;
        else noShares[msg.sender] += _amount;
        
        emit SharesPurchased(msg.sender, _isYes, _amount);
    }

    function resolve(bool _finalOutcome) external onlyOwner {
        resolved = true;
        outcome = _finalOutcome;
        emit MarketResolved(_finalOutcome);
    }

    function redeem() external {
        require(resolved, "Not resolved yet");
        uint256 payout = outcome ? yesShares[msg.sender] : noShares[msg.sender];
        require(payout > 0, "Nothing to redeem");

        yesShares[msg.sender] = 0;
        noShares[msg.sender] = 0;
        collateralToken.transfer(msg.sender, payout);
    }
}
