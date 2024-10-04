// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter, publicInputHash} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
    }

    function test_value() public view {
        (bytes32 publicInputHashOld, bytes32 publicInputHashNew) = counter.calcPublicInputHash();
        console.logString("publicInputHashNew:");
        console.logBytes32(publicInputHashNew);
        console.logString("publicInputHashOld:");
        console.logBytes32(publicInputHashOld);
        console.logString("publicInputHash:");
        console.logBytes32(publicInputHash);
        assertEq(publicInputHash, publicInputHashOld);
    }
}
