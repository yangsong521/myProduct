//
//  AppDelegate.m
//  Groupproject
//
//  Created by lanou3g on 15/6/17.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseController.h"
#import "BaseController.h"
#import "AFNetworking.h"
#import "ViewController.h"
#import "BaseNoNetController.h"
#import "Marcro.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    AFNetworkReachabilityManager *magr = [AFNetworkReachabilityManager sharedManager];
    [magr startMonitoring];
    
    
    [self addFollowView];
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)addFollowView{
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"hehehe"] == NO) {
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"hehehe"];
        
        self.scrollView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.bounces = NO;
        _scrollView.contentSize = CGSizeMake(mScreenW*4, mScreenH);
        _scrollView.pagingEnabled = YES;
        [self.window addSubview:_scrollView];
        for (int i=0; i<4; i++) {
            UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"yindao%d.png",i+1]]];
            imageView.frame = CGRectMake(mScreenW*i , 0, mScreenW, mScreenH);
            [_scrollView addSubview:imageView];
            if (i==3) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(100, mScreenH*3/4.0,mScreenW-200 ,40);
                [imageView addSubview:button];
                button.backgroundColor = [UIColor colorWithRed:236/255.0 green:241/255.0 blue:152/255.0 alpha:1];
                [button setTitle:@"点击进入应用" forState:UIControlStateNormal];
                imageView.userInteractionEnabled = YES;
                [button addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    else{
        BaseController *rootVC = [[BaseController alloc]init];
        self.window.rootViewController = rootVC;
    }
}
-(void)buttonDidClick:(UIButton *)sender{
    [self.scrollView removeFromSuperview];
    BaseController *rootVC = [[BaseController alloc]init];
    self.window.rootViewController = rootVC;
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

@end
