//
//  FindDetailController.m
//  Groupproject
//
//  Created by lanou3g on 15/6/30.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "FindDetailController.h"
#import "SignatrueEncryption.h"
#define mBussinessURL @"http://api.dianping.com/v1/business/get_single_business?appkey=42960815&out_offset_type=1&platform=2&business_id="

@interface FindDetailController ()
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation FindDetailController

- (void)viewDidLoad {
    [super viewDidLoad];

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
