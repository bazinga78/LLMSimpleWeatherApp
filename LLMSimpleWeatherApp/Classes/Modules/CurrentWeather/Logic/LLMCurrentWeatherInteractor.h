//
// Created by Manuele Mion on 08/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLMWeather.h"
#import "LLMMapperInterface.h"
#import "LLMWeatherDataManagerInterface.h"
#import "LLMCurrentWeatherInteractorInputOutput.h"

@class LLMCurrentWeatherInteractor;

/*
 * Represents the simplest scenario in our applications. It asks to an external entity the current weather and
 * perform all the necessary transformations to the data. This resulting objects are then sent to the presenter to
 * be shown to the user.
*/
@interface LLMCurrentWeatherInteractor : NSObject <LLMCurrentWeatherInteractorInput>

@property (nonatomic, weak) id <LLMCurrentWeatherInteractorOutput> outputDelegate;

@property (nonatomic, strong) id <LLMMapperInterface> weatherMapper;
@property (nonatomic, strong) id <LLMWeatherDataManagerInterface> networkManager;

@end