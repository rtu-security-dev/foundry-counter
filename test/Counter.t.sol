// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function test_SetAndIncrement() public {
        counter.setNumber(32);
        counter.increment();
        assertEq(counter.number(), 33);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }

    //Use vm.assume to set a range
    function test_setRange(uint256 x) public {
        vm.assume(x >= 1 && x <= 20);
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }

    //Use vm.assume to not allow 50 and 100
    function test_notAllowed(uint256 x) public {
        vm.assume(x != 50 && x != 100);
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }

    //Use vm.assume to allow even numbers only
    function test_evenNo(uint256 x) public {
        vm.assume(x % 2 == 0);
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }

    //Use vm.assume to filter values so it wont overflow
    function test_avoidOverflow(uint256 x) public {
        vm.assume(x < type(uint256).max);
        counter.setNumber(x);
        counter.increment();
        assertEq(counter.number(), x + 1);
    }

    //Test decrement function with number 10
    function test_dcrementOf10() public{
        counter.setNumber(10);
        counter.decrement();
        assertEq(counter.number(), 9);
    }
}
