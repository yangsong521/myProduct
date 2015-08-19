//
//  BaseController.m
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "BaseController.h"
#import "DDNavigationController.h"
#import "NewsController.h"
#import "FindController.h"
#import "ChatController.h"
#import "MusicController.h"

@interface BaseController () <UITabBarControllerDelegate>

@end

@implementation BaseController

- (void)viewDidLoad {
    
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedRightButton:)];
    
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    [self.view addGestureRecognizer:swipeLeft];
    
    
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(tappedLeftButton:)];
    
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self.view addGestureRecognizer:swipeRight];
    
    [super viewDidLoad];
    NewsController *newsVC = [[NewsController alloc]init];
    DDNavigationController *newsNC = [[DDNavigationController alloc]initWithRootViewController:newsVC];
    [self addController:newsNC Title:@"新鲜事" imageName:@"home_0" HighlightImageName:@""];
    
    FindController *findVC = [[FindController alloc]init];
    DDNavigationController *findNC = [[DDNavigationController alloc]initWithRootViewController:findVC];
    [self addController:findNC Title:@"发现" imageName:@"home_1" HighlightImageName:@""];
    
    MusicController *musicVC = [[MusicController alloc]init];
    DDNavigationController *musicNC = [[DDNavigationController alloc]initWithRootViewController:musicVC];
    [self addController:musicNC Title:@"随便看" imageName:@"home_2" HighlightImageName:@""];
    self.delegate = self;
    
    ChatController *chatVC = [[ChatController alloc]init];
    DDNavigationController *chatNC = [[DDNavigationController alloc]initWithRootViewController:chatVC];
    [self addController:chatNC Title:@"聊天" imageName:@"home_3" HighlightImageName:@""];
}

-(void)tappedRightButton:(UIGestureRecognizer *)sender
{
    self.tabBar.hidden = NO;
    NSUInteger selectedIndex = [self selectedIndex];

    NSArray *aryViewController = self.viewControllers;
    
    if (selectedIndex < aryViewController.count - 1) {
        
        UIView *fromView = [self.selectedViewController view];
        
        UIView *toView = [[self.viewControllers objectAtIndex:selectedIndex + 1] view];
        
        [UIView transitionFromView:fromView toView:toView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
            if (finished) {
                [self setSelectedIndex:selectedIndex + 1];
            }
        }];
    }
    if (selectedIndex == aryViewController.count-1) {
        UIView *fromView = [self.selectedViewController view];
        
        UIView *toView = [[self.viewControllers objectAtIndex:0] view];
        
        [UIView transitionFromView:fromView toView:toView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
            
            if (finished) {
                
                [self setSelectedIndex:0];
            }
        }];
        
    }


}
- (void)tappedLeftButton:(UIGestureRecognizer *)sender
{
    self.tabBar.hidden = NO;
    NSUInteger selectedIndex = [self selectedIndex];

    if (selectedIndex > 0) {
        
        UIView *fromView = [self.selectedViewController view];
        
        UIView *toView = [[self.viewControllers objectAtIndex:selectedIndex - 1] view];
        
        [UIView transitionFromView:fromView toView:toView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
            
            if (finished) {
                
                [self setSelectedIndex:selectedIndex - 1];
            }
        }];
    }
    if (selectedIndex == 0) {
        UIView *fromView = [self.selectedViewController view];
        
        UIView *toView = [[self.viewControllers objectAtIndex:self.childViewControllers.count-1] view];
        
        [UIView transitionFromView:fromView toView:toView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
            
            if (finished) {
                
                [self setSelectedIndex:self.childViewControllers.count-1];
            }
        }];
    }
}

-(void)addController:(UIViewController *)childController Title:(NSString *)title imageName:(NSString *)imageName HighlightImageName:(NSString *)highlight{
    childController.tabBarItem.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.selectedImage = [UIImage imageNamed:highlight];
    [self addChildViewController:childController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
