//
// Created by Manuele Mion on 08/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LLMWeatherType) {
    LLMClearSkyWeatherType,
    LLMFewCloudsWeatherType,
    LLMScatteredCloudsWeatherType,
    LLMBrokenCloudsWeatherType,
    LLMShowerRainWeatherType,
    LLMRainWeatherType,
    LLMThunderstormWeatherType,
    LLMSnowWeatherType,
    LLMMistWeatherType
};

struct LLMTemperature {
    float minTemperatureInCelsius;
    float currentTemperatureInCelsius;
    float maxTemperatureInCelsius;
};
typedef struct LLMTemperature LLMTemperature;

static inline LLMTemperature
LLMTemperatureMake(CGFloat minTemperature, CGFloat currentTemperature, CGFloat maxTemperature) {
    LLMTemperature temperature;
    temperature.minTemperatureInCelsius = minTemperature;
    temperature.currentTemperatureInCelsius = currentTemperature;
    temperature.maxTemperatureInCelsius = maxTemperature;
    return temperature;
}

@interface LLMWeather : NSObject

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, assign) LLMWeatherType weatherType;

@property (nonatomic, assign) LLMTemperature temperature;

@end