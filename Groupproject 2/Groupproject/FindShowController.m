//
//  FindShowController.m
//  Groupproject
//
//  Created by lanou3g on 15/6/27.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "FindShowController.h"
#import "SignatrueEncryption.h"
#import "FindModel.h"
#import "FindCell.h"
#import "MJRefresh.h"
#import "FindMapController.h"
#import "FindDetailController.h"
#import "Marcro.h"

#define mBusinesses @"http://api.dianping.com/v1/business/find_businesses?"

@interface FindShowController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableViwe;
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,assign) int flag;

@property(nonatomic,assign) CGFloat beginX;
@property(nonatomic,assign) CGFloat endX;
@end

@implementation FindShowController
- (IBAction)buttonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


-(NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.flag = 1;
    self.tableViwe.delegate = self;
    self.tableViwe.dataSource = self;
    self.tableViwe.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    
    [self loadDataWithLatitude:self.latitude withLontitude:self.longitude];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan: )];
    [self.tableViwe addGestureRecognizer:pan];
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
-(void)refreshData{
    self.flag ++;
    [self loadDataWithLatitude:self.latitude withLontitude:self.longitude];
    [self.tableViwe.footer endRefreshing];
    if (self.flag == 2) {
        [self.tableViwe.footer noticeNoMoreData];
    }
}
-(void)loadDataWithLatitude:(CLLocationDegrees)latitude withLontitude:(CLLocationDegrees)lontitude{
    NSString *page = [NSString stringWithFormat:@"%d",self.flag];
    NSString *lat = [NSString stringWithFormat:@"%f",self.latitude];
    NSString *lon = [NSString stringWithFormat:@"%f",self.longitude];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.category,@"category", lat,@"latitude",lon,@"longitude",@"1",@"sort",@"20",@"limit",@"1",@"offset_type",@"1",@"out_offset_type",page,@"page",nil];
    
    NSDictionary *dic = [SignatrueEncryption encryptedParamsWithBaseParams:(NSMutableDictionary *)dict];
    NSString *sign = dic[@"sign"];
    NSString *urlString = [NSString stringWithFormat:@"%@appkey=42960815&sign=%@&category=%@&latitude=%@&longitude=%@&sort=1&limit=20&offset_type=1&out_offset_type=1&page=%@",mBusinesses,sign,self.category,lat,lon,page];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data == nil || connectionError) {
            return ;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = [dict objectForKey:@"businesses"];
        for (NSDictionary *dic in array) {
            FindModel *model = [[FindModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.dataArray addObject:model];
        }
        [self.tableViwe reloadData];
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FindCell *cell = [FindCell findCell:tableView];
    cell.findModel = self.dataArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [FindCell Height];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *keywords = [@"麻辣诱惑" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"dianping://shoplist?q=%@",keywords]];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    } else {
        //没有安装应用，默认打开HTML5站
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://m.dianping.com/search.aspx?skey=%@", keywords]];
        [[UIApplication sharedApplication] openURL:url];
    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
