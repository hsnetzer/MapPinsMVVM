//
//  AppDelegate.m
//  MapPinsMVVM
//
//  Created by Harry Netzer on 7/14/19.
//  Copyright © 2019 Harry Netzer. All rights reserved.
//

#import "AppDelegate.h"
#import "ListViewController.h"
#import "MapViewController.h"
#import "MapPinsMVVM-Swift.h"

@interface AppDelegate ()
@property PinModel *model;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // create a model
    _model = [[PinModel alloc] init];
    
    // create view models which depend on the model and add them to the view controllers
    UITabBarController *tabController = (UITabBarController*) [_window rootViewController];
    NSArray *viewControllers = [tabController viewControllers];
    
    UINavigationController *listNavController = viewControllers[1];
    ListViewController *listViewController = (ListViewController*) [listNavController topViewController];
    ListViewModel *listViewModel = [[ListViewModel alloc] initWithPinModel:_model];
    [listViewController setViewModel: listViewModel];
    
    UINavigationController *mapNavController = viewControllers[0];
    MapViewController *mapViewController = (MapViewController*) [mapNavController topViewController];
    MapViewModel *mapViewModel = [[MapViewModel alloc] initWithPinModel:_model];
    [mapViewController setViewModel: mapViewModel];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [_model saveChanges];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
