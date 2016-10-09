//
//  Loser_Chat_VC.m
//  WhoChat
//
//  Created by Loser on 16/8/31.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "Loser_Chat_VC.h"
#import "Loser_ChatMessage_VC.h"
#import "Loser_XMPPManger.h"

@interface Loser_Chat_VC ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation Loser_Chat_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self leftBarButtonWithName:@"分类" imageName:nil heighlight:NO target:self action:@selector(fen)];
    BOOL isConnect = [[Loser_XMPPManger sharedLoserXMPPManger] isConnecting];
    
    [self initMyTabView];
    
}

- (void)initMyTabView
{
    UITableView *myTabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-49) style:UITableViewStylePlain];
    myTabView.showsHorizontalScrollIndicator = NO;
    myTabView.showsVerticalScrollIndicator = NO;
    myTabView.delegate = self;
    myTabView.dataSource = self;
    [self.view addSubview:myTabView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"myCell"];
        cell.selectionStyle = 0;
    }
    cell.backgroundColor = [helper getColor:@"ef7a82"];
    cell.textLabel.text = @"你妹来信息了";
    cell.detailTextLabel.text = @"在不签收  就是别人的了😯";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Loser_ChatMessage_VC *messageVC = [[Loser_ChatMessage_VC alloc] init];
    messageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (void)fen
{
    
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
