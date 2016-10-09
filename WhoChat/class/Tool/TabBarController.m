//
//  TabBarController.m
//  WhoChat
//
//  Created by Loser on 16/8/31.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "TabBarController.h"
#import "Loser_Chat_VC.h"
#import "Loser_Message_VC.h"
#import "Loser_Find_VC.h"
#import "Loser_MySelf_VC.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addChildVC];
}

- (void)addChildVC
{
    Loser_Chat_VC *chat = [[Loser_Chat_VC alloc] init];
    [self addChildVC:chat title:@"聊天" norImageName:@"tabbar_chat_no" seletedImageName:@"tabbar_chat_yes"];
    
    Loser_Message_VC *message = [[Loser_Message_VC alloc] init];
    [self addChildVC:message title:@"消息" norImageName:@"tabbar_book_no" seletedImageName:@"tabbar_book_yes"];
    
    Loser_Find_VC *find = [[Loser_Find_VC alloc] init];
    [self addChildVC:find title:@"发现" norImageName:@"tabbar_found_no" seletedImageName:@"tabbar_found_yes"];
    
    Loser_MySelf_VC *my = [[Loser_MySelf_VC alloc] init];
    [self addChildVC:my title:@"我" norImageName:@"tabbar_me_no" seletedImageName:@"tabbar_me_yes"];
}


- (void)addChildVC:(UIViewController*)childVC title:(NSString *)title norImageName:(NSString *)imageName seletedImageName:(NSString *)selImageName
{
    childVC.title = title;
    
    // 默认字体颜色
    [childVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:YdeFaultFont(12),NSFontAttributeName,[UIColor lightGrayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    // 点击字体颜色
    [childVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:YdeFaultFont(12),NSFontAttributeName,[helper getColor:@"00e500"],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    childVC.tabBarItem.image = YImage(imageName);
    UIImage *selImgae = YImage(selImageName);
    if (IOS7) {
        selImgae = [selImgae imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVC.tabBarItem.selectedImage = selImgae;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVC];
    [self addChildViewController:nav];
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
