//
//  LLMCurrentWeatherPresenterTestCase.m
//  LLMSimpleWeatherApp
//
//  Created by Manuele Mion on 11/07/2014.
//  Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>

#import "LLMCurrentWeatherPresenter.h"
#import "LLMCurrentWeatherPresenterInterface.h"
#import "LLMWeatherDataManagerInterface.h"
#import "LLMArg.h"
#import "LLMCurrentWeatherViewInterface.h"
#import "LLMWeatherDisplayData.h"

@interface LLMCurrentWeatherPresenterTestCase : XCTestCase
@end

@implementation LLMCurrentWeatherPresenterTestCase

#pragma mark - LLMCurrentWeatherInteractorOutput

- (void)test_when_receives_a_request_to_refresh_data_should_forward_the_request_to_the_interactor {

    // given
    id currentWeatherInteractorMock = [OCMockObject niceMockForProtocol:@protocol(LLMCurrentWeatherInteractorInput)];
    LLMCurrentWeatherPresenter *presenter = [LLMCurrentWeatherPresenter new];
    presenter.interactorInput = currentWeatherInteractorMock;

    // when
    [presenter refreshWeatherData];

    // then
    OCMVerify([currentWeatherInteractorMock getCurrentWeatherIn:@"London"]);
}

#pragma mark - LLMCurrentWeatherInteractorOutput

- (void)test_when_receiving_a_successful_response_should_call_the_proper_method_on_the_view {

    // given
    id currentWeatherView = [OCMockObject niceMockForProtocol:@protocol(LLMCurrentWeatherViewInterface)];

    LLMCurrentWeatherPresenter *presenter = [LLMCurrentWeatherPresenter new];
    presenter.userInterface = currentWeatherView;

    LLMWeatherDisplayData *weather = [LLMWeatherDisplayData new];

    // when
    [presenter currentWeatherInteractor:nil didReceiveUpdatesAboutWeather:weather];

    // then
    OCMVerify([currentWeatherView showCurrentWeather:weather]);
}

- (void)test_when_receiving_a_generic_message_should_call_the_proper_method_on_the_view {

    // given
    id currentWeatherView = [OCMockObject niceMockForProtocol:@protocol(LLMCurrentWeatherViewInterface)];

    LLMCurrentWeatherPresenter *presenter = [LLMCurrentWeatherPresenter new];
    presenter.userInterface = currentWeatherView;

    NSError *error = [NSError errorWithDomain:@"GenericError" code:-1 userInfo:nil];

    // when
    [presenter currentWeatherInteractor:nil didFailWithError:error];

    // then
    OCMVerify([currentWeatherView showGenericError:error]);
}

- (void)test_when_receiving_a_no_internet_connection_should_call_the_proper_method_on_the_view {

    // given
    id currentWeatherView = [OCMockObject niceMockForProtocol:@protocol(LLMCurrentWeatherViewInterface)];

    LLMCurrentWeatherPresenter *presenter = [LLMCurrentWeatherPresenter new];
    presenter.userInterface = currentWeatherView;

    NSError *error = [NSError errorWithDomain:NSURLErrorDomain
                                         code:kCFURLErrorNotConnectedToInternet
                                     userInfo:nil];

    // when
    [presenter currentWeatherInteractor:nil didFailWithError:error];

    // then
    OCMVerify([currentWeatherView showNoConnectionError]);
}

@end
