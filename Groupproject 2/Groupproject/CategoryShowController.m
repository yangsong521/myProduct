//
//  CategoryShowController.m
//  Groupproject
//
//  Created by lanou3g on 15/7/5.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CategoryShowController.h"
#import "Marcro.h"
#import "VideoModel.h"
#import "VideoCell.h"
#import "DetailController.h"
#import "MJRefresh.h"
#import "EndView.h"

#define yShowURL @"http://baobab.wandoujia.com/api/v1/videos?categoryName="

@interface CategoryShowController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,copy) NSString *nextPageURL;
@property(nonatomic,strong) NSMutableArray *dataArray;


@property(nonatomic,assign) CGFloat beginX;
@property(nonatomic,assign) CGFloat endX;
@end

@implementation CategoryShowController

-(void)dealloc{
    self.view = nil;
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self layoutUI];
    [self loadNetWork];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    self.tableView.footer.hidden = NO;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.tableView addGestureRecognizer:pan];
    pan.delegate = self;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([otherGestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]]) {
        return NO;
    }
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
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.nextPageURL]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data == nil || connectionError) {
            return ;
        }
        [self dataDictFromLoadData:data];
    }];
    [self.tableView.footer endRefreshing];
}

-(void)layoutUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, mScreenW, mScreenH-50) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, mScreenW, 30)];
    headView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:headView];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:button];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, mScreenW, 30)];
//    label.center = headView.center;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    NSString *string = @"#";
    label.text = [string stringByAppendingString:self.name];
    
    [headView addSubview:label];
}

-(void)buttonAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loadNetWork{
    NSString *url = [[NSString stringWithFormat:@"%@%@",yShowURL,self.name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data == nil || connectionError) {
            return ;
        }
        [self dataDictFromLoadData:data];
    }];
}
-(void)dataDictFromLoadData:(NSData *)data{
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = [dict objectForKey:@"videoList"];
    self.nextPageURL = [dict objectForKey:@"nextPageUrl"];
    if ([_nextPageURL isKindOfClass:[NSNull class]]) {
        [self.tableView.footer removeFromSuperview];
        
        self.tableView.tableFooterView = [EndView endView];
    }
    for (NSDictionary *dic in array) {
        VideoModel *model = [[VideoModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [self.dataArray addObject:model];
    }
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VideoCell *cell = [VideoCell videoCellWithTableView:tableView];
    cell.videoModel = self.dataArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [VideoCell Height];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailController *vc = [[DetailController alloc]init];
    vc.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
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
