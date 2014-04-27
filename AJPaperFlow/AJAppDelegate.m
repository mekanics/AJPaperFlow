//
//  AJAppDelegate.m
//  AJPaperFlow
//
//  Created by Alexandre Joly on 07/04/14.
//  Copyright (c) 2014 Alexandre Joly. All rights reserved.
//

#import "AJAppDelegate.h"
#import "AJPaperFlowViewController.h"
#import "AJPaperFlowProtocol.h"
#import "AJDummyViewController.h"

@implementation AJAppDelegate

AJDummyViewController*(^dummyMainViewController)(NSString*) = ^(NSString* title) {
    AJDummyViewController *vc = [AJDummyViewController new];
    vc.view.backgroundColor = [UIColor colorWithHue:(arc4random() % 255 / 255.0) saturation:0.6 brightness:0.6 alpha:1.0];
    
    vc.title = title;

    UILabel *lbl = [[UILabel alloc] init];
    lbl.text = title;
    [lbl sizeToFit];
    lbl.frame = CGRectOffset(lbl.frame, 20, 20);
    [vc.view addSubview:lbl];
    
    return vc;
};

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    AJPaperFlowViewController *exampleCV = [[AJPaperFlowViewController alloc] initWithViewControllers:@[
                                                                                                        dummyMainViewController(@"View 1"),
                                                                                                        dummyMainViewController(@"View 2")]];
    self.window.rootViewController = exampleCV;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
