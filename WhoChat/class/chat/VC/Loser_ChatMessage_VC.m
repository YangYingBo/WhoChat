//
//  Loser_ChatMessage_VC.m
//  WhoChat
//
//  Created by Loser on 16/9/5.
//  Copyright © 2016年 Mac. All rights reserved.
//

#define chatInputViewHeight                        60

#import "Loser_ChatMessage_VC.h"
#import "Loser_chat_cell.h"
#import "Loser_chat_model.h"
#import "Loser_chatInputField_view.h"

@interface Loser_ChatMessage_VC ()<UITableViewDelegate,UITableViewDataSource,Loser_XMPPMangerDelegate>
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) Loser_chatInputField_view *chatInputView;
@end

@implementation Loser_ChatMessage_VC

{
    UITableView *myTabView;
    NSIndexPath *newPath;
    BOOL isHindeKeyBoard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"你妹😯";
    [self setLeftBackBarItme];
    
    [Loser_XMPPManger sharedLoserXMPPManger].delegate = self;
    
    self.dataArray = [NSMutableArray array];
    NSArray *titleArray = @[@"吃饭了没有呢",@"吃过了怎么了",@"天气不错哦",@"乌云密布的还好天气  眼瞎啊",@"我说的是后天的天气不错    ",@"吃饭了没有呢吃过了怎么了天气不错哦   乌云密布的还好天气  眼瞎啊  我说的是后天的天气不错  sdadsadef发顺丰v ",@"天气不错哦",@"乌云密布的还好天气  眼瞎啊",@"我说的是后天的天气不错    ",@"吃饭了没有呢吃过了怎么了天气不错哦   乌云密布的还好天气  眼瞎啊  我说的是后天的天气不错  sdadsadef发顺丰v "];
    
    for (NSInteger index = 0 ; index < titleArray.count; index ++) {
        ChatMessageType type = index%2 == 0 ? ChatMessageTypeOther : ChatMessageTypeMe;
        Loser_chat_model *model = [[Loser_chat_model alloc] initModelToMessage:titleArray[index] meHeadImgName:@"美" otherHeadImgName:@"美2" chatType:type];
        [_dataArray addObject:model];
    }
    
    [self initMyTabView];
    
    [self.view addSubview:self.chatInputView];
    [myTabView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    //监控键盘状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)initMyTabView
{
    myTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - chatInputViewHeight - 64) style:UITableViewStylePlain];
    myTabView.showsHorizontalScrollIndicator = NO;
    myTabView.showsVerticalScrollIndicator = NO;
    myTabView.delegate = self;
    myTabView.dataSource = self;
    myTabView.separatorStyle = 0;
    [self.view addSubview:myTabView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Loser_chat_model *model = _dataArray[indexPath.row];
    
    return model.chatCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Loser_chat_cell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[Loser_chat_cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"myCell"];
        cell.selectionStyle = 0;
    }
    
    Loser_chat_model *model = _dataArray[indexPath.row];
    [cell updataCellSubViewFrameAndText:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
}

- (Loser_chatInputField_view *)chatInputView
{
    if (!_chatInputView) {
        _chatInputView = [[Loser_chatInputField_view alloc] initWithFrame:YFrame(0, YScreenHeight - 60 -64, YScreenWidth, chatInputViewHeight)];
        YWeakClass(self);
        
        _chatInputView.sendChatMessageBlock = ^(NSString *message){
            [weakself sendToFriendWithMessage:message fromHereType:ChatMessageTypeMe];
        };
    }
    
    return _chatInputView;
}

- (void)sendToFriendWithMessage:(NSString *)msg fromHereType:(ChatMessageType)chatType
{
    Loser_chat_model *model = [[Loser_chat_model alloc] initModelToMessage:msg meHeadImgName:@"美" otherHeadImgName:@"美2" chatType:chatType];
    [_dataArray addObject:model];
    [myTabView reloadData];
    [myTabView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_dataArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    if (chatType == ChatMessageTypeMe) {
       [[Loser_XMPPManger sharedLoserXMPPManger] sendMessage:msg toUser:@"admin"];
    }
    
}
#pragma mark    =====================   Loser_XMPPMessageDelegate
- (void)getReceiveMessage:(NSString *)msg fromeSomeonePerson:(NSString *)from
{
    [self sendToFriendWithMessage:msg fromHereType:ChatMessageTypeOther];
}

- (void)keyboardWillChange:(NSNotification *)note
{
    NSLog(@"%@",note.userInfo);
    
    NSDictionary *userInfo = note.userInfo;
    
    CGFloat duration = [userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] doubleValue];//键盘改变时间
    CGRect keyFrame = [userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    CGFloat moveY = keyFrame.origin.y - YScreenHeight;// 算出键盘的位移
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, moveY);
    }];
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
