//
// Created by Manuele Mion on 11/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLMCurrentWeatherViewInterface.h"
#import "LLMCurrentWeatherPresenterInterface.h"
#import "LLMCurrentWeatherInteractorInputOutput.h"

@interface LLMCurrentWeatherPresenter : NSObject <LLMCurrentWeatherPresenterInterface, LLMCurrentWeatherInteractorOutput>

@property (nonatomic, strong) id <LLMCurrentWeatherViewInterface> userInterface;
@property (nonatomic, strong) id <LLMCurrentWeatherInteractorInput> interactorInput;

@end