//
//  SuperVC.h
//  WhoChat
//
//  Created by Loser on 16/8/31.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuperVC : UIViewController

- (void)setLeftBackBarItme;
// 设置导航栏左按钮，是否高亮
- (void)leftBarButtonWithName:(NSString *)name
                    imageName:(NSString *)imageName
                   heighlight:(BOOL)heighlight
                       target:(id)target
                       action:(SEL)action;
// 设置导航栏右按钮，是否高亮
- (void)rightBarButtonWithName:(NSString *)name
                     imageName:(NSString *)imageName
                    heighlight:(BOOL)heighlight
                        target:(id)target
                        action:(SEL)action;
@end
