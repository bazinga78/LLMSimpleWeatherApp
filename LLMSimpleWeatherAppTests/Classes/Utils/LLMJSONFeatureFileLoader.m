//
// Created by Manuele Mion on 10/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import "LLMJSONFeatureFileLoader.h"


@implementation LLMJSONFeatureFileLoader

+ (id)loadFeatureWithName:(NSString *)name {

    NSError *error = nil;
    NSString* path = [[NSBundle bundleForClass:[self class]] pathForResource:name ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path options:0 error:&error];

    NSAssert(error == nil, @"This method is supposed to always return a valid result.");

    id result = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];

    NSAssert(error == nil, @"This method is supposed to always return a valid result.");

    return result;
}

@end