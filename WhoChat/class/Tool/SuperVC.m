//
//  SuperVC.m
//  WhoChat
//
//  Created by Loser on 16/8/31.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "SuperVC.h"
#import "Common.h"
#import "helper.h"
#import "UIView+Frame.h"
#define barItmeHeight                     20

@interface SuperVC ()

@end

@implementation SuperVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigation];
}


- (void)setLeftBackBarItme
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = YFrame(0, 0, 20, barItmeHeight);
    [button setBackgroundImage:YImage(@"navigationButtonReturnClick") forState:UIControlStateNormal];
    [button setBackgroundImage:YImage(@"navigationButtonReturnClick") forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(leftBackBarItmeClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
- (void)leftBackBarItmeClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setNavigation
{
    // 设置返回按钮字体颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    // 设置导航栏样式
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    // 设置导航栏不透明
    self.navigationController.navigationBar.translucent = NO;
    // 设置导航栏的字体大小和颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:YdeFaultFont(17)};
    // 去掉导航栏下面的线
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    if (IOS7) {
        // 遮住导航底部1px的阴影
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
        CGRect maskRect = CGRectMake(0, -20, YScreenWidth, 64);
        maskLayer.path = CGPathCreateWithRect(maskRect, NULL);
        self.navigationController.navigationBar.layer.mask = maskLayer;
    }
    else
    {
       
    }
    
    // 设置导航栏背景图
    [self.navigationController.navigationBar setBackgroundImage:[helper getPureColorImageWithSize:YSize(YScreenWidth, 64) withColor:[helper getColor:@"ef7a82"]] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 设置导航栏左按钮，是否高亮
- (void)leftBarButtonWithName:(NSString *)name
                    imageName:(NSString *)imageName
                    heighlight:(BOOL)heighlight
                    target:(id)target
                    action:(SEL)action
{
    UIButton *leftBtn = [self setButtonTitleName:name imageName:imageName heighlight:heighlight];
    [leftBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
}

// 设置导航栏右按钮，是否高亮
- (void)rightBarButtonWithName:(NSString *)name
                    imageName:(NSString *)imageName
                   heighlight:(BOOL)heighlight
                       target:(id)target
                       action:(SEL)action
{
    UIButton *rightBtn = [self setButtonTitleName:name imageName:imageName heighlight:heighlight];
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (UIButton *)setButtonTitleName:(NSString *)name  imageName:(NSString *)imgageName  heighlight:(BOOL)heightlight
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if (imgageName.length != 0 && imgageName) {
        UIImage *image = YImage(imgageName);
        if (IOS7) {
            
            button.frame = YFrame(0, 0, barItmeHeight * image.size.width / image.size.height , barItmeHeight);
        }
        else
        {
            button.frame = YFrame(0, 0, barItmeHeight * image.size.width / image.size.height + barItmeHeight, barItmeHeight);
        }
        
        [button setBackgroundImage:image forState:UIControlStateNormal];
    }
    else
    {
        button.frame = YFrame(0, 0, 50, barItmeHeight);
    }
    
    
    if (name.length != 0 && name) {
        button.titleLabel.font = YdeFaultFont(15);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [button setTitle:name forState:UIControlStateNormal];
    }
    
    if (!heightlight) {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    }
    
    
    
    return button;
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
