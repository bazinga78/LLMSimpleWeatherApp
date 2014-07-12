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

#import "XCTestCase+AsyncTesting.h"

#import "LLMWeatherNetworkManager.h"

NSString * const LLMWeatherNetworkManagerTestCaseSimpleFixturePath = @"modules_current-weather_logic_current-weather-test-case_simple-result.json";

@interface LLMWeatherNetworkManagerTestCase : XCTestCase
@end

@implementation LLMWeatherNetworkManagerTestCase

#pragma mark - Utils

- (NSString *)getFixturePathForSimpleResult {
    return OHPathForFileInBundle(LLMWeatherNetworkManagerTestCaseSimpleFixturePath,
                                 [NSBundle bundleForClass:[self class]]);
}

- (void)tearDown {
    [super tearDown];

    // We need to call removeAllStubs to be sure all out following tests
    // are clean.
    [OHHTTPStubs removeAllStubs];
}

#pragma mark - Test

- (void)test_when_calling_the_method_a_http_request_to_the_correct_url_should_be_sent {

    // Given
    __block NSURL *requestURL = nil;

    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        requestURL = request.URL;
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSString* fixture = [self getFixturePathForSimpleResult];
        return [OHHTTPStubsResponse responseWithFileAtPath:fixture
                                                statusCode:200
                                                   headers:@{@"Content-Type" : @"text/json"}];

    }];

    LLMWeatherNetworkManager *networkManager = [LLMWeatherNetworkManager new];

    // When
    [networkManager getWeatherForecastForDate:[NSDate new] cityOf:@"London"
    success:^(id result) {
        [self XCA_notify:XCTAsyncTestCaseStatusSucceeded];
    } error:nil];

    [self XCA_waitForTimeout:3.0];

    // Then

    // The URL called should be: api.openweathermap.org/data/2.5/weather?q=London
    XCTAssertNotNil(requestURL);

    XCTAssertEqualObjects(requestURL.host, @"api.openweathermap.org");
    XCTAssertEqualObjects(requestURL.path, @"/data/2.5/weather");

    NSDictionary *queryComponents = [requestURL uq_queryDictionary];
    XCTAssertEqual([queryComponents count], 1);
    XCTAssertEqualObjects(queryComponents[@"q"], @"London");
}

- (void)test_when_a_successful_response_is_received_the_success_block_should_be_called {

    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSString* fixture = [self getFixturePathForSimpleResult];
        return [OHHTTPStubsResponse responseWithFileAtPath:fixture
                                                statusCode:200
                                                   headers:@{@"Content-Type" : @"text/json"}];
    }];

    LLMWeatherNetworkManager *networkManager = [LLMWeatherNetworkManager new];

    // When
    [networkManager getWeatherForecastForDate:[NSDate new] cityOf:@"London"
    success:^(id result) {
        [self XCA_notify:XCTAsyncTestCaseStatusSucceeded];
    } error:^(NSError *error) {
        [self XCA_notify:XCTAsyncTestCaseStatusFailed];
    }];

    // Then
    [self XCA_waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:3.0];

}

- (void)test_when_a_failure_response_is_received_the_failure_block_should_be_called {

    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithData:nil
                                          statusCode:500
                                             headers:nil];
    }];

    LLMWeatherNetworkManager *networkManager = [LLMWeatherNetworkManager new];

    // When
    [networkManager getWeatherForecastForDate:[NSDate new] cityOf:@"London"
                                      success:^(id result) {
        [self XCA_notify:XCTAsyncTestCaseStatusFailed];
    } error:^(NSError *error) {
        [self XCA_notify:XCTAsyncTestCaseStatusSucceeded];
    }];

    // Then
    [self XCA_waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:3.0];
}

- (void)test_when_there_is_no_connection_a_proper_error_message_should_be_returned {

    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return YES;
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        return [OHHTTPStubsResponse responseWithError:
                [NSError errorWithDomain:NSURLErrorDomain
                                    code:kCFURLErrorNotConnectedToInternet
                                userInfo:nil]];
    }];

    LLMWeatherNetworkManager *networkManager = [LLMWeatherNetworkManager new];

    // When
    [networkManager getWeatherForecastForDate:[NSDate new] cityOf:@"London"
                                      success:^(id result) {
        [self XCA_notify:XCTAsyncTestCaseStatusFailed];
    } error:^(NSError *error) {
        [self XCA_notify:XCTAsyncTestCaseStatusSucceeded];
    }];

    // Then
    [self XCA_waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:3.0];
}

@end
