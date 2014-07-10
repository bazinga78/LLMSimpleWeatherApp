//
// Created by Manuele Mion on 08/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * Definition of the blocks used by the manager.
 */
typedef void (^LLMWeatherNetworkManagerSuccess)(id result);
typedef void (^LLMWeatherNetworkManagerFailure)(NSError *error);

/*
 * Some property to build a NSError message
 */
static NSString * const LLMSimpleWeatherNetworkError = @"LLMSimpleWeatherNetworkError";
static const int LLMGenericNetworkError  = -1;

/*
 * This protocol describes how a weather data manager should behave. A weather data manager knows
 * all the details on how to ask information about the weather to an external service.
 */
@protocol LLMWeatherDataManagerInterface <NSObject>

@required

/*
 * Request information about the weather to an external service.
 *
 * date: about when we want information
 * cityName: about what city we want information
 * success: the block to be called if the request is successful
 * failure: the block to be called if the request fails
 */
- (void)getWeatherForecastForDate:(NSDate *)date
                           cityOf:(NSString *)cityName
                          success:(LLMWeatherNetworkManagerSuccess)success
                            error:(LLMWeatherNetworkManagerFailure)error;

@end