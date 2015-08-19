//
//  BaseNoNetController.m
//  Groupproject
//
//  Created by lanou3g on 15/7/1.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "BaseNoNetController.h"
#import "ViewController.h"

@interface BaseNoNetController ()

@end

@implementation BaseNoNetController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ViewController *newsVC = [[ViewController alloc]init];
    [self addController:newsVC Title:@"新鲜事" imageName:@"home_0" HighlightImageName:@""];
    
    ViewController *findVC = [[ViewController alloc]init];
    [self addController:findVC Title:@"发现" imageName:@"home_1" HighlightImageName:@""];
    
    ViewController *musicVC = [[ViewController alloc]init];
    [self addController:musicVC Title:@"随便看" imageName:@"home_2" HighlightImageName:@""];
    
    ViewController *chatVC = [[ViewController alloc]init];
    [self addController:chatVC Title:@"聊天" imageName:@"home_3" HighlightImageName:@""];
    // Do any additional setup after loading the view.
}
-(void)addController:(UIViewController *)childController Title:(NSString *)title imageName:(NSString *)imageName HighlightImageName:(NSString *)highlight{
    childController.tabBarItem.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.selectedImage = [UIImage imageNamed:highlight];
    [self addChildViewController:childController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
