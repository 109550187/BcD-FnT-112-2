const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MyOwnToken", function () {
  let MyOwnToken, MyToken, owner, addr1, addr2;

  beforeEach(async function () {
    MyOwnToken = await ethers.getContractFactory("MyOwnToken"); //get token factory
    [owner, addr1, addr2, _] = await ethers.getSigners(); //get signers for testing
    MyToken = await MyOwnToken.deploy(); //deploy token contract
    await MyToken.waitForDeployment(); //wait for token contract deployment
  });
  
  // TEST CASES:

  // Test#1 : whether the name and symbol of the token are correct.
  it("Should have correct name, symbol", async function () {
    expect(await MyToken.name()).to.equal("MyOwnToken");
    expect(await MyToken.symbol()).to.equal("OWN");
  });

  // Test#2 : whether the initial supply to owner is correct.
  it("Should mint the initial supply to the owner", async function () {
    const ownerBalance = await MyToken.balanceOf(owner.address);
    expect(await MyToken.totalSupply()).to.equal(ownerBalance);
  });
});
