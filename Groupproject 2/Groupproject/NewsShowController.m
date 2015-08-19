//
//  NewsShowController.m
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NewsShowController.h"
#import "NewsShowView.h"
#import "Marcro.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"
#import "NewCell.h"
#import "NewsCellWithoutImage.h"
#import "HeadScrview.h"
#import "MJRefresh.h"
#import "NewsDetailController.h"
#define mTime 7
#define mTimer 8

@interface NewsShowController () <UITableViewDataSource,UITableViewDelegate,NewsShowViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong) NewsShowView *rootView;
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) NSDictionary *titleDict;
@property(nonatomic,copy) NSString *lastID;
@property(nonatomic,strong) NSTimer *timer;

@property(nonatomic,assign) CGFloat beginX;
@property(nonatomic,assign) CGFloat endX;
@end

@implementation NewsShowController

-(NSDictionary *)titleDict{
    if (_titleDict == nil) {
        _titleDict = [NSDictionary dictionaryWithObjectsAndKeys:@"不许无聊",@"11", @"用户推荐日报",@"12",@"电影日报",@"3",@"日常心理学",@"13",@"设计日报",@"4",@"大公司日报",@"5",@"财经日报",@"6",@"互联网安全",@"10",@"开始游戏",@"2",@"音乐日报",@"7",@"动漫日报",@"9",@"体育日报",@"8",nil];
        //        _titleDict =[NSDictionary dictionaryWithObjectsAndKeys:@"11",@"不许无聊",@"1",@"首页",@"3",@"电影日报",@"13",@"日常心理学",@"4",@"设计日报",@"5",@"大公司日报",@"6",@"财经日报",@"10",@"互联网安全",@"2",@"开始游戏",@"7",@"音乐日报",nil];
    }
    return _titleDict;
}


-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArray;
}

-(void)loadView{
    self.rootView = [[NewsShowView alloc]initWithFrame:mScreen];
    self.view = self.rootView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.rootView.tableView.delegate = self;
    self.rootView.tableView.dataSource = self;
    self.rootView.delegate = self;
    self.rootView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self changeFrame];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:mTimer target:self selector:@selector(changeFrame) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    self.rootView.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.rootView.tableView.footer.hidden = NO;
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",mThemeURl,self.theme];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        if (data == nil || connectionError) {
            return ;
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *array = [dict objectForKey:@"stories"];
        for (NSDictionary *newDict in array) {
            NewsModel *new = [[NewsModel alloc]init];
            [new setValuesForKeysWithDictionary:newDict];
            [self.dataArray addObject:new];
        }
        self.lastID = [self.dataArray[self.dataArray.count-1] articleID];
        NSString *themeBg = [dict objectForKey:@"background"];
        [self.rootView.headImageView sd_setImageWithURL:[NSURL URLWithString:themeBg] placeholderImage:nil options:SDWebImageRetryFailed];
        [self.rootView.tableView reloadData];
    }];
    
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan: )];
    [self.rootView.tableView addGestureRecognizer:pan];
    pan.delegate = self;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([otherGestureRecognizer.view isKindOfClass:[UITableView class]]) {
        return YES;
    }
    return NO;
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

-(void)changeFrame{
    int x = arc4random()%(20)+10;
    int y = arc4random()%((int)(mScreenW*648/768.0 - 0.5*mScreenW)/2-30) +10;
    int w = arc4random_uniform(10)+25;
    int h = arc4random_uniform(10)+25;
    
    CGFloat imageX = self.rootView.headImageView.frame.origin.x;
    CGFloat imageY = self.rootView.headImageView.frame.origin.y;
    CGFloat imageW = self.rootView.headImageView.frame.size.width;
    CGFloat imageH = self.rootView.headImageView.frame.size.height;
    
    
    int flag = arc4random_uniform(6);
    
    if (flag == 1) {
        [UIView animateWithDuration:mTime animations:^{
            self.rootView.headImageView.frame = CGRectMake(imageX+x, imageY+y, imageW, imageH);
        } completion:^(BOOL finished) {
            self.rootView.headImageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
            [UIView animateWithDuration:0.25 animations:^{
                self.rootView.headImageView.alpha = 0;
                self.rootView.headImageView.alpha = 1;
            }];
        }];
        
    }
    if (flag == 2) {
        [UIView animateWithDuration:mTime animations:^{
            self.rootView.headImageView.frame = CGRectMake(imageX+x, imageY-y, imageW, imageH);
        } completion:^(BOOL finished) {
            self.rootView.headImageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
            [UIView animateWithDuration:0.25 animations:^{
                
                self.rootView.headImageView.alpha = 0;
                self.rootView.headImageView.alpha = 1;
            }];

        }];
        
    }
    if (flag == 3) {
        [UIView animateWithDuration:mTime animations:^{
            self.rootView.headImageView.frame = CGRectMake(imageX-x, imageY+y, imageW, imageH);
        } completion:^(BOOL finished) {
            self.rootView.headImageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
            [UIView animateWithDuration:0.25 animations:^{
                
                self.rootView.headImageView.alpha = 0;
                self.rootView.headImageView.alpha = 1;
            }];

        }];
    }
    if (flag == 4) {
        [UIView animateWithDuration:mTime animations:^{
            self.rootView.headImageView.frame = CGRectMake(imageX-x, imageY-y, imageW, imageH);
        } completion:^(BOOL finished) {
            self.rootView.headImageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
            [UIView animateWithDuration:0.25 animations:^{
                self.rootView.headImageView.alpha = 0;
                self.rootView.headImageView.alpha = 1;
            }];

        }];
    }
    if (flag == 5) {
        [UIView animateWithDuration:9 animations:^{
            self.rootView.headImageView.frame = CGRectMake(imageX, imageY, imageW+w, imageH+h);
        } completion:^(BOOL finished) {
            self.rootView.headImageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
            [UIView animateWithDuration:0.25 animations:^{
                self.rootView.headImageView.alpha = 0;
                self.rootView.headImageView.alpha = 1;
            }];
            
        }];
    }
}

-(void)buttonDidClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)refreshData{
    NSString *urlString = [NSString stringWithFormat:@"%@%@/before/%@",mThemeURl,self.theme,self.lastID];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data == nil || connectionError) {
            return ;
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = [dict objectForKey:@"stories"];
        for (NSDictionary *newDict in array) {
            NewsModel *new = [[NewsModel alloc]init];
            [new setValuesForKeysWithDictionary:newDict];
            [self.dataArray addObject:new];
        }
        self.lastID = [self.dataArray[self.dataArray.count-1] articleID];
        [self.rootView.tableView reloadData];
        [self.rootView.tableView.footer endRefreshing];
    }];
    [self.rootView.tableView.footer endRefreshing];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel *news = self.dataArray[indexPath.row];
    if (news.images != nil) {
        NewCell *cell = [NewCell newCellWithTableView:tableView];
        cell.newsModel = news;
        return cell;
    }
    else{
        NewsCellWithoutImage *cell = [NewsCellWithoutImage newsCellWithoutImage:tableView];
        cell.newsModel = news;
        return cell;
    }
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [NewCell cellHeight];
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.titleDict objectForKey:self.theme];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsDetailController *vc = [[NewsDetailController alloc]init];
    vc.articleID = [self.dataArray[indexPath.row] articleID];
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectio{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)sectio{
    return CGFLOAT_MIN;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
