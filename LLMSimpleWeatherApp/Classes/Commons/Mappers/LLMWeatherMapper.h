//
// Created by Manuele Mion on 10/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLMWeather.h"
#import "LLMMapperInterface.h"

/*
 * Utility function to help converting a string into a more appropriate representation to be used in the code.
 */
static inline LLMWeatherType NSStringToLLMWeatherType(NSString *weatherTypeAsString) {

    // I know you're complaining about the fact I'm instantiating an object to do something very easy but in this way
    // the code it is very clear.
    NSString *weatherTypeAsStringLowercase = [weatherTypeAsString lowercaseString];
    return (LLMWeatherType)[@[
            @"clear sky",
            @"few clouds",
            @"scattered clouds",
            @"broken clouds",
            @"shower rain",
            @"rain",
            @"thunderstorm",
            @"snow",
            @"mist"
    ] indexOfObject:weatherTypeAsStringLowercase];
}

@interface LLMWeatherMapper : NSObject <LLMMapperInterface>
@end