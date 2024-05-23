//require('dotenv').config();
//console.log(process.env.ZIRCUIT_PRIVATE_KEY);
require("@nomicfoundation/hardhat-toolbox");
require('solidity-coverage');
require('hardhat-gas-reporter');

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
  gasReporter: {
    currency: 'USD', 
    gasPrice: 11,
    outputFile: 'gas-report.txt',
    enabled: true,
  },
  coverage: {
    url: 'http://localhost:8555'
  },
};
