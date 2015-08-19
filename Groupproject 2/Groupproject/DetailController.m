//
//  DetailController.m
//  Groupproject
//
//  Created by lanou3g on 15/6/28.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "DetailController.h"
#import "DetailView.h"
#import "Marcro.h"
#import <MediaPlayer/MediaPlayer.h>
#import "VideoModel.h"

@interface DetailController ()<DetailViewDelegate>
@property(nonatomic,strong) DetailView *rootView;
@property(nonatomic,assign) CGFloat beginX;
@property(nonatomic,assign) CGFloat endX;
@end

@implementation DetailController

-(void)loadView{
    self.rootView = [[DetailView alloc]initWithFrame:mScreen];
    self.view = self.rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
    self.rootView.delegate = self;
    self.rootView.model = self.model;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    
    [self.rootView.imageView addGestureRecognizer:tap];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan: )];
    [self.rootView addGestureRecognizer:pan];
    
    // Do any additional setup after loading the view.
}

-(void)tapAction{
    
    NSLog(@"sdfsad");
    MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:self.model.playUrl]];
//    [self.navigationController presentViewController:vc animated:YES completion:nil];
    [self.navigationController presentMoviePlayerViewControllerAnimated:vc];
}

-(void)pan:(UIPanGestureRecognizer *)gest{
    if (gest.state == UIGestureRecognizerStateBegan) {
        self.beginX = [gest translationInView:gest.view].x;
    }
    if (gest.state == UIGestureRecognizerStateEnded) {
        self.endX = [gest translationInView:gest.view].x;
        if (self.endX - self.beginX >= mScreenW/2) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

-(void)buttonDidClick{
    [self.navigationController popViewControllerAnimated:YES];
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
