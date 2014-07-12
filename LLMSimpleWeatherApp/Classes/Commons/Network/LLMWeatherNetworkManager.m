//
// Created by Manuele Mion on 08/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import "LLMWeatherNetworkManager.h"

#import <AFNetworking/AFNetworking.h>

// TODO: Move the base URL to the init, use the path to call the proper api method
NSString * const LLMWeatherNetworkManagerBaseURLString = @"http://api.openweathermap.org/data/2.5/weather";

@interface LLMWeatherNetworkManager ()

@property (nonatomic, strong) NSString *apiKey;

@end

@implementation LLMWeatherNetworkManager

// The default init is overwritten to return an exception if used since we want to force the class client
// to give us the apiKey.
- (id)init {
    NSAssert(NO, @"Method 'initWithAPIKey' should be used instead of this.");
    return nil;
}

- (id)initWithAPIKey:(NSString *)apiKey {

    self = [super init];
    if (self) {
        self.apiKey = apiKey;
    }
    return self;
}

- (void)getWeatherForecastForDate:(NSDate *)date
                           cityOf:(NSString *)cityName
                          success:(LLMWeatherNetworkManagerSuccess)successBlock
                            error:(LLMWeatherNetworkManagerFailure)errorBlock {

    NSDictionary *parameters = @{@"q": cityName, @"APPID": self.apiKey};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:LLMWeatherNetworkManagerBaseURLString parameters:parameters
    success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        errorBlock(error);
    }];
}

@end