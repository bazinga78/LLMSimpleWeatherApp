//
// Created by Manuele Mion on 08/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLMWeather.h"
#import "LLMMapperInterface.h"
#import "LLMWeatherDataManagerInterface.h"

@class LLMCurrentWeatherInteractor;

/*
 * This is the interface used by the interactor to inform the delegate about the result of the last update.
 */
@protocol LLMCurrentWeatherInteractorOutputDelegate

- (void)currentWeatherInteractor:(LLMCurrentWeatherInteractor *)currentWeatherInteractor didReceiveUpdatesAboutWeather:(LLMWeather *)currentWeather;
- (void)currentWeatherInteractor:(LLMCurrentWeatherInteractor *)currentWeatherInteractor didFailWithError:(NSError *)error;

@end

/*
 * Represents the simplest scenario in our applications. It asks to an external entity the current weather and
 * perform all the necessary transformations to the data. This resulting objects are then sent to the presenter to
 * be shown to the user.
*/
@interface LLMCurrentWeatherInteractor : NSObject

@property (nonatomic, weak) id <LLMCurrentWeatherInteractorOutputDelegate> outputDelegate;

@property (nonatomic, strong) id <LLMMapperInterface> weatherMapper;
@property (nonatomic, strong) id <LLMWeatherDataManagerInterface> networkManager;

/*
 * This method is called to ask the interactor to get fresh data about the current weather.
 *
 * cityName: Name of the city the caller wants to know about the weather.
 */
- (void)getCurrentWeatherIn:(NSString *)cityName;

@end