const { expect } = require("chai");
const { ethers } = require("hardhat");
const {
    loadFixture,
} = require("@nomicfoundation/hardhat-toolbox/network-helpers");

describe("MyOwnSafeUpgradeable", function () {
    async function deployFixture() {
        const Token = await ethers.getContractFactory("MyOwnToken"); //deploy token contract
        const token = await Token.deploy();
        await token.waitForDeployment();

        const SafeContract = await ethers.getContractFactory("contracts/MyOwnSafeUpgradeable.sol:MyOwnSafeUpgradeable"); //deploy safe contract
        const safeContract = await SafeContract.deploy();
        await safeContract.waitForDeployment();

        const [owner, addr1, addr2] = await ethers.getSigners(); //get signers for testing

        return { safeContract, token, owner, addr1, addr2 };
    }
    beforeEach(async function () { //for recurring test cases
        ({ safeContract, token, owner, addr1, addr2 } = await loadFixture(deployFixture));
    });

    // TEST CASES
    // Test#1: check for correct deployment
    it("Should be deployed with correct owner", async function () {
        await safeContract.initialize(owner)
        expect(await safeContract.owner()).to.equal(owner.address);
    });
    // Test#2: check if reverts if initialized
    it("Should be reverted if initialized", async function () {
        await safeContract.initialize(owner)
        await expect(safeContract.initialize(owner)).to.be.revertedWith("initialized");
    });

    //function for token deposits
    async function depositTokens(token, amount, owner, from) {
        await token.connect(owner).transfer(from.address, ethers.parseUnits(amount, "wei"));
    }

    // Test#3: check if owner deployed
    it("Should revert if not correct deployer", async function () {
        await safeContract.initialize(owner)
        await depositTokens(token, "1000", owner, addr1);
        await expect(safeContract.connect(addr1).withdraw(token, ethers.parseUnits("1000", "wei"))).to.be.revertedWith("!owner");
    });

    // Test#4: check if withdraws of tokens are correct
    it("Should withdraw correct amounts of token", async function () {
        await safeContract.initialize(owner)
        await token.connect(owner).transfer(safeContract, ethers.parseUnits("100001", "wei"));

        const initialContractBalance = await token.balanceOf(safeContract);
        const initialOwnerBalance = await token.balanceOf(owner);
        const amount = ethers.parseUnits("1000", "wei");
        await expect(safeContract.connect(owner).withdraw(token, amount)).to.not.be.reverted;

        const finalContractBalance = await token.balanceOf(safeContract);
        const finalOwnerBalance = await token.balanceOf(owner);
 
        expect(finalContractBalance).to.equal(initialContractBalance - amount);
        expect(finalOwnerBalance).to.equal(initialOwnerBalance + amount);
    });

    // Test#5: check if count only calls if owner does it
    it("Should call count only with owner", async function () {
        await safeContract.initialize(owner)
        await expect(safeContract.connect(addr1).count()).to.be.revertedWith("!owner");
    });

    // Test#6: check if count function works as expected
    it("Should only increment counter with owner", async function () {
        await safeContract.initialize(owner)
        await safeContract.connect(owner).count();
        expect(await safeContract.connect(owner).count()).to.not.be.reverted;
    });
});
