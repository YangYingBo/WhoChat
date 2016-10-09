//
//  Loser_Find_VC.m
//  WhoChat
//
//  Created by Loser on 16/8/31.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "Loser_Find_VC.h"

@interface Loser_Find_VC ()

@end

@implementation Loser_Find_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGSize size = [helper calculatedAccordingToTheSizeOfTheString:@"Do any additional setup after loading the viewDo any additional setup after loading the viewDo any additional setup after loading the viewDo any additional setup after loading the viewDo any additional setup after loading the viewDo any additional setup after loading the viewDo any additional setup after loading the view" withHeight:MAXFLOAT withWidth:200 andStringFont:15];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImageView *img = [[UIImageView alloc] initWithFrame:YFrame(0, 100, 280, size.height+0)];
    img.image = YImage(@"chat_send_nor");
    img.contentMode = UIViewContentModeScaleAspectFit;
//    [self.view addSubview:img];
    
    btn.frame = CGRectMake(0, 100, 230, size.height+30);
    btn.backgroundColor = [UIColor redColor];
    [btn setBackgroundImage:[self resizableImage:@"chat_send_nor"] forState:UIControlStateNormal];
    [btn setTitle:@"Do any additional setup after loading the viewDo any additional setup after loading the viewDo any additional setup after loading the viewDo any additional setup after loading the viewDo any additional setup after loading the viewDo any additional setup after loading the viewDo any additional setup after loading the view" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.titleLabel.numberOfLines = 0;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(20, 15, 20, 15);
//    [<#NSString#> addTarget:self action:<#(nonnull SEL)#> forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
}
-(UIImage *)resizableImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat imageWidth = image.size.width *0.5;
    CGFloat imageHeight = image.size.height *0.5;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageHeight, imageWidth, imageHeight, imageWidth) resizingMode:UIImageResizingModeTile];
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
