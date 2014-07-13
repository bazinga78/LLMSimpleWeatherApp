//
//  LLMWeatherMapperTestCase.m
//  LLMSimpleWeatherApp
//
//  Created by Manuele Mion on 10/07/2014.
//  Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <NSDate-Escort/NSDate+Escort.h>

#import "LLMWeatherMapper.h"
#import "LLMJSONFeatureFileLoader.h"

@interface LLMWeatherMapperTestCase : XCTestCase

@end

@implementation LLMWeatherMapperTestCase

- (void)test_if_given_dictionary_is_nil_then_weather_entity_should_be_nil {

    // given
    LLMWeatherMapper *mapper = [LLMWeatherMapper new];

    // when
    LLMWeather *result = [mapper mapDictionaryToEntity:nil];

    // then
    XCTAssertNil(result);
}

- (void)test_if_given_dictionary_is_empty_then_weather_entity_should_be_nil {

    // given
    LLMWeatherMapper *mapper = [LLMWeatherMapper new];

    // when
    LLMWeather *result = [mapper mapDictionaryToEntity:[NSDictionary new]];

    // then
    XCTAssertNil(result);
}

- (void)test_weather_type_are_converted_correctly {
    XCTAssertTrue(NSStringToLLMWeatherType(@"01d") == LLMClearSkyWeatherType);
    XCTAssertTrue(NSStringToLLMWeatherType(@"02d") == LLMFewCloudsWeatherType);
    XCTAssertTrue(NSStringToLLMWeatherType(@"03d") == LLMScatteredCloudsWeatherType);
    XCTAssertTrue(NSStringToLLMWeatherType(@"04d") == LLMBrokenCloudsWeatherType);
    XCTAssertTrue(NSStringToLLMWeatherType(@"09d") == LLMShowerRainWeatherType);
    XCTAssertTrue(NSStringToLLMWeatherType(@"10d") == LLMRainWeatherType);
    XCTAssertTrue(NSStringToLLMWeatherType(@"11d") == LLMThunderstormWeatherType);
    XCTAssertTrue(NSStringToLLMWeatherType(@"13d") == LLMSnowWeatherType);
    XCTAssertTrue(NSStringToLLMWeatherType(@"50d") == LLMMistWeatherType);
}

- (void)test_actual_data_is_mapped_correctly {

    // given
    NSDictionary *data = [LLMJSONFeatureFileLoader loadFeatureWithName:@"modules_current-weather_logic_current-weather-test-case_simple-result"];
    LLMWeatherMapper *mapper = [LLMWeatherMapper new];

    // when
    LLMWeather *result = [mapper mapDictionaryToEntity:data];

    // then
    XCTAssertNotNil(result);
    XCTAssertTrue(result.date.isToday);
    XCTAssertTrue(result.weatherType == LLMRainWeatherType);
    XCTAssertTrue(result.weatherType == LLMRainWeatherType);
    XCTAssertEqualWithAccuracy(result.temperature.minTemperatureInCelsius, 14.0f, 0.001);
    XCTAssertEqualWithAccuracy(result.temperature.currentTemperatureInCelsius, 18.72f, 0.001);
    XCTAssertEqualWithAccuracy(result.temperature.maxTemperatureInCelsius, 22.3f, 0.001);
}

// TODO: Test what happens when one or more params are missing.

@end
