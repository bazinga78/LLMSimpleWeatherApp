//
//  LLMCurrentWeatherViewController.m
//  LLMSimpleWeatherApp
//
//  Created by Manuele Mion on 08/07/2014.
//  Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import "LLMCurrentWeatherViewController.h"

#import <MBProgressHUD/MBProgressHUD.h>

#import "LLMWeather.h"
#import "LLMWeatherDisplayData.h"

@interface LLMCurrentWeatherViewController ()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSDateFormatter *timeFormatter;

@end

@implementation LLMCurrentWeatherViewController

#pragma mark - Date and Time Formatters

// Since instantiate a formatter is a quite expensive operation, we want to do
// it once and when requested.

- (NSDateFormatter *)dateFormatter {
    if (self->_dateFormatter == nil) {
        [self initDateFormatter];
    }
    return self->_dateFormatter;
}

- (void)initDateFormatter {
    NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"ddMMMM" options:0
                                                              locale:[NSLocale currentLocale]];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:formatString];
}

- (NSDateFormatter *)timeFormatter {
    if (self->_timeFormatter == nil) {
        [self initTimeFormatter];
    }
    return self->_timeFormatter;
}

- (void)initTimeFormatter {
    self.timeFormatter = [[NSDateFormatter alloc] init];
    [self.timeFormatter setDateStyle:NSDateFormatterNoStyle];
    [self.timeFormatter setTimeStyle:NSDateFormatterShortStyle];
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self updateRefreshButton];
    [self initControls];

    [self refreshData];
}

- (void)updateRefreshButton {
    self.refreshButton.buttonColor = [UIColor orangeColor];
    self.refreshButton.shadowColor = [UIColor pumpkinColor];
    self.refreshButton.shadowHeight = 3.0f;
    self.refreshButton.cornerRadius = 6.0f;
    self.refreshButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.refreshButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.refreshButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
}

- (void)initControls {
    self.dayAndMonthLabel.text = @"-";
    self.timeLabel.text = @"-";
    self.currentTemperatureLabel.text = @"-";
    self.maxTemperatureLabel.text = @"-";
    self.minTemperatureLabel.text = @"-";
}

#pragma mark - LLMCurrentWeatherViewInterface

- (void)showCurrentWeather:(LLMWeatherDisplayData *)weather {

    [self updateControlsWithData:weather];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

- (void)updateControlsWithData:(LLMWeatherDisplayData *)weather {
    self.dayAndMonthLabel.text = [self.dateFormatter stringFromDate:weather.date];
    self.timeLabel.text = [self.timeFormatter stringFromDate:weather.date];
    self.currentTemperatureLabel.text = [self formatTemperature:weather.temperature.currentTemperatureInCelsius];
    self.maxTemperatureLabel.text = [self formatTemperature:weather.temperature.maxTemperatureInCelsius];
    self.minTemperatureLabel.text = [self formatTemperature:weather.temperature.minTemperatureInCelsius];
}

- (NSString *)formatTemperature:(CGFloat)temperature {
    return [NSString stringWithFormat:@"%d", (int)round(temperature)];
}

#pragma mark - LLMErrorHandlerViewInterface

- (void)showGenericError:(NSError *)error {
    [self showErrorMessage];
}

- (void)showNoConnectionError {
    [self showErrorMessage];
}

- (void)showErrorMessage {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    [self showErrorAlertView];
}

- (void)showErrorAlertView {

    FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Error"
                                                          message:@"Something happened while retriving data. Try later."
                                                         delegate:nil cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];

    alertView.titleLabel.textColor = [UIColor cloudsColor];
    alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    alertView.messageLabel.textColor = [UIColor cloudsColor];
    alertView.messageLabel.font = [UIFont flatFontOfSize:14];
    alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
    alertView.alertContainer.backgroundColor = [UIColor asbestosColor];
    alertView.defaultButtonColor = [UIColor orangeColor];
    alertView.defaultButtonShadowColor = [UIColor pumpkinColor];
    alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
    alertView.defaultButtonTitleColor = [UIColor whiteColor];

    [alertView show];
}

#pragma mark - Actions

- (IBAction)onRefreshButtonTap:(id)sender {
    [self refreshData];
}

- (void)refreshData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.actionInput refreshWeatherData];
}

@end