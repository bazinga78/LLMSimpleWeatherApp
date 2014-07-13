//
// Created by Manuele Mion on 13/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import "LLMAppDependencyResolver.h"

#import "LLMWeatherNetworkManager.h"
#import "LLMCurrentWeatherInteractor.h"
#import "LLMCurrentWeatherPresenter.h"
#import "LLMCurrentWeatherViewController.h"
#import "LLMWeatherMapper.h"

@interface LLMAppDependencyResolver ()

@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) LLMCurrentWeatherPresenter *currentWeatherPresenter;

@end

@implementation LLMAppDependencyResolver

- (id)init {
    self = [super init];
    if (self != nil) {
        [self configureDependency];
    }
    return self;
}

- (void)configureDependency {

    // TODO: Load key from plist
    LLMWeatherNetworkManager *networkManager = [[LLMWeatherNetworkManager alloc] initWithAPIKey:@"d844e2d84934908e1bf65df91bbe3b64"];

    LLMCurrentWeatherInteractor *interactor = [LLMCurrentWeatherInteractor new];
    interactor.networkManager = networkManager; // strong reference
    interactor.weatherMapper = [LLMWeatherMapper new];

    self.currentWeatherPresenter = [LLMCurrentWeatherPresenter new];
    self.currentWeatherPresenter.interactorInput = interactor; // strong reference
    interactor.outputDelegate = self.currentWeatherPresenter;  // weak reference

    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LLMCurrentWeatherViewController *viewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"CurrentWeatherID"];
    viewController.actionInput = self.currentWeatherPresenter; // weak reference
    self.currentWeatherPresenter.userInterface = viewController; // strong reference

    self.rootViewController = viewController;
}

#pragma mark - Public method

- (UIViewController *)createRootViewController {
    return self.rootViewController;
}

@end