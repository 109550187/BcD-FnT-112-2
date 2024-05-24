// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

//deploy a simple token contract. made using openzeppelin's wizard.
contract MyOwnToken is ERC20 {
    constructor() ERC20("MyOwnToken", "OWN") {
        _mint(msg.sender, 100000 * 10 ** decimals());
    }
}