//
// Created by Manuele Mion on 11/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import "NSError+LLMUtils.h"

@implementation NSError (LLMUtils)

// TODO: Write test for this method

- (BOOL)isANoConnectionError {
    return ([self.domain isEqualToString:NSURLErrorDomain] &&
            self.code == kCFURLErrorNotConnectedToInternet);
}

@end