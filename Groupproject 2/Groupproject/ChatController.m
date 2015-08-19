//
//  ChatController.m
//  Groupproject
//
//  Created by lanou3g on 15/6/19.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ChatController.h"
#import "ChatView.h"
#import "Marcro.h"
#import "ChatModelFrame.h"
#import "ChatCell.h"
#import "ChatModel.h"

@interface ChatController () <ChatViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) ChatView *rootView;
@property(nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation ChatController

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

-(void)loadView{
    self.rootView = [[ChatView alloc]initWithFrame:mScreen];
    self.view = self.rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setApplicationSupportsShakeToEdit:YES];
    
    [self becomeFirstResponder];
    
    
    ChatModel *chatModel = [[ChatModel alloc]init];
    chatModel.time = @"longlong ago...";
    chatModel.date = [NSDate date];
    chatModel.text = @"摇晃手机也可发送消息哦~";
    chatModel.type = YGSMessageModelTypeOther;
    ChatModelFrame *chatModelF = [[ChatModelFrame alloc]init];
    [chatModelF caculateFrameWithChatModel:chatModel WithTimeLabelHeight:30];
    
    [self.dataArray addObject:chatModelF];
    
    self.rootView.delegate = self;
    self.rootView.tableView.delegate = self;
    self.rootView.tableView.dataSource = self;
    self.rootView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.rootView.tableView.allowsSelection = NO;
    self.rootView.tableView.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBordWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    // Do any additional setup after loading the view.
}
-(void)keyBordWillChange:(NSNotification *)notification{
    NSDictionary *dict = notification.userInfo;
    CGRect keyboardFrame = [dict[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    CGFloat keyboardY = keyboardFrame.origin.y;
    CGFloat duration = [dict[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGFloat translationY;
    if (keyboardY == mScreenH) {
        translationY = keyboardY - mScreenH ;
    }
    else{
        translationY = keyboardY - mScreenH + mTabbarH;
    }
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, translationY);
    } completion:^(BOOL finished) {
        ;
    }];
}

-(void)sendButtonDidClicked{
    if (self.rootView.textField.text.length != 0) {
        [self tableviewLoadData:self.rootView.textField.text withMessageType:YGSMessageModelTypeMe];
        [self loadAnswerFromNet:self.rootView.textField.text withMessageType:YGSMessageModelTypeOther];
    }
    self.rootView.textField.text = nil;
}

-(void)tableviewLoadData:(NSString *)textFieldContent withMessageType:(YGSMessageModelType)messageType{
    ChatModel *chatModel = [[ChatModel alloc]init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    chatModel.time = strDate;
    chatModel.date = [NSDate date];
    chatModel.text = textFieldContent;
    chatModel.type = messageType;
    ChatModelFrame *chatModelF = [[ChatModelFrame alloc]init];
    if ([chatModel.date timeIntervalSinceDate:[[[self.dataArray lastObject] chatModel]date]] <= 30) {
        [chatModelF caculateFrameWithChatModel:chatModel WithTimeLabelHeight:0];
    }
    else{
        [chatModelF caculateFrameWithChatModel:chatModel WithTimeLabelHeight:30];
    }
    [self.dataArray addObject:chatModelF];
    [self.rootView.tableView reloadData];
    NSIndexPath *path = [NSIndexPath indexPathForRow:self.dataArray.count -1 inSection:0];
    /*
     AtIndexPath: 要滚动到哪一行
     atScrollPosition:滚动到哪一行的什么位置
     animated:是否需要滚动动画
     */
    [self.rootView.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

-(void)loadAnswerFromNet:(NSString *)string withMessageType:(YGSMessageModelType)messageType{
    NSString *urlString = [NSString stringWithFormat:@"%@%@",mTulingURL,string];
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!data || connectionError) {
            return ;
        }
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSString *text = [dict objectForKeyedSubscript:@"text"];
        [self tableviewLoadData:text withMessageType:messageType];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatCell *cell = [ChatCell chatCellWithTableView:tableView];
    ChatModelFrame *chatModelF = self.dataArray[indexPath.row];
    cell.chatModelF = chatModelF;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.dataArray[indexPath.row] cellHeight];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.view endEditing:YES];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    //检测到摇动
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (event.subtype == UIEventSubtypeMotionShake) {
        if (self.rootView.textField.text.length != 0) {
            [self tableviewLoadData:self.rootView.textField.text withMessageType:YGSMessageModelTypeMe];
            [self loadAnswerFromNet:self.rootView.textField.text withMessageType:YGSMessageModelTypeOther];
        }
        self.rootView.textField.text = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
