//
// Created by Manuele Mion on 10/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import "LLMArg.h"

#import <OCMock/OCMock.h>
#import <NSDate-Escort/NSDate+Escort.h>

@implementation LLMArg

+ (id)isTodayDate {
    return [OCMArg checkWithBlock:^BOOL(NSDate *givenDate) {
        return givenDate.isToday;
    }];
}

@end