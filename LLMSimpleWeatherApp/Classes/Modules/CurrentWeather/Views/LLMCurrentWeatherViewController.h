//
//  LLMCurrentWeatherViewController.h
//  LLMSimpleWeatherApp
//
//  Created by Manuele Mion on 08/07/2014.
//  Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FlatUIKit/FlatUIKit.h>

#import "LLMCurrentWeatherViewInterface.h"
#import "LLMCurrentWeatherPresenterInterface.h"

@interface LLMCurrentWeatherViewController : UIViewController <LLMCurrentWeatherViewInterface>

@property (nonatomic, weak) id <LLMCurrentWeatherPresenterInterface> actionInput;

#pragma mark - IBOutlets

@property (nonatomic, weak) IBOutlet UILabel *dayAndMonthLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *currentWeatherImageView;
@property (nonatomic, weak) IBOutlet UILabel *currentTemperatureLabel;
@property (nonatomic, weak) IBOutlet UILabel *maxTemperatureLabel;
@property (nonatomic, weak) IBOutlet UILabel *minTemperatureLabel;
@property (nonatomic, weak) IBOutlet FUIButton *refreshButton;

#pragma mark - IBActions

- (IBAction)onRefreshButtonTap:(id)sender;



@end