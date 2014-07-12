//
// Created by Manuele Mion on 11/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LLMErrorHandlerViewInterface <NSObject>

- (void)showGenericError:(NSError *)error;
- (void)showNoConnectionError;

@end