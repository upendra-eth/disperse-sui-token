// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

#[test_only]
module disperse::disperse_tests{
    use disperse::disperse::{disperseToken, EMissmatchInput, ENotEnough};
    use sui::test_scenario::{Self};
    use sui::coin::{Self, Coin};
    use sui::sui::SUI;
    use mycoin::mycoin::MYCOIN;
    use sui::test_utils;

    const TEST_SENDER_ADDR: address = @0xA11CE;

    const TEST_ADDR1: address = @0xA;
    const TEST_ADDR2: address = @0xB;
    const TEST_ADDR3: address = @0xC;

   #[test]
    fun test_disperseToken_for_mycoin() {
        let scenario_val = test_scenario::begin(TEST_SENDER_ADDR);
        
        let scenario = &mut scenario_val;
        let ctx = test_scenario::ctx(scenario);
        let coin = coin::mint_for_testing<MYCOIN>(10, ctx);
        // vector of recipents addresses and amounts
        let recipients = vector[TEST_ADDR1, TEST_ADDR2];
        let values = vector[1, 2];

        test_scenario::next_tx(scenario, TEST_SENDER_ADDR);
        // Send 3 of 10
        disperseToken(coin, values, recipients, test_scenario::ctx(scenario));

        test_scenario::next_epoch(scenario, TEST_SENDER_ADDR); // needed or else we won't have a value for `most_recent_id_for_address` coming up next.
        let coin = test_scenario::take_from_address<Coin<MYCOIN>>(scenario, TEST_SENDER_ADDR);
        let coin1 = test_scenario::take_from_address<Coin<MYCOIN>>(scenario, TEST_ADDR1);
        let coin2 = test_scenario::take_from_address<Coin<MYCOIN>>(scenario, TEST_ADDR2);
        assert!(coin::value(&coin) == 7, 0);
        assert!(coin::value(&coin1) == 1, 0);
        assert!(coin::value(&coin2) == 2, 0);
        test_utils::destroy(coin);
        test_utils::destroy(coin1);
        test_utils::destroy(coin2);

        test_scenario::end(scenario_val);
    }

    #[test]
    #[expected_failure(abort_code = EMissmatchInput)]
    fun test_disperseToken_should_fail_for_mycoin_with_wrong_input() {
        let scenario_val = test_scenario::begin(TEST_SENDER_ADDR);
        
        let scenario = &mut scenario_val;
        let ctx = test_scenario::ctx(scenario);
        let coin = coin::mint_for_testing<MYCOIN>(10, ctx);
        // vector of recipents addresses and amounts
        let recipients = vector[TEST_ADDR1, TEST_ADDR2];
        let values = vector[1, 2, 7];

        test_scenario::next_tx(scenario, TEST_SENDER_ADDR);
   
        disperseToken(coin, values, recipients, test_scenario::ctx(scenario));
        test_scenario::end(scenario_val);
    }

    #[test]
    #[expected_failure(abort_code = ENotEnough)]
    fun test_disperseToken_fails_when_totalvalue_is_greater_than_balance() {
        let scenario_val = test_scenario::begin(TEST_SENDER_ADDR);
        
        let scenario = &mut scenario_val;
        let ctx = test_scenario::ctx(scenario);
        let coin = coin::mint_for_testing<MYCOIN>(10, ctx);
        // vector of recipents addresses and amounts
        let recipients = vector[TEST_ADDR1, TEST_ADDR2, TEST_ADDR3];
        let values = vector[1, 2, 8];

        test_scenario::next_tx(scenario, TEST_SENDER_ADDR);
   
        disperseToken(coin, values, recipients, test_scenario::ctx(scenario));
        test_scenario::end(scenario_val);
    }

     #[test]
    fun test_disperseToken_for_sui() {
        let scenario_val = test_scenario::begin(TEST_SENDER_ADDR);
        
        let scenario = &mut scenario_val;
        let ctx = test_scenario::ctx(scenario);
        let coin = coin::mint_for_testing<SUI>(10, ctx);
        // vector of recipents addresses and amounts
        let recipients = vector[TEST_ADDR1, TEST_ADDR2];
        let values = vector[1, 2];

        test_scenario::next_tx(scenario, TEST_SENDER_ADDR);
        // Send 3 of 10
        disperseToken(coin, values, recipients, test_scenario::ctx(scenario));

        test_scenario::next_epoch(scenario, TEST_SENDER_ADDR); // needed or else we won't have a value for `most_recent_id_for_address` coming up next.
        let coin = test_scenario::take_from_address<Coin<SUI>>(scenario, TEST_SENDER_ADDR);
        let coin1 = test_scenario::take_from_address<Coin<SUI>>(scenario, TEST_ADDR1);
        let coin2 = test_scenario::take_from_address<Coin<SUI>>(scenario, TEST_ADDR2);
        assert!(coin::value(&coin) == 7, 0);
        assert!(coin::value(&coin1) == 1, 0);
        assert!(coin::value(&coin2) == 2, 0);
        test_utils::destroy(coin);
        test_utils::destroy(coin1);
        test_utils::destroy(coin2);

        test_scenario::end(scenario_val);
    }
}