// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Counter, publicInputHash} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
    }

    function test_calc() public view {
        (bytes32 publicInputHashOld, bytes32 publicInputHashNew) = counter.calcPublicInputHash();
        console.logString("publicInputHashNew:");
        console.logBytes32(publicInputHashNew);
        console.logString("publicInputHashOld:");
        console.logBytes32(publicInputHashOld);
        console.logString("publicInputHash:");
        console.logBytes32(publicInputHash);
        assertEq(publicInputHash, publicInputHashOld);
    }

    function test_initial_calc() public view {
        bytes32 inputPublicHash = counter.calcInitialPublicInputHash(763374);
        bytes32 expectedHash = 0x902522c1891b96282f0177ab52585ecd8a4388106a68d57aaccbca2eeddb87d8;
        console.logString("inputPublicHash:");
        console.logBytes32(inputPublicHash);
        console.logString("expectedHash:");
        console.logBytes32(expectedHash);
        assertEq(inputPublicHash, expectedHash);
    }
}
