//
// Created by Manuele Mion on 08/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LLMWeatherDataManagerInterface.h"

@interface LLMWeatherNetworkManager : NSObject <LLMWeatherDataManagerInterface>

/*
 * This is the designated init for the class. The other init method should be used.
 *
 * APIKey: key used by the class to exchange data with the API server
 *
 * returns: A LLWeatherNetworkManager instance, nil if there is any problem
 */
- (id)initWithAPIKey:(NSString *)apiKey;

@end