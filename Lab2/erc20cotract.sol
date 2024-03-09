// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract NICHcoin is ERC20, ERC20Permit {
    //deploy two special addresses
    address censor;
    address master;
    mapping(address => bool) private _blacklist;

    //assign two special addresses to deployer
    constructor() ERC20("NICHcoin", "NTC") ERC20Permit("NICHcoin") {
        _mint(msg.sender, 100000000_000000_000000_000000);
        censor = msg.sender;
        master = msg.sender;
    }

    //set modifiers for role related functions
    modifier onlyMaster() {
        require(msg.sender == master);
        _;
    }
    modifier bothMasterCensor() {
        require(msg.sender == master || msg.sender == censor);
        _;
    }

    //set role related functions
    function changeMaster(address newMaster) external onlyMaster {
        master = newMaster;
    }
    function changeCensor(address newCensor) external onlyMaster {
        censor = newCensor;
    }

    //censoship functions
    function setBlacklist(address target, bool blacklisted) external bothMasterCensor {
        _blacklist[target] = blacklisted;
    }
    function clawBack(address target, uint256 amount) external onlyMaster {
        _transfer(target, master, amount);
    }

    //supply control related functions
    function mint(address target, uint256 amount) external onlyMaster {
        _mint(target, amount);
    }
    function burn(address target, uint256 amount) external onlyMaster {
        _burn(target, amount);
    }
}