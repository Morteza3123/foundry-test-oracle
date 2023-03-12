// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/test/MockV3Aggregator.sol";
import "../src/PriceConsumerV3.sol";


contract OracleTest is Test {
    MockV3Aggregator public oracle; // oracle(mock_v3_aggregator) contract
    PriceConsumerV3 public consumer; // consumer contract which uses oracle data

    //deploy oracle and consumer contracts
    function setUp() public {
        // Create a new oracle
        oracle = new MockV3Aggregator(
            18, //decimals
            1   //initial data
        );
        // Create a new consumer
        consumer = new PriceConsumerV3(
            address(oracle)
        );
    }

    // test calling oracle data
    function testCallOracleData() public {
        int price = consumer.getLatestPrice(); //call oracle price from consumer
        assertEq(price, 1); //price should be 1 (initialized data)
    }

    //test changing the oracle data
    function testChangeOracleData() public {
        oracle.updateAnswer(2); //change oracle data from 1 to 2
        int price = consumer.getLatestPrice(); //call oracle price from consumer
        assertEq(price, 2); //price should be 2 (new data)
    }
}