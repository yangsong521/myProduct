//
//  CategoryController.m
//  Groupproject
//
//  Created by lanou3g on 15/7/5.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "CategoryController.h"
#import "Marcro.h"
#import "CategoryShowController.h"
#define yCategory @"http://baobab.wandoujia.com/api/v1/categories"

@interface CategoryController ()
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic,strong) NSMutableArray *titleArray;
@property(nonatomic,assign) CGFloat beginX;
@property(nonatomic,assign) CGFloat endX;

@end

@implementation CategoryController
-(NSMutableArray *)titleArray{
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray arrayWithObjects:@"创意",@"运动",@"旅行",@"剧情",@"动画",@"广告",@"音乐",@"开胃",@"预告",@"综合", nil ];
    }
    return _titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self layoutUI];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)layoutUI{
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    _scrollView.contentSize = CGSizeMake(mScreenW, mScreenW*2.5);
    _scrollView.bounces = NO;
    CGFloat buttonW = mScreenW/2.0;
    for (int i=0; i<10; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i%2*buttonW, i/2*buttonW, buttonW, buttonW);
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"category_%d.jpeg",i]] forState:UIControlStateNormal];
        [button setTitle:[NSString stringWithFormat:@"#%@",self.titleArray[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
    }
}
-(void)buttonDidClicked:(UIButton *)sender{
    CategoryShowController *vc = [[CategoryShowController alloc]init];
    vc.name = [sender.titleLabel.text substringFromIndex:1];
    [self.parentViewController.navigationController pushViewController:vc animated:YES];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.view.frame = CGRectMake(0, 55, mScreenW, mScreenH-55-49);
    _scrollView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
