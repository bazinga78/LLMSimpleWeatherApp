//
// Created by Manuele Mion on 10/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import "LLMWeatherMapper.h"

#import "LLMUnitConversionUtils.h"

@implementation LLMWeatherMapper

- (LLMWeather *)mapDictionaryToEntity:(NSDictionary *)dictionary {

    if ([dictionary count] == 0) {
        return nil;
    }

    LLMWeather *weather = [LLMWeather new];
    weather.date = [NSDate date];

    weather.weatherType = NSStringToLLMWeatherType(dictionary[@"weather"][0][@"icon"]);
    weather.temperature = LLMTemperatureMake(
            LLMConvertKelvinToCelsiusDegree([dictionary[@"main"][@"temp_min"] floatValue]),
            LLMConvertKelvinToCelsiusDegree([dictionary[@"main"][@"temp"] floatValue]),
            LLMConvertKelvinToCelsiusDegree([dictionary[@"main"][@"temp_max"] floatValue])
    );

    return weather;
}

@end