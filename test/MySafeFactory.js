const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MyOwnSafeFactory", function () {
  let MySafeFactory, mySafeFactory, MyOwnSafeUpgradeable, myOwnSafeUpgradeable, owner, addr1, addr2;

  beforeEach(async function () {    
    //MyOwnSafeUpgradeable = await ethers.getContractFactory("MyOwnSafeUpgradeable");
    //myOwnSafeUpgradeable = await MyOwnSafeUpgradeable.deploy();
    //await myOwnSafeUpgradeable.waitForDeployment();
    //await myOwnSafeUpgradeable.initialize(owner.address);

    //waits for contract to deploy.
    MySafeFactory = await ethers.getContractFactory("MyOwnSafeFactory");
    [owner, addr1] = await ethers.getSigners();
    mySafeFactory = await MySafeFactory.deploy();
    await mySafeFactory.waitForDeployment();
  });

  it("Should set Implementation correctly", async function () {
    const implementation = await mySafeFactory.implementation();
    expect(implementation).to.properAddress;
    });

  // Test whether the first non-upgradeable safe is deployed correctly or not
  it("Should deploy a non-upgradeable safe", async function () {
    const tx = await mySafeFactory.deploySafe(addr1.address);
    const receipt = await tx.wait();
    //const event = receipt.events.find(event => event.event === 'SafeDeployed');
    //const newSafeAddress = event.args.newSafeDeployed;

    expect(tx).to.emit(mySafeFactory, "SafeDeployed").withArgs(addr1.address);
  });

  // Test whether the second non-upgradeable safe is deployed correctly or not
  it("Should deploy a non-upgradeable safe with Create2", async function () {
    const tx = await mySafeFactory.deploySafeWithCreate2(owner.address);
    const receipt = await tx.wait();
    //const event = receipt.events.find(event => event.event === 'SafeDeployedwithCreate2');
    //const newSafeAddress = event.args.newCreate2Deployed;

    expect(tx).to.emit(mySafeFactory, "SafeDeployedwithCreate2").withArgs(addr1.address);
  });

  // Test whether the first upgradeable safe is deployed correctly or not
  it("Should deploy an upgradeable safe", async function () {
    const tx = await mySafeFactory.deploySafeUpgradeable(owner.address);
    const receipt = await tx.wait();
    //const event = receipt.events.find(event => event.event === 'SafeDeployedUpgradeable');
    //const newSafeAddress = event.args.newSafeDeployedUpgradeable;

    expect(tx).to.emit(mySafeFactory, "SafeDeployedUpgradeable").withArgs(addr1.address);
  });

  // Test whether the second upgradeable safe is deployed correctly or not
  it("Should deploy an upgradeable safe with Create2", async function () {
    const tx = await mySafeFactory.deploySafeUpgradeableWithCreate2(owner.address);
    const receipt = await tx.wait();
    //const event = receipt.events.find(event => event.event === 'SafeDeployedUpgradeablewithCreate2');
    //const newSafeAddress = event.args.newCreate2DeployedUpgradeable;

    expect(tx).to.emit(mySafeFactory, "SafeDeployedUpgradeablewithCreate2").withArgs(addr1.address);
  });
});
