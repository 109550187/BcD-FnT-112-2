Blockchain Development and Financial Technology Lab#5:

- initialize a MyOwnSafe, MyOwnSafeUpgradeable, and MyOwnToken from the contract given in the lab website.
- initialize a MyOwnSafeFactory solidity contract according to the lab requirements (include 4 functions)
- initialize a hardhat project (using https://hardhat.org/hardhat-runner/docs/guides/project-setup as ref.)
- install dependency needed for contracts.
- write the test files for each contract making use of Solidity Test Coverage. (using https://hardhat.org/hardhat-runner/docs/guides/test-contracts as ref.)
- use hardhat-gas-reporter to assess gas usage of each function
- please note that i have not attached the node_modules folder here because apparently it has waaay too many files and folders inside of it. shouldn't be a problem i think..

result of coverage:
Version
> solidity-coverage: v0.8.12

Instrumenting for coverage...

> Lock.sol
> MyOwnSafe.sol
> MyOwnSafeUpgradeable.sol
> MyOwnToken.sol
> MySafeFactory.sol

Compilation:

Nothing to compile

Network Info
> HardhatEVM: v2.22.4
> network:    hardhat



  Lock
    Deployment
      ✔ Should set the right unlockTime (58ms)
      ✔ Should set the right owner
      ✔ Should receive and store the funds to lock
      ✔ Should fail if the unlockTime is not in the future
    Withdrawals
      Validations
        ✔ Should revert with the right error if called too soon
        ✔ Should revert with the right error if called from another account
        ✔ Shouldn't fail if the unlockTime has arrived and the owner calls it
      Events
        ✔ Should emit an event on withdrawals
      Transfers
        ✔ Should transfer the funds to the owner

  MyOwnSafe
    ✔ Should be deployed with correct owner
    ✔ Should revert if not correct deployer
    ✔ Should withdraw correct amounts of token
    ✔ Should call count only with owner
    ✔ Should only increment counter with owner

  MyOwnSafeUpgradeable
    ✔ Should be deployed with correct owner
    ✔ Should be reverted if initialized
    ✔ Should revert if not correct deployer
    ✔ Should withdraw correct amounts of token
    ✔ Should call count only with owner
    ✔ Should only increment counter with owner

  MyOwnToken
    ✔ Should have correct name, symbol
    ✔ Should mint the initial supply to the owner

  MyOwnSafeFactory
    ✔ Should set Implementation correctly
    ✔ Should deploy a non-upgradeable safe
    ✔ Should deploy a non-upgradeable safe with Create2
    ✔ Should deploy an upgradeable safe
    ✔ Should deploy an upgradeable safe with Create2


  27 passing (468ms)

---------------------------|----------|----------|----------|----------|----------------|
File                       |  % Stmts | % Branch |  % Funcs |  % Lines |Uncovered Lines |
---------------------------|----------|----------|----------|----------|----------------|
 contracts\                |      100 |      100 |      100 |      100 |                |
  Lock.sol                 |      100 |      100 |      100 |      100 |                |
  MyOwnSafe.sol            |      100 |      100 |      100 |      100 |                |
  MyOwnSafeUpgradeable.sol |      100 |      100 |      100 |      100 |                |
  MyOwnToken.sol           |      100 |      100 |      100 |      100 |                |
  MySafeFactory.sol        |      100 |      100 |      100 |      100 |                |
---------------------------|----------|----------|----------|----------|----------------|
All files                  |      100 |      100 |      100 |      100 |                |
---------------------------|----------|----------|----------|----------|----------------|

result of gas reports:
·-------------------------------------------------------------|----------------------------|-------------|-----------------------------·
|                    [90mSolc version: 0.8.24[39m                     ·  [90mOptimizer enabled: false[39m  ·  [90mRuns: 200[39m  ·  [90mBlock limit: 30000000 gas[39m  │
······························································|····························|·············|······························
|  [32m[1mMethods[22m[39m                                                                                                                             │
·························|····································|··············|·············|·············|···············|··············
|  [1mContract[22m              ·  [1mMethod[22m                            ·  [32mMin[39m         ·  [32mMax[39m        ·  [32mAvg[39m        ·  [1m# calls[22m      ·  [1musd (avg)[22m  │
·························|····································|··············|·············|·············|···············|··············
|  [90mLock[39m                  ·  withdraw                          ·           -  ·          -  ·      34096  ·            [90m7[39m  ·          [32m[90m-[32m[39m  │
·························|····································|··············|·············|·············|···············|··············
|  [90mMyOwnSafe[39m             ·  count                             ·       [36m28510[39m  ·      [31m45610[39m  ·      34210  ·            [90m3[39m  ·          [32m[90m-[32m[39m  │
·························|····································|··············|·············|·············|···············|··············
|  [90mMyOwnSafe[39m             ·  withdraw                          ·           -  ·          -  ·      41196  ·            [90m2[39m  ·          [32m[90m-[32m[39m  │
·························|····································|··············|·············|·············|···············|··············
|  [90mMyOwnSafeFactory[39m      ·  deploySafe                        ·           -  ·          -  ·     344718  ·            [90m3[39m  ·          [32m[90m-[32m[39m  │
·························|····································|··············|·············|·············|···············|··············
|  [90mMyOwnSafeFactory[39m      ·  deploySafeUpgradeable             ·           -  ·          -  ·     114757  ·            [90m3[39m  ·          [32m[90m-[32m[39m  │
·························|····································|··············|·············|·············|···············|··············
|  [90mMyOwnSafeFactory[39m      ·  deploySafeUpgradeableWithCreate2  ·           -  ·          -  ·     115452  ·            [90m2[39m  ·          [32m[90m-[32m[39m  │
·························|····································|··············|·············|·············|···············|··············
|  [90mMyOwnSafeFactory[39m      ·  deploySafeWithCreate2             ·           -  ·          -  ·     350523  ·            [90m3[39m  ·          [32m[90m-[32m[39m  │
·························|····································|··············|·············|·············|···············|··············
|  [90mMyOwnSafeUpgradeable[39m  ·  count                             ·       [36m28510[39m  ·      [31m45610[39m  ·      34210  ·            [90m3[39m  ·          [32m[90m-[32m[39m  │
·························|····································|··············|·············|·············|···············|··············
|  [90mMyOwnSafeUpgradeable[39m  ·  initialize                        ·           -  ·          -  ·      66399  ·            [90m6[39m  ·          [32m[90m-[32m[39m  │
·························|····································|··············|·············|·············|···············|··············
|  [90mMyOwnSafeUpgradeable[39m  ·  withdraw                          ·           -  ·          -  ·      41218  ·            [90m2[39m  ·          [32m[90m-[32m[39m  │
·························|····································|··············|·············|·············|···············|··············
|  [90mMyOwnToken[39m            ·  transfer                          ·       [36m52162[39m  ·      [31m52174[39m  ·      52168  ·            [90m4[39m  ·          [32m[90m-[32m[39m  │
·························|····································|··············|·············|·············|···············|··············
|  [32m[1mDeployments[22m[39m                                                ·                                          ·  [1m% of limit[22m   ·             │
······························································|··············|·············|·············|···············|··············
|  Lock                                                       ·           -  ·          -  ·     326112  ·        [90m1.1 %[39m  ·          [32m[90m-[32m[39m  │
······························································|··············|·············|·············|···············|··············
|  MyOwnSafe                                                  ·           -  ·          -  ·     365525  ·        [90m1.2 %[39m  ·          [32m[90m-[32m[39m  │
······························································|··············|·············|·············|···············|··············
|  MyOwnSafeFactory                                           ·           -  ·          -  ·    1346939  ·        [90m4.5 %[39m  ·          [32m[90m-[32m[39m  │
······························································|··············|·············|·············|···············|··············
|  MyOwnSafeUpgradeable                                       ·           -  ·          -  ·     417282  ·        [90m1.4 %[39m  ·          [32m[90m-[32m[39m  │
······························································|··············|·············|·············|···············|··············
|  MyOwnToken                                                 ·           -  ·          -  ·     972881  ·        [90m3.2 %[39m  ·          [32m[90m-[32m[39m  │
·-------------------------------------------------------------|--------------|-------------|-------------|---------------|-------------·
