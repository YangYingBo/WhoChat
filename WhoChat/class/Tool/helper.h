//
//  helper.h
//  myObjct-oc
//
//  Created by 求罩 on 16/4/25.
//  Copyright © 2016年 求罩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>


//extern UIColor *navBackColor;
@interface helper : NSObject
// 获取系统版本中的版本号 eg. 6.0
+ (float) getSystemVersionValue;
// 判断字符串是否包含汉字
// string : 需要判断的字符串
+ (BOOL)IsContainChinese:(NSString*)string;

//判断手机号码或者固话
+(BOOL)isValidateMobile:(NSString *)mobile;
// 接口字段排序
+ (NSString *)interfaceFieldSorting:(NSString *)encryptionUrl;
// 根据色值和尺寸  得到图片
+ (UIImage *) getPureColorImageWithSize:(CGSize) newSize withColor:(UIColor *) newColor;
// 根据字符串计算  控件宽高
+ (CGSize )calculatedAccordingToTheSizeOfTheString:(NSString *)string withHeight:(CGFloat)height withWidth:(CGFloat)width andStringFont:(CGFloat)font;
// 根据十六进制获得十进制色值
+ (UIColor *)getColor:(NSString *)hexColor;

//获取当前系统的时间戳
+(long)getTimeSp;

//将时间戳转换成NSDate
+(NSDate *)changeSpToTime:(NSString*)spString;

//将时间戳转换成NSDate,加上时区偏移
+(NSDate*)zoneChange:(NSString*)spString;

//比较给定NSDate与当前时间的时间差，返回相差的秒数
+(long)timeDifference:(NSDate *)date;

//将NSDate按yyyy-MM-dd HH:mm:ss格式时间输出
+(NSString*)nsdateToString:(NSDate *)date;

//将yyyy-MM-dd HH:mm:ss格式时间转换成时间戳
+(long)changeTimeToTimeSp:(NSString *)timeStr;

//获取当前系统的yyyy-MM-dd HH:mm:ss格式时间
+(NSString *)getTime;
// MD5加密
+ (NSString *) md5String:(NSString *)str;
+ (NSString *) md5Data:(NSData *)data;
// 按照规定大小压缩图片
+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize andImage:(UIImage *)image;
// 把图剪切成圆形
+ (UIImage *)drawImage:(UIImage *)oldImage;

+ (UIAlertView *) ShowMessageBox2:(int)msgboxID titleName:(NSString *)strTitle contentText:(NSString *)strContent cancelBtnName:(NSString *)strBtnName otherBtnName:(NSString *)otherName delegate:(id)delegate;
// 判断是否是  纯数字
+ (BOOL)isPureInt:(NSString*)string;
+ (BOOL)isUXIN_ASSIST:(NSString *)uid;

// 处理电话号码，去除多余的字符,'-' '(' ')' '+86'等，得到纯粹的，干净的号码
// strPhoneNumber : 电话号码
+ (NSString *) DealWithPhoneNumber:(NSString *)strPhoneNumber;
// 判断是否是电话号码
+ (BOOL)isPhoneNumber:(NSString *)number;
// 判断是哪个运营商
+ (NSString *)isWhiceOperatorThePhoneNumber:(NSString *)number;
// 根据传入的时间  计算昨天   前天
+ (NSString *)dataTimeForIMCell:(NSDate *)date;

/**
 *  修改图片颜色
 *
 *  @param color
 *  @param image
 *
 *  @return
 */
+ (UIImage *)imageVithColor:(UIColor *)color image:(UIImage *)image;
/**
 修改按键音
 */

+ (void)changeButtonTone;
/** 设置圆形图片(放到分类中使用) */
+ (UIImage *)cutCircleImage:(UIImage *)img;

+ (UILabel *)getLabelWithFrame:(CGRect)frame andLabelText:(NSString *)text backgroundColor:(UIColor *)backColor textColor:(UIColor *)textColor textFont:(CGFloat)font textAlignment:(NSTextAlignment)textAlignment;
/**
 *  拉伸图片
 *
 *  @param imageName 图片名字
 *
 *  @return 图片
 */
+ (UIImage *)resizableImage:(NSString *)imageName;
@end
