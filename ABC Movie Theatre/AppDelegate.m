//
//  AppDelegate.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/19/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "AppDelegate.h"
#import "MovieListViewController.h"
#import "CoreDataManager.h"
#import "Constants.h"
#import "AFNetworkReachabilityManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [self configureWindow];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_MOVIE_LIST_NOTIFICATION
                                                        object:nil
                                                      userInfo:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
    [self saveContext];
}

- (void)configureWindow {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    MovieListViewController *moviesListViewController = [[MovieListViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:moviesListViewController];
    
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
}

/**
 *  Save the cached entities in SyncManagedObjectContext into the sqlite DB.
 */
- (void)saveContext {
    [[CoreDataManager sharedInstance] saveContext:^(BOOL success, NSError *error) {
        
    }];
}

@end
