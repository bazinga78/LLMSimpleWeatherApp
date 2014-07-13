//
//  LLMAppDelegate.m
//  LLMSimpleWeatherApp
//
//  Created by Manuele Mion on 08/07/2014.
//  Copyright (c) 2014 Manuele Mion. All rights reserved.
//

#import "LLMAppDelegate.h"
#import "LLMAppDependencyResolver.h"

@interface LLMAppDelegate ()

@property (nonatomic, strong) LLMAppDependencyResolver *dependencyResolver;

@end

@implementation LLMAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.dependencyResolver = [LLMAppDependencyResolver new];

    self.window.rootViewController = [self.dependencyResolver createRootViewController];
    [self.window makeKeyAndVisible];

    return YES;
}

@end