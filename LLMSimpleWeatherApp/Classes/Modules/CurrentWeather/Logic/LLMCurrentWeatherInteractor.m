//
// Created by Manuele Mion on 08/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import "LLMCurrentWeatherInteractor.h"

#import "LLMWeatherMapper.h"
#import "LLMMapperInterface.h"

@implementation LLMCurrentWeatherInteractor

- (void)getCurrentWeatherIn:(NSString *)cityName {

    [self.networkManager getWeatherForecastForDate:[NSDate new]
                                            cityOf:cityName
                                           success:^(NSDictionary *result) {

        LLMWeather *mappedResult = [self.weatherMapper mapDictionaryToEntity:result];
        [self.outputDelegate currentWeatherInteractor:self didReceiveUpdatesAboutWeather:mappedResult];

    } error:^(NSError *error) {

        [self.outputDelegate currentWeatherInteractor:self didFailWithError:error];

    }];
}

@end