//
//  Common.h
//  AKangHospital
//
//  Created by 求罩 on 15/10/8.
//  Copyright (c) 2015年 求罩. All rights reserved.
//



#ifndef AKangHospital_Common_h
#define AKangHospital_Common_h

#define YnavHeight                      ([UIScreen mainScreen].bounds.size.height==736? 93: 64)
#define YTarBarHeight                   ([UIScreen mainScreen].bounds.size.height==736? 73: 49)
//获得窗口
#define AppWindow                       ((UIWindow *)[[UIApplication sharedApplication].windows firstObject])

// 弱引用和强引用
#define YWeakClass(type)               __weak typeof(type) weak##type = type
#define YStrongClass(type)             __strong typeof(type) type = stong##type
//获取物理屏幕的大小
// 屏幕bounds
#define YScreenBounds                   [UIScreen mainScreen].bounds
// 屏幕的size
#define YScreenSize                     [UIScreen mainScreen].bounds.size
//获取屏幕 宽度、高度
#define YScreenHeight                   ([UIScreen mainScreen].bounds.size.height)
#define YScreenWidth                    ([UIScreen mainScreen].bounds.size.width)
#define YNavHeight                      64
#define YTabbarHeight                   49


// 默认字号
#define YdeFaultFont(font)                                      [UIFont systemFontOfSize:font]
#define YcustomFontFrameNameAndFont(fontName,font)              [UIFont fontWithName:fontName size:font]

// 网络请求提示
#define SUCCESS @"亲,正在火速前进中!!!"
#define ERROR @"亲,你的网络在开小差哦!!!"
//
#define YFrame(x,y,w,h)                            CGRectMake(x, y, w, h)
#define YImage(imgName)                            [UIImage imageNamed:imgName]
#define YSize(w,h)                                 CGSizeMake(w, h)
//判断系统版本
#define IOS8                                       ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS7                                       [[UIDevice currentDevice].systemVersion floatValue] >= 7.0
#define IOS6                                       ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)

//RGB获取颜色
#define YRGB(r, g, b)                              [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0  alpha:1.0]
#define YRGBA(r, g, b, a)                          [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFromRGB(rgbValue)                    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]





/// block self
#define kSelfWeak(self,weakSelf) __weak typeof(self) weakSelf = self

//导航条高度
#define Navheight 64.f
//导航条按钮
#define backBtnx 15.f
#define backBtny 20.f
#define navBtnSize 44.0f
#define BACKW 46.f
#define BACKH 28.f
#define defaultWidth 10.f
#define FontSize 14.0f
#define timeFont 12.f




//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

//判断是4
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
//判断是5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//判断是6
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

// 判断系统小于7.0
//#define IOS6 ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0)
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IVORY_USER_NAME_DICTIONARY_PATH @"IVORYTOWER_USER_NAME_INFO_PATH"


//属性列表

#define YUserDefaults                   [NSUserDefaults standardUserDefaults]
#define YNotificationCenter             [NSNotificationCenter defaultCenter]
// 单例
#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}
//调试打印日志发布屏蔽日志
#ifdef DEBUG
#define debugLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define debugLog(...)
#define debugMethod()
#endif
#endif
