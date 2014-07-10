//
// Created by Manuele Mion on 10/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LLMWeather;

/*
 * Describe how a mapper, which is responsible to convert a raw dictionary into a entity, should behave.
 */
@protocol LLMMapperInterface <NSObject>

@required

/*
 * Transform a dictionary into an entity.
 *
 * dictionary: the raw dictionary to be converted.
 * output: the converted entity if valid, nil otherwise.
 */
- (id)mapDictionaryToEntity:(NSDictionary *)dictionary;

@end