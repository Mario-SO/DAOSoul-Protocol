// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

import {DAOSoul} from "src/DAOSoul.sol"
import {DAOSoulFactory} from "src/DAOSoulFactory.sol"

contract CounterScript is Script {
    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        soul = new DAOSoul();
        factory = new DAOSoulFactory()
        vm.stopBroadcast();
    }
}
