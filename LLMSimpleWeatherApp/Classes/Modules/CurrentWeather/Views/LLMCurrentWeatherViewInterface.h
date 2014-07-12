//
// Created by Manuele Mion on 11/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLMErrorHandlerViewInterface.h"

@class LLMWeatherDisplayData;

@protocol LLMCurrentWeatherViewInterface <LLMErrorHandlerViewInterface>

- (void)showCurrentWeather:(LLMWeatherDisplayData *)weather;

@end