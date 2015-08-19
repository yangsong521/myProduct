//
//  MusicController.m
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "MusicController.h"
#import "Marcro.h"
#import "MusicView.h"
#import "VideoModel.h"
#import "VideoCell.h"
#import "DetailController.h"
#import "DetailControllerBack.h"
#import "MJRefresh.h"
#import "CategoryController.h"

#define mVideoURL @"http://baobab.wandoujia.com/api/v1/feed"

@interface MusicController ()<UITableViewDataSource,UITableViewDelegate,MusicViewDelegate>
@property(nonatomic,strong) MusicView *rootView;
@property(nonatomic,strong) NSMutableDictionary *dataDict;
@property(nonatomic,strong) NSMutableArray *timeArray;
@property(nonatomic,assign) UIViewController *childVC;
@property(nonatomic,assign) int flag;
@property(nonatomic,strong) UIButton *selectedButton;
@end

@implementation MusicController

-(NSMutableDictionary *)dataDict{
    if (_dataDict == nil) {
        _dataDict = [NSMutableDictionary dictionary];
    }
    return _dataDict;
}

-(NSMutableArray *)timeArray{
    if (_timeArray == nil) {
        _timeArray = [NSMutableArray array];
    }
    return _timeArray;
}

-(void)loadView{
    self.rootView = [[MusicView alloc]initWithFrame:mScreen];
    self.view = self.rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self todayButtonDidClicked:self.rootView.abutton];
    CategoryController *vc = [[CategoryController alloc]init];
    [self addChildViewController:vc];
    self.childVC = vc;
    
    self.flag = 1;
    self.rootView.delegate = self;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.rootView.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.rootView.tableView.footer.hidden = NO;
    
    
    self.rootView.tableView.delegate = self;
    self.rootView.tableView.dataSource = self;
    self.rootView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadNetWork];
}

-(void)loadNetWork{
    
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:mVideoURL]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data == nil || connectionError) {
            return ;
        }
        
        [self dataDictFromLoadData:data withDate:[NSDate date]];
    }];
}

-(void)refreshData{
    if (self.dataDict.count == 0) {
        self.flag = 0;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyyMMdd";
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:-self.flag * 24 * 60 * 60];
    NSString *timeString = [formatter stringFromDate:date];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?date=%@",mVideoURL,timeString]]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data == nil || connectionError) {
            return ;
        }
        
        [self dataDictFromLoadData:data withDate:date];
        self.flag ++;
    }];
    [self.rootView.tableView.footer endRefreshing];
}

-(void)dataDictFromLoadData:(NSData *)data withDate:(NSDate *)date{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *dataArr = [dict objectForKey:@"dailyList"];
    for (NSDictionary *dataDic in dataArr) {
        NSArray *array = [dataDic objectForKey:@"videoList"];
        NSMutableArray *videoArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            VideoModel *model = [[VideoModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [videoArray addObject:model];
        }
        [self.dataDict setObject:videoArray forKey:[self TimeWithDate:date]];
        [self.timeArray addObject:[self TimeWithDate:date]];
    }
    [self.rootView.tableView reloadData];
}

-(NSString *)TimeWithDate:(NSDate *)date{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy年MM月dd日";
    NSString *timeString = [formatter stringFromDate:date];
    return timeString;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.timeArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.dataDict objectForKey:self.timeArray[section]] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoCell *cell = [VideoCell videoCellWithTableView:tableView];
    cell.videoModel = [[self.dataDict objectForKey:self.timeArray[indexPath.section]] objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailController *vc = [[DetailController alloc]init];
    vc.model = [[self.dataDict objectForKey:self.timeArray[indexPath.section]] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [VideoCell Height];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.timeArray[section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectio{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)sectio{
    return CGFLOAT_MIN;
}

-(void)categoryButtonDidClicked:(UIButton *)sender{
    [self changeColor:sender];
    [self.rootView addSubview:self.childVC.view];
}
-(void)todayButtonDidClicked:(UIButton *)sender{
    [self changeColor:sender];
    [self.childVC.view removeFromSuperview];
}
-(void)changeColor:(UIButton *)sender{
    [self.selectedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.selectedButton = sender;
    CGFloat color = 183/255.0;
    [sender setTitleColor:[UIColor colorWithRed:color green:color blue:color alpha:1] forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
