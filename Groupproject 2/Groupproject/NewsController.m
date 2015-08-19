//
//  NewsController.m
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NewsController.h"
#import "NewsView.h"
#import "Marcro.h"
#import "NewsShowController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "NewsDetailController.h"

#define mLastest @"http://news-at.zhihu.com/api/4/stories/latest"

@interface NewsController () <NewsViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong) NewsView *rootView;
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) NSMutableArray *titleArray;
@property(nonatomic,strong) NSMutableArray *idArray;
@property(nonatomic,assign) UIImageView *firstImageV;
@property(nonatomic,assign) UIImageView *currentImageV;
@property(nonatomic,assign) UIImageView *nextImageV;

@property(nonatomic,copy) NSString *acticlID;

@property(nonatomic,assign) UILabel *firstLabel;
@property(nonatomic,assign) UILabel *currentLabel;
@property(nonatomic,assign) UILabel *nextLabel;

@property(nonatomic,assign) NSInteger index;
@property(nonatomic,assign) CGFloat offSet;
@property(nonatomic,strong) NSTimer *timer;
@end

@implementation NewsController

-(void)loadView{
    self.rootView = [[NewsView alloc]initWithFrame:mScreen];
    self.view = self.rootView;
}

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    self.index = 0;
    self.dataArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"", nil];
    self.titleArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"", nil];
    self.idArray = [NSMutableArray array ];
    self.rootView.delegate = self;
    self.rootView.headScrollView.delegate = self;
    [self networkLoad];
    
}

-(void)addTimer{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)removeTimer{
    [self.timer invalidate];
}

-(void)nextImage{
    [UIView animateWithDuration:0.25 animations:^{
        self.rootView.headScrollView.contentOffset = CGPointMake(2*mScreenW, 0);
    }];
     
    [self scrollViewDidEndDecelerating:self.rootView.headScrollView];
}

-(void)networkLoad{
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:mLastest]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError || data == nil) {
            return ;
        }
        self.dataArray = [NSMutableArray array];
        self.titleArray = [NSMutableArray array];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = [dict objectForKey:@"top_stories"];
        for (NSDictionary *dic in array) {
            NSString *imageString = [dic objectForKey:@"image"];
            NSString *titltString = [dic objectForKey:@"title"];
            NSString *idString = [NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]];
            titltString = [titltString stringByAppendingString:idString];
            [self.dataArray addObject:imageString];
            [self.titleArray addObject:titltString];
            [self.idArray addObject:idString];
        }
        NSInteger number = self.dataArray.count;
        
        for (int i =0; i<3; i++) {
            UIScrollView *scroll = (UIScrollView *)[self.rootView.headScrollView viewWithTag:(100+i)];
            if (i==0) {
                self.firstImageV = (UIImageView *)scroll.subviews[0];
                [_firstImageV sd_setImageWithURL:[NSURL URLWithString:self.dataArray[number-1]] placeholderImage:nil options:SDWebImageRetryFailed];
                self.firstLabel = (UILabel *)self.firstImageV.subviews[1];
                NSInteger index = [self.titleArray[number-1] length] - 7;
                _firstLabel.text = [self.titleArray[number-1] substringToIndex:index] ;
            }
            if (i==1) {
                self.currentImageV = (UIImageView *)scroll.subviews[0];
                [_currentImageV sd_setImageWithURL:[NSURL URLWithString:self.dataArray[self.index]] placeholderImage:nil options:SDWebImageRetryFailed];
                self.currentLabel = (UILabel *)self.currentImageV.subviews[1];
                self.currentLabel.font = [UIFont fontWithName:@"MicrosoftYaHei" size:20];
                _currentLabel.text = [self.titleArray[self.index] substringToIndex:[self.titleArray[self.index]length]-7];
                NSInteger lenth = [self.titleArray[self.index] length];
                self.acticlID = [self.titleArray[self.index] substringFromIndex:lenth-7];
            }
            if (i==2) {
                self.nextImageV = (UIImageView *)scroll.subviews[0];
                [_nextImageV sd_setImageWithURL:[NSURL URLWithString:self.dataArray[self.index+1]] placeholderImage:nil options:SDWebImageRetryFailed];
                self.nextLabel = (UILabel *)self.nextImageV.subviews[1];
                _nextLabel.text = [self.titleArray[self.index+1] substringToIndex:[self.titleArray[self.index+1]length]-7];
            }
        }
        [self addTimer];
    }];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    if (self.dataArray.count == 0) {
        return;
    }
    
    if (scrollView.contentOffset.x < mScreenW) {
        if (self.index == 0) {
            self.index = self.dataArray.count - 1;
        }
        else{
            self.index --;
        }
    }
    if (scrollView.contentOffset.x>mScreenW) {
        if (self.index == self.dataArray.count -1) {
            self.index = 0;
        }
        else{
            self.index ++;
        }
    }
    [self.currentImageV sd_setImageWithURL:[NSURL URLWithString:self.dataArray[self.index]] placeholderImage:nil options:SDWebImageRetryFailed];
    _currentLabel.text = [self.titleArray[self.index] substringToIndex:[self.titleArray[self.index]length]-7];
    self.acticlID = [self.titleArray[self.index] substringFromIndex:[self.titleArray[self.index]length]-7];
    if (self.index == 0) {
        [self.firstImageV sd_setImageWithURL:[NSURL URLWithString:self.dataArray[self.dataArray.count - 1]] placeholderImage:nil options:SDWebImageRetryFailed];
        _firstLabel.text = [self.titleArray[self.dataArray.count - 1] substringToIndex:[self.titleArray[self.dataArray.count - 1] length]-7];
    }
    else{
        [self.firstImageV sd_setImageWithURL:[NSURL URLWithString:self.dataArray[self.index - 1]] placeholderImage:nil options:SDWebImageRetryFailed];
        _firstLabel.text = [self.titleArray[self.index - 1] substringToIndex:[self.titleArray[self.index - 1]length]-7];
    }
    if (self.index == self.dataArray.count-1) {
        [self.nextImageV sd_setImageWithURL:[NSURL URLWithString:self.dataArray[0]] placeholderImage:nil options:SDWebImageRetryFailed];
        _nextLabel.text = [self.titleArray[0] substringToIndex:[self.titleArray[0]length]-7];
    }
    else{
        [self.nextImageV sd_setImageWithURL:[NSURL URLWithString:self.dataArray[self.index + 1]] placeholderImage:nil options:SDWebImageRetryFailed];
        _nextLabel.text = [self.titleArray[self.index + 1] substringToIndex:[self.titleArray[self.index + 1]length]-7];
    }
    self.rootView.headScrollView.contentOffset = CGPointMake(mScreenW, 0);
    
    self.rootView.pageControl.currentPage = self.index;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self addTimer];
}
-(void)headButton{
    NewsDetailController *vc = [[NewsDetailController alloc]init];
    vc.articleID = self.acticlID;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)buttonDidClicked:(NSString *)themeName{
    AFNetworkReachabilityManager *magr = [AFNetworkReachabilityManager sharedManager];
    [magr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
                [alert show];
            }
                break;
            case AFNetworkReachabilityStatusNotReachable:{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络错误" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles: nil];
                [alert show];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                NewsShowController *vc = [[NewsShowController alloc]init];
                vc.theme = themeName;
                [self.navigationController pushViewController:vc animated:NO];
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                NewsShowController *vc = [[NewsShowController alloc]init];
                vc.theme = themeName;
                [self.navigationController pushViewController:vc animated:NO];
            }
                break;
            default:
                break;
        }
    }];

    [magr startMonitoring];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
