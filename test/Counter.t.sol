// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;
    address public owner;
    address public attacker;

    function setUp() public {
        counter = new Counter();
        owner = counter.owner();
        attacker = address(0xbad);
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
    function test_dcrementOf10() public {
        counter.setNumber(10);
        counter.decrement();
        assertEq(counter.number(), 9);
    }

    //Use vm.assume to aviod underflow
    function test_avoidUnderFlow(uint256 x) public {
        vm.assume(x > 0);
        counter.setNumber(x);
        counter.decrement();
        assertEq(counter.number(), x - 1);
    }

    //Use vm.expectRevert to avoid overflow (intentional)
    function test_expectedOverflow() public {
        counter.setNumber(type(uint256).max);
        vm.expectRevert();
        counter.increment();
    }

    //Use vm.expectRevert to avoid underflow (intentional)
    function test_expectedUnderflow() public {
        counter.setNumber(type(uint256).min);
        vm.expectRevert();
        counter.decrement();
    }

    //Testing Boundries//

    //Can the counter store 0
    function test_counterStoreOf0() public {
        counter.setNumber(0);
        assertEq(counter.number(), 0);
    }

    //Can the counter store the maximum value
    function test_counterMax() public {
        counter.setNumber(type(uint256).max);
        assertEq(counter.number(), type(uint256).max);
    }

    //Can the counter store 2
    function test_counterStoreOf2() public {
        counter.setNumber(2);
        assertEq(counter.number(), 2);
    }

    //Can the counter increment from 0 to 1
    function test_increment0To1() public {
        counter.setNumber(0);
        counter.increment();
        assertEq(counter.number(), 1);
    }

    //Can the counter decrement from 1 to 0
    function test_decrement1To0() public {
        counter.setNumber(1);
        counter.decrement();
        assertEq(counter.number(), 0);
    }

    //Can the counter increment from the maximum value
    function test_maximumIncrement() public {
        counter.setNumber(type(uint256).max - 1);
        counter.increment();
        assertEq(counter.number(), type(uint256).max);
    }

    //Can the counter decrement from the maximum value
    function test_maximumDecrement() public {
        counter.setNumber(type(uint256).max);
        counter.decrement();
        assertEq(counter.number(), type(uint256).max - 1);
    }

    //

    //Testing for multiple operations
    function test_multipleOperations() public {
        counter.setNumber(500);
        counter.increment(); //501
        counter.decrement(); //500
        counter.decrement(); //499
        counter.increment(); //500
        assertEq(counter.number(), 500);
    }
}
