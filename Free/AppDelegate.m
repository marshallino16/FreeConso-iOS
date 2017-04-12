//
//  AppDelegate.m
//  Tisseo
//
//  Created by Anthony on 6/8/16.
//  Copyright © 2016 GENyUS. All rights reserved.
//

#import "AppDelegate.h"
#import "ConsoController.h"
#import "LoginController.h"
#import "ViewHelper2.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:screenBounds];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Load controller
    self.viewController = [[LoginController alloc] init];
    
    //Initialize navigation controller
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    [ViewHelper2 configureNavigationBarWithNavigationController:navigationController];
        
    
    // Set Navigation controller
    [window setRootViewController:navigationController];
    
    [window makeKeyAndVisible];
    
    [self setWindow:window];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
