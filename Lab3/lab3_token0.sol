// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract token0 is ERC20, ERC20Permit {
    constructor() ERC20("token0", "N0C") ERC20Permit("token0") {
        _mint(msg.sender, 100000000_000000_000000_000000);
    }

    //supply control related functions
    function mint(address target, uint256 amount) external {
        _mint(target, amount);
    }
    function burn(address target, uint256 amount) external {
        _burn(target, amount);
    }
}