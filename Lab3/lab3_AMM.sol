// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract amm187{
    IERC20 public immutable token0;
    IERC20 public immutable token1;
    uint256 public reserve0;
    uint256 public reserve1;
    uint256 public totalSupply;
    uint256 conversionRate = 5000;
    mapping(address=>uint256) private balanceOf;

    constructor(address _token0, address _token1) {
        //both token0 and token1 are deployed in each contracts
        //both addresses are provided as arguments in constructor.
        // _token0 = 0xF252AbfA9CDA4FAb3dd5f8b3861360ad487145f4; 
        // _token1 = 0xF8460aa3348eBd8eCaC9DBBe4BC1dAc90Ded210E;
        token0 = IERC20(_token0);
        token1 = IERC20(_token1);
    }

    function _update(uint256 _reserve0, uint256 _reserve1) internal  {
        reserve0 = _reserve0;
        reserve1 = _reserve1;
        totalSupply = reserve0 + reserve1 * 10000 / conversionRate;
    }
    
    function mintInitial() external {
        _update(token0.balanceOf(address(this)), token1.balanceOf(address(this)));
    }

    function trade(address tokenFrom, uint256 fromAmount) external payable {
        require(tokenFrom == address(token0) || tokenFrom == address(token1) , "unrecognized token");
        require(fromAmount > 0, "fromAmount = 0");
        
        bool isToken0 = tokenFrom == address(token0);
        uint256 token0Amount = fromAmount * conversionRate / 10000;
        uint256 token1Amount = fromAmount * 10000 / conversionRate;

        (IERC20 tokenIn, IERC20 tokenOut, uint256 reserveOut, uint256 AmountOut) = isToken0 ?
        (token0, token1, reserve1, token0Amount) : (token1, token0, reserve0, token1Amount);

        //function should revert if outgoing token is not enough
        require(AmountOut <= reserveOut, "outgoing token not enough");

        tokenIn.approve(address(this), fromAmount);
        tokenIn.transferFrom(address(this), msg.sender, fromAmount);
        tokenOut.transfer(msg.sender, AmountOut);
        _update(token0.balanceOf(address(this)), token1.balanceOf(address(this)));
    }

    function provideLiquidity(uint256 token0Amount, uint256 token1Amount) external payable {
        token0.transfer(msg.sender, token0Amount);
        token1.transfer(msg.sender, token1Amount);
        
        uint256 Amount0to1 = token0Amount * reserve1 / reserve0;
        uint256 Amount1to0 = token1Amount * reserve0 / reserve1;
        //DEX should only take funds according to current ratio of assets
        if (Amount1to0 > token0Amount) {
            Amount1to0 = token0Amount;
        }
        else if (Amount0to1 > token1Amount) {
            Amount0to1 = token1Amount;
        }

        require(Amount1to0 > 0 || Amount0to1 > 0, "amount0 or amount1 = 0");

        balanceOf[msg.sender] = Amount1to0 + Amount0to1 * 10000 / conversionRate;
        token0.transfer(msg.sender, Amount1to0);
        token1.transfer(msg.sender, Amount0to1);
        _update(token0.balanceOf(address(this)), token1.balanceOf(address(this)));
    }

    function withdrawLiquidity() external payable {
        require(balanceOf[msg.sender] > 0, "you don't have any share available");
        uint256 bal0 = reserve0 * balanceOf[msg.sender] / totalSupply;
        uint256 bal1 = reserve1 * balanceOf[msg.sender] / totalSupply;
        token0.transfer(msg.sender, bal0);
        token1.transfer(msg.sender, bal1);
        _update(token0.balanceOf(address(this)), token1.balanceOf(address(this)));
    }
}