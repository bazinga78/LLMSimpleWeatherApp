//
// Created by Manuele Mion on 08/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import "LLMWeatherNetworkManager.h"

#import <AFNetworking/AFNetworking.h>

// TODO: Move the base URL to the init, use the path to call the proper api method
NSString * const LLMWeatherNetworkManagerBaseURLString = @"http://api.openweathermap.org/data/2.5/weather";

@implementation LLMWeatherNetworkManager

- (void)getWeatherForecastForDate:(NSDate *)date
                           cityOf:(NSString *)cityName
                          success:(LLMWeatherNetworkManagerSuccess)successBlock
                            error:(LLMWeatherNetworkManagerFailure)errorBlock {

    NSDictionary *parameters = @{@"q": cityName};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:LLMWeatherNetworkManagerBaseURLString parameters:parameters
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorBlock(error);
    }];
}

@end