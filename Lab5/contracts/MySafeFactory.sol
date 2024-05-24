// SPDX-License-Identifier: MIT
pragma solidity >=0.6.12 <0.9.0;

import "@openzeppelin/contracts/proxy/Clones.sol"; //follow openzeppelin's proxy cloning method
import "@openzeppelin/contracts/utils/Create2.sol"; //also follows openzeppelin's create2 method
import "./MyOwnSafe.sol";
import "./MyOwnSafeUpgradeable.sol";

contract MyOwnSafeFactory {
    address public implementation; //used to create proxies/clones of this contract.

    event SafeDeployed(address indexed newSafeDeployed);
    event SafeDeployedwithCreate2(address indexed newCreate2Deployed);
    event SafeDeployedUpgradeable(address indexed newSafeDeployedUpgradeable);
    event SafeDeployedUpgradeablewithCreate2(address indexed newCreate2DeployedUpgradeable);

    constructor() {
        //stores the address of a new MyOwnSafeUpgradeable contract.
        implementation = address(new MyOwnSafeUpgradeable()); 
    }

    function deploySafe(address _owner) public returns (address) {
        //use the 'new' keyword to deploy new MyOwnSafe instance
        MyOwnSafe newSafe = new MyOwnSafe(_owner); 
        emit SafeDeployed(address(newSafe));
        return address(newSafe);
    }

    function deploySafeWithCreate2(address _owner) public returns (address) {
        //creates a salt that uses the owner's address and the block's timestamp to ensure a deterministic address
        bytes32 salt = keccak256(abi.encodePacked(_owner, block.timestamp));
        //uses openzeppelin's library for Create2 to deploy new instance.
        address newCreate2 = Create2.deploy(0, salt, abi.encodePacked(type(MyOwnSafe).creationCode, abi.encode(_owner)));
        emit SafeDeployedwithCreate2(newCreate2);
        return newCreate2;
    }

    function deploySafeUpgradeable(address _owner) public returns (address) {
        //proxy deployment, uses openzeppelin's clone library to deploy a MyOwnSafeUpgradeable instance.
        address clone = Clones.clone(implementation);
        MyOwnSafeUpgradeable(clone).initialize(_owner);
        emit SafeDeployedUpgradeable(clone);
        return clone;
    }

    function deploySafeUpgradeableWithCreate2(address _owner) public returns (address) {
        //minimal proxy, makes use of cloneDeterministic function to deploy new MyOwnSafeUpgradeable instance.
        bytes32 salt = keccak256(abi.encodePacked(_owner, block.timestamp));
        address clone = Clones.cloneDeterministic(implementation, salt);
        MyOwnSafeUpgradeable(clone).initialize(_owner);
        emit SafeDeployedUpgradeablewithCreate2(clone);
        return clone;
    }
}