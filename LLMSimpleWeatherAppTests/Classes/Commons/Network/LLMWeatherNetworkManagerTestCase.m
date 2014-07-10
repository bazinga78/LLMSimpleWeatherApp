//
//  LLMWeatherNetworkManagerTestCase.m
//  LLMSimpleWeatherApp
//
//  Created by Manuele Mion on 10/07/2014.
//  Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import <NSURL+QueryDictionary/NSURL+QueryDictionary.h>

#import "LLMWeatherNetworkManager.h"

@interface LLMWeatherNetworkManagerTestCase : XCTestCase

@end

@implementation LLMWeatherNetworkManagerTestCase

#pragma mark - Test

- (void)test_when_calling_the_method_a_http_request_to_the_correct_url_should_be_sent {

    // Dispatch group is used to handle the async call
    dispatch_group_t syncGroup = dispatch_group_create();
    dispatch_group_enter(syncGroup);

    // Given
    __block NSURL *requestURL = nil;

    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        requestURL = request.URL;
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSString* fixture = OHPathForFileInBundle(@"modules_current-weather_logic_current-weather-test-case_simple-result.json", [NSBundle bundleForClass:[self class]]);
        dispatch_group_leave(syncGroup);
        return [OHHTTPStubsResponse responseWithFileAtPath:fixture
                                                statusCode:200
                                                   headers:@{@"Content-Type" : @"text/json"}];

    }];

    LLMWeatherNetworkManager *networkManager = [LLMWeatherNetworkManager new];

    // When
    [networkManager getWeatherForecastForDate:[NSDate new] cityOf:@"London" success:nil error:nil];

    dispatch_group_wait(syncGroup, DISPATCH_TIME_FOREVER);

    // Then

    // The URL called should be: api.openweathermap.org/data/2.5/weather?q=London
    XCTAssertNotNil(requestURL);

    XCTAssertEqualObjects(requestURL.host, @"api.openweathermap.org");
    XCTAssertEqualObjects(requestURL.path, @"/data/2.5/weather");

    NSDictionary *queryComponents = [requestURL uq_queryDictionary];
    XCTAssertEqual([queryComponents count], 1);
    XCTAssertEqualObjects(queryComponents[@"q"], @"London");

    XCTFail(@"I want the test to fail just to remember where I was working");
}

// test blocks are called

// test no connection

// test empty data

// test normal usage

@end
