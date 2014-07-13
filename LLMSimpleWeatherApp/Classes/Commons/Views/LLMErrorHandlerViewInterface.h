//
// Created by Manuele Mion on 11/07/2014.
// Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * Describes the behaviour for a view which can handle errors.
 */
@protocol LLMErrorHandlerViewInterface <NSObject>

/*
 * A generic error handling method.
 */
- (void)showGenericError:(NSError *)error;

/*
 * A specific method to be used when the error is a 'No connection' error.
 */
- (void)showNoConnectionError;

@end