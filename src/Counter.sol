// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public number;
    address public owner;

    //deployer is set as the owner
    constructor() {
        owner = msg.sender;
    }

    function setNumber(uint256 newNumber) public {
        //owner can only set the number
        require(msg.sender == owner, "Only owner can set a number");
        number = newNumber;
    }

    function increment() public {
        number++;
    }

    function decrement() public {
        number--;
    }
}
