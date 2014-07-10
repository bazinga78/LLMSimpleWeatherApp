//
//  LLMCurrentWeatherTestCase.m
//  LLMSimpleWeatherApp
//
//  Created by Manuele Mion on 08/07/2014.
//  Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <OCMock/OCMock.h>
#import <NSDate-Escort/NSDate+Escort.h>

#import "LLMArg.h"
#import "LLMJSONFeatureFileLoader.h"

#import "LLMCurrentWeatherInteractor.h"

#pragma mark - Utility classes

@interface LLMCurrentWeatherInteractorOutputDelegateStub : NSObject <LLMCurrentWeatherInteractorOutputDelegate>

@property (nonatomic, strong) NSError *lastErrorReceived;
@property (nonatomic, strong) LLMWeather *lastResultReceived;

@end

@implementation LLMCurrentWeatherInteractorOutputDelegateStub

- (void)currentWeatherInteractor:(LLMCurrentWeatherInteractor *)currentWeatherInteractor didReceiveUpdatesAboutWeather:(LLMWeather *)currentWeather {
    self.lastResultReceived = currentWeather;
}

- (void)currentWeatherInteractor:(LLMCurrentWeatherInteractor *)currentWeatherInteractor didFailWithError:(NSError *)error {
    self.lastErrorReceived = error;
}

@end

@interface LLMCurrentWeatherTestCase : XCTestCase

@end

@implementation LLMCurrentWeatherTestCase

#pragma mark - Utility methods

- (id)createWeatherNetworkManagerStubWithSuccessfulResponse:(NSDictionary *)data {

    id weatherNetworkManagerStub = [OCMockObject mockForProtocol:@protocol(LLMWeatherDataManagerInterface)];

    [[[weatherNetworkManagerStub stub] andDo:^(NSInvocation *invocation) {

        void (^stubResponse)(id result);
        [invocation getArgument:&stubResponse atIndex:4]; // Index is 4 because first two arguments are self and _cmd
        stubResponse(data);

    }] getWeatherForecastForDate:[OCMArg any]
                          cityOf:[OCMArg any]
                         success:[OCMArg isNotNil]
                           error:[OCMArg any]];

    return weatherNetworkManagerStub;
}

- (id)createWeatherNetworkManagerStubWithFailureError:(NSError *)error {

    id weatherNetworkManagerStub = [OCMockObject mockForProtocol:@protocol(LLMWeatherDataManagerInterface)];

    [[[weatherNetworkManagerStub stub] andDo:^(NSInvocation *invocation) {

        void (^stubResponse)(id result);
        [invocation getArgument:&stubResponse atIndex:5]; // Index is 5 because first two arguments are self and _cmd
        stubResponse(error);

    }] getWeatherForecastForDate:[OCMArg any]
                          cityOf:[OCMArg any]
                         success:[OCMArg any]
                           error:[OCMArg isNotNil]];

    return weatherNetworkManagerStub;
}

#pragma mark - Tests

- (void)test_get_current_weather_calls_the_manager_method_using_the_correct_params {

    // given
    NSString *cityOf = @"London";

    LLMCurrentWeatherInteractor *todayWeatherInteractor = [LLMCurrentWeatherInteractor new];

    id weatherNetworkManagerMock = [OCMockObject mockForProtocol:@protocol(LLMWeatherDataManagerInterface)];
    OCMStub([weatherNetworkManagerMock getWeatherForecastForDate:[LLMArg isTodayDate]
                                                          cityOf:cityOf
                                                         success:[OCMArg any]
                                                           error:[OCMArg any]]);

    todayWeatherInteractor.networkManager = weatherNetworkManagerMock;

    // when
    [todayWeatherInteractor getCurrentWeatherIn:cityOf];

    // then
    // Method must be call, verified by OCMock

}

- (void)test_get_current_weather_calls_the_output_class_when_it_receives_data {

    // given
    NSDictionary *expectedResult = [NSDictionary new];

    id weatherNetworkManagerStub = [self createWeatherNetworkManagerStubWithSuccessfulResponse:expectedResult];
    id currentWeatherOutputDelegateMock = [OCMockObject niceMockForProtocol:@protocol(LLMCurrentWeatherInteractorOutputDelegate)];

    LLMCurrentWeatherInteractor *currentWeatherInteractor = [LLMCurrentWeatherInteractor new];
    currentWeatherInteractor.outputDelegate = currentWeatherOutputDelegateMock;
    currentWeatherInteractor.networkManager = weatherNetworkManagerStub;

    // when
    [currentWeatherInteractor getCurrentWeatherIn:@"London"];

    // then
    OCMVerify([currentWeatherOutputDelegateMock currentWeatherInteractor:currentWeatherInteractor didReceiveUpdatesAboutWeather:nil]);
}

- (void)test_get_current_weather_calls_the_proper_method_when_it_receives_an_error {

    // given
    NSError *expectedError = [NSError errorWithDomain:LLMSimpleWeatherNetworkError code:LLMGenericNetworkError userInfo:nil];

    id weatherNetworkManagerStub = [self createWeatherNetworkManagerStubWithFailureError:expectedError];
    id currentWeatherOutputDelegateMock = [OCMockObject niceMockForProtocol:@protocol(LLMCurrentWeatherInteractorOutputDelegate)];

    LLMCurrentWeatherInteractor *currentWeatherInteractor = [LLMCurrentWeatherInteractor new];
    currentWeatherInteractor.outputDelegate = currentWeatherOutputDelegateMock;
    currentWeatherInteractor.networkManager = weatherNetworkManagerStub;

    // when
    [currentWeatherInteractor getCurrentWeatherIn:@"London"];

    // then
    OCMVerify([currentWeatherOutputDelegateMock currentWeatherInteractor:currentWeatherInteractor
                                                        didFailWithError:expectedError]);

}

- (void)test_result_mapped_using_the_given_mapper {

    // given
    NSDictionary *featureData = [LLMJSONFeatureFileLoader loadFeatureWithName:@"modules_current-weather_logic_current-weather-test-case_simple-result"];
    LLMWeather *result = [LLMWeather new];

    id weatherNetworkManagerStub = [self createWeatherNetworkManagerStubWithSuccessfulResponse:featureData];
    id currentWeatherOutputDelegateMock = [OCMockObject niceMockForProtocol:@protocol(LLMCurrentWeatherInteractorOutputDelegate)];
    id weatherMapperStub = [OCMockObject mockForProtocol:@protocol(LLMMapperInterface)];
    OCMStub([weatherMapperStub mapDictionaryToEntity:featureData]).andReturn(result);

    LLMCurrentWeatherInteractor *currentWeatherInteractor = [LLMCurrentWeatherInteractor new];
    currentWeatherInteractor.outputDelegate = currentWeatherOutputDelegateMock;
    currentWeatherInteractor.networkManager = weatherNetworkManagerStub;
    currentWeatherInteractor.weatherMapper  = weatherMapperStub;

    // when
    [currentWeatherInteractor getCurrentWeatherIn:@"London"];

    // then
    OCMVerify([currentWeatherOutputDelegateMock currentWeatherInteractor:currentWeatherInteractor
                                           didReceiveUpdatesAboutWeather:result]);
}

@end
