//
//  AppDelegate.m
//  yemaomen
//
//  Created by Zhu Weifeng on 10/8/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import "YMMAppDelegate.h"

#import "YMMFirstViewController.h"
#import "YMMSecondViewController.h"
#import "YMMThirdViewController.h"
#import "YMMFourthViewController.h"

@implementation YMMAppDelegate

/**
 全局异常处理，主要是用来调试的。程序中没有被捕获的异常，会由这个函数统一处理。目前做的操作只是打印出相应的值，方便调试代码，从而去掉异常。
 */
void uncaughtExceptionHandler(NSException* exception) {
  YMMLOG(@"Crash: %@", exception);
  YMMLOG(@"Exception Description: %@", exception.description);
  YMMLOG(@"Stack Trace: %@", [exception callStackSymbols]);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  YMMLOG(@"class: %@, _cmd: %@",[self class], NSStringFromSelector(_cmd));
  NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
  
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  
  UIViewController *viewController1 = [[YMMFirstViewController alloc] initWithStyle:UITableViewStylePlain];
  UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
  UIViewController *viewController2 = [[YMMSecondViewController alloc] initWithStyle:UITableViewStylePlain];
  UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:viewController2];
  UIViewController *viewController3 = [[YMMThirdViewController alloc] init];
  UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:viewController3];
  UIViewController *viewController4 = [[YMMFourthViewController alloc] init];
  UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:viewController4];
  self.tabBarController = [[UITabBarController alloc] init];
  self.tabBarController.viewControllers = @[nav1, nav2, nav3, nav4];
  
  self.window.rootViewController = self.tabBarController;
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// 整体设置App支持的InterfaceOrientations。假设这里设置可以支持多个orientation，而VC里面也设置可以支持多个orientation，那么App实际支持的orientation是这两者的交集。
- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
  return UIInterfaceOrientationMaskPortrait;
}

/* Block回调的一个例子，在实现的时候，记得给handler一个UIBackgroundFetchResult类型的值，让这个block能够执行。
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))handler {
  
}
*/

#pragma mark - UITabBarControllerDelegate methods

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/

@end
