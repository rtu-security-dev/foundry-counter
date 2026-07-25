Project Status: Complete – July 2026

# Foundry Counter

    Using Foundry a very simply smart counter contract was built. Helped to learn Solidity testing, access controls and fundamentals of fuzz testing.

## Table of Content
    - [Overview](#overview)
    - [Structure of project](#structure-of-project)
    - [Pre-requisites](#pre-requisites)
    - [Installation](#installation)
    - [Contract Usage](#contract-usage)
    - [Details of contract](#details-of-contract)
    - [Test Coverage](#test-coverage)
    - [Key Learnings](#key-learnings)
    - [License](#license)

---------------

## Overview 

    The following featues were used to setup the contract: Only owner can set a number, anyone can increment and decrement a number. 

    The purpose of the contract:
        1. Practice writing .sol files in Foundry
        2. Use 'forge test' on unit and fuzz tests
        3. Use 'vm.prank' and 'vm.expectRevert' to control access
        4. Test overflow/underflow
        5. Test boundary values

---------------

## Structure of project

    The project has a smart contract inside src/, a test suite inside test/, a deployment script inside script/. It also consists of a foundry configuration file and a README.md

---------------

## Pre-requisites

    1. Foundry instaled on machine
    2. Basic understanding of Solidity
    3. Basic understanding of smart contracts

---------------

## Installation

    The repository can be cloned and dependecies can be installed in this manner:
        \`\`\` bash
        git clone <url_of_repository>
        cd foundry-counter
        forge install
        \`\`\`

---------------

## Contract Usage 

    The following commands can be used to:
    1. Compile the smart contract
         \`\`\` bash
         forge build
          \`\`\`
    2. Run all tests
         \`\`\` bash
         forge test
          \`\`\`
    3. Run tests while showing all test names (verbose output)
         \`\`\` bash
         forge test -vvv
          \`\`\`
    4. Run a specific test
         \`\`\` bash
         forge test --match-test <function_name> -vvv
          \`\`\`

    5. Run fuzz test for a certain number of runs
         \`\`\` bash
         forge test --fuzz-runs <amount_of_runs>
          \`\`\`
    6. Generate gas report for all functions
         \`\`\` bash
         forge test --gas-report
          \`\`\`


---------------

## Details of contract

    The Counter.sol has the following functions:
    1. setNumber(uint256) - (public) The counter can be set any number by the owner only
    2. increment() - (public) Anyone can increment counter value by 1 
    3. decrement() - (public) Anyone can decrement counter value by 1 
    4. number() - (public view) Returns current counter value
    5. owner() - (public view) Returns address of the current owner 

---------------

## Test Coverage 

    The test suite covers the following:
    1. Unit Tests - tests basic functionality of the functions
    2. Fuzz Tests - test random values with and without the use of 'vm.assume'
    3. Acess Control Tests - tests function accessibility using 'vm.prank' and 'vm.expectedRevert'
    4. Overflow/Underflow Tests - tests builtin functions in Solidity 0.8+ for over/underflowing 
    5. Boundary Tests - tests edge cases that might be exploited 
    6. Multiple Operation Tests - tests with a sequence of operations to ensure consistency 

---------------

## Key Learnings 

    1. 'vm.assume()' - helps fuzz inputs satisfy a condition
    2. 'vm.prank()' - acts as the next caller address
    3. 'vm.expectRevert()' - the process is expected to fail
    4. 'fail_on_revert' - controls whether fuzz tests fails on a revert
    5. Solidity 0.8+ has built-in protection for under/overflows
    6. Always test edge cases using boundary testing 

---------------

## License 
    
    This project is for educational purposes and can be used and modified. 
