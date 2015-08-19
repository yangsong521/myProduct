//
//  NewsDetailController.m
//  Groupproject
//
//  Created by lanou3g on 15/6/21.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "NewsDetailController.h"
#import "Marcro.h"

@interface NewsDetailController () <UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic,assign) CGFloat beginX;
@property(nonatomic,assign) CGFloat endX;
@end

@implementation NewsDetailController

-(void)dealloc{
    _webView = nil;
    
}
- (IBAction)buttonAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",mNewsdetail,self.articleID]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError || !data) {
            return ;
        }
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString *htmlString = [dict objectForKey:@"body"];
        NSMutableString *string = [NSMutableString stringWithString:htmlString];
        [self changeString:string];
        [self.webView loadHTMLString:string baseURL:nil];
        
    }];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan: )];
    [self.webView addGestureRecognizer:pan];
    pan.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if ([otherGestureRecognizer.view isKindOfClass:[UIScrollView class]]) {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)changeString:(NSMutableString *)HtmlString{
    NSString *string = @".jpg";
    NSString *string1 = @".gif";
    NSString *insertString= @"style=\"display:block;width:100%;\"";
    for (int i =0; i<HtmlString.length - string.length +1; i++) {
        if ([[HtmlString substringWithRange:NSMakeRange(i, string.length)] isEqualToString:string] || [[HtmlString substringWithRange:NSMakeRange(i, string.length)] isEqualToString:string1]) {
            [HtmlString insertString:insertString atIndex:i + 5];
        }
    }
}

@end
