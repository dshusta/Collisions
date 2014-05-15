//
//  AppDelegate.m
//  Collisions
//
//  Created by pivotal on 5/14/14.
//  Copyright (c) 2014 Shusta. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    ViewController *viewController = [[ViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = viewController;

    [self.window makeKeyAndVisible];

    return YES;
}

@end
