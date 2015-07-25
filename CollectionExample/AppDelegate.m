//
//  AppDelegate.m
//  CollectionExample
//
//  Created by Alexandr on 25.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import "AppDelegate.h"
#import "PhotoViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark Private methods

- (UIViewController *)createRootViewController
{
    return [[PhotoViewController alloc] init];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [self createRootViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
