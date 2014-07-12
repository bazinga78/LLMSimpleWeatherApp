//
// Created by Manuele Mion on 11/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLMWeather;

@protocol LLMCurrentWeatherInteractorInput <NSObject>

/*
 * This method is called to ask the interactor to get fresh data about the current weather.
 *
 * cityName: Name of the city the caller wants to know about the weather.
 */
- (void)getCurrentWeatherIn:(NSString *)cityName;

@end

/*
 * This is the interface used by the interactor to inform the delegate about the result of the last update.
 */
@protocol LLMCurrentWeatherInteractorOutput <NSObject>

- (void)currentWeatherInteractor:(id)currentWeatherInteractor didReceiveUpdatesAboutWeather:(LLMWeather *)currentWeather;
- (void)currentWeatherInteractor:(id)currentWeatherInteractor didFailWithError:(NSError *)error;

@end