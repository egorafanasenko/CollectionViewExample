//
//  AppDelegate.m
//  CollectionExample
//
//  Created by Alexandr on 25.07.15.
//  Copyright (c) 2015 Alexandr601t. All rights reserved.
//

#import "AppDelegate.h"
#import "PhotoViewController.h"
#import "PhotoDataProvider.h"

@implementation AppDelegate

#pragma mark Private methods

- (UIViewController *)createRootViewController
{
    PhotoDataProvider *dataProvider = [[PhotoDataProvider alloc] init];
    return [[PhotoViewController alloc] initWithDataProvider:dataProvider];
}

#pragma mark UIApplicationDelegate protocol methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [self createRootViewController];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
