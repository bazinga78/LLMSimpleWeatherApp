//
// Created by Manuele Mion on 11/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import "LLMCurrentWeatherPresenter.h"

#import "NSError+LLMUtils.h"

@implementation LLMCurrentWeatherPresenter

#pragma mark - LLMCurrentWeatherPresenterInterface

- (void)refreshWeatherData {
    [self.interactorInput getCurrentWeatherIn:@"London"];
}

#pragma mark - LLMCurrentWeatherInteractorOutput

- (void)currentWeatherInteractor:(id)currentWeatherInteractor didReceiveUpdatesAboutWeather:(LLMWeather *)currentWeather {
    [self.userInterface showCurrentWeather:currentWeather];
}

- (void)currentWeatherInteractor:(id)currentWeatherInteractor didFailWithError:(NSError *)error {

    if ([error isANoConnectionError]) {
        [self.userInterface showNoConnectionError];
        return;
    }

    [self.userInterface showGenericError:error];
}

@end