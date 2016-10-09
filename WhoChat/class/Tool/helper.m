//
//  helper.m
//  myObjct-oc
//
//  Created by 求罩 on 16/4/25.
//  Copyright © 2016年 求罩. All rights reserved.
//

#import "helper.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation helper

//获取系统版本中的版本号 eg. 6.0
+ (float) getSystemVersionValue
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}
// 判断字符串是否包含汉字
// string : 需要判断的字符串
+ (BOOL) IsContainChinese:(NSString*)string
{
    for(int i = 0; i < [string length]; ++i)
    {
        unichar a = [string characterAtIndex:i];
        if(a >= 0x4e00 && a <= 0x9fff)
        {
            return YES;
        }
    }
    
    return NO;
}
// 判断是固话还是手机号码
+(BOOL)isValidateMobile:(NSString *)mobile
{
    //此为手机或者固话
    NSString *phoneRegex1 = @"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
    return [phoneTest evaluateWithObject:mobile];
}
// 根据颜色和尺寸 画图
+ (UIImage *) getPureColorImageWithSize:(CGSize) newSize withColor:(UIColor *) newColor
{
    UIGraphicsBeginImageContextWithOptions(newSize, 0, [UIScreen mainScreen].scale);
    // 纯色
    [newColor set];
    UIRectFill(CGRectMake(0, 0, newSize.width, newSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return pressedColorImg;
}

// 根据链接里面的字段排序
+ (NSString *)interfaceFieldSorting:(NSString *)encryptionUrl
{
    NSArray *chaiFenArr = [encryptionUrl componentsSeparatedByString:@"?"];
    
    NSString *chaiFenStr1 = chaiFenArr[1];
    
    NSArray *chaiFenArr1 = [chaiFenStr1 componentsSeparatedByString:@"&"];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    for (NSString *str in chaiFenArr1) {
        
        //        NSLog(@"%@",str);
        NSArray *chaiFenArr2 = [str componentsSeparatedByString:@"="];
        
        [dic setValue:chaiFenArr2[1] forKey:chaiFenArr2[0]];
    }
    
    //    NSLog(@"%@",dic);
    
    NSArray *allKeys = [dic allKeys];
    
    NSArray *sortedArray = [allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    NSMutableArray *paiXuStrArr = [NSMutableArray array];
    
    for (NSString *categoryId in sortedArray) {
        //        NSLog(@"dic key %@   [dict objectForKey:categoryId] === %@",categoryId,[dic objectForKey:categoryId]);
        
        NSString *paiXuStr = [NSString stringWithFormat:@"%@=%@",categoryId,[dic objectForKey:categoryId]];
        // 根据排序的  key找到对应的object   然后用=组装起来
        [paiXuStrArr addObject:paiXuStr];
        
    }
    // 用&串联起来
    NSString *pauxuStr = [paiXuStrArr componentsJoinedByString:@"&"];
    
    //    NSLog(@"排序后的%@",pauxuStr);
    // 用？号串联成接口
    NSString *paiXuUrl = [NSString stringWithFormat:@"%@?%@",chaiFenArr[0],pauxuStr];
    //    NSLog(@"排序后的url    =====    %@",paiXuUrl);
    return paiXuUrl;
}

// 根据控件的宽度或者高度  来计算控件的size
+ (CGSize )calculatedAccordingToTheSizeOfTheString:(NSString *)string withHeight:(CGFloat)height withWidth:(CGFloat)width andStringFont:(CGFloat)font
{
    return [string boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
}
// 根据十六进制转换成十进制
+ (UIColor *)getColor:(NSString *)hexColor
{
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}


//获取当前系统的时间戳
+(long)getTimeSp{
    long time;
    NSDate *fromdate=[NSDate date];
    time=(long)[fromdate timeIntervalSince1970];
    return time;
}

//将时间戳转换成NSDate
+(NSDate *)changeSpToTime:(NSString*)spString{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
    return confromTimesp;
}
//将时间戳转换成NSDate,加上时区偏移
+(NSDate*)zoneChange:(NSString*)spString{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
    NSDate *localeDate = [confromTimesp  dateByAddingTimeInterval: interval];
    return localeDate;
}
//比较给定NSDate与当前时间的时间差，返回相差的秒数
+(long)timeDifference:(NSDate *)date{
    NSDate *localeDate = [NSDate date];
    long difference =fabs([localeDate timeIntervalSinceDate:date]);
    return difference;
}
//将NSDate按yyyy-MM-dd HH:mm:ss格式时间输出
+(NSString*)nsdateToString:(NSDate *)date{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* string=[dateFormat stringFromDate:date];
    return string;
}
//将yyyy-MM-dd HH:mm:ss格式时间转换成时间戳
+(long)changeTimeToTimeSp:(NSString *)timeStr{
    long time;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate=[format dateFromString:timeStr];
    time= (long)[fromdate timeIntervalSince1970];
    
    return time;
}
//获取当前系统的yyyy-MM-dd HH:mm:ss格式时间
+(NSString *)getTime{
    NSDate *fromdate=[NSDate date];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString* string=[dateFormat stringFromDate:fromdate];
    return string;
}

+ (NSString *) md5String:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [[NSString stringWithFormat:
             @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}
+ (NSString *) md5Data:(NSData *)data
{
    unsigned char result[16];
    CC_MD5(data.bytes, data.length, result ); // This is the md5 call
    return [[NSString stringWithFormat:
             @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

// 按照规定大小  压缩图片
+ (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize andImage:(UIImage *)image
{
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}
// 把图裁剪成圆形
+ (UIImage *)drawImage:(UIImage *)oldImage {
    //2.开启上下文
    UIGraphicsBeginImageContextWithOptions(oldImage.size, NO, 0.0);
    
    //3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //4.画圆
    CGRect circleRect = CGRectMake(0, 0, oldImage.size.width, oldImage.size.height);
    CGContextAddEllipseInRect(ctx, circleRect);
    
    //5.裁剪(按照当前的路径形状裁剪)
    CGContextClip(ctx);
    
    //6.画图
    [oldImage drawInRect:circleRect];
    
    //7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //8.结束
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIAlertView *) ShowMessageBox2:(int)msgboxID titleName:(NSString *)strTitle contentText:(NSString *)strContent cancelBtnName:(NSString *)strBtnName otherBtnName:(NSString *)otherName delegate:(id)delegate
{
    UIAlertView *msgbox = [[UIAlertView alloc] initWithTitle:strTitle
                                                     message:strContent
                                                    delegate:delegate
                                           cancelButtonTitle:strBtnName
                                           otherButtonTitles:otherName, nil];
    msgbox.tag = msgboxID;
    [msgbox show];
    return msgbox;
}

// 判断是否是  纯数字
+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+ (BOOL)isUXIN_ASSIST:(NSString *)uid
{
    long long iNumber = [uid longLongValue];
    if ((iNumber & 0x000000000FFFFFFFFLL) == 8000) {
        return YES;
    }
    return NO;
}

// 处理电话号码，去除多余的字符,'-' '(' ')' '+86'等，得到纯粹的，干净的号码
// strPhoneNumber : 电话号码
+ (NSString *) DealWithPhoneNumber:(NSString *)strPhoneNumber
{
    if (strPhoneNumber == nil) {
        return @"";
    }
    
    NSString *strReault = [strPhoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    // 去掉'-'
    strReault = [strReault stringByReplacingOccurrencesOfString:@"-" withString:@""];
    // 去掉'('和')'
    strReault = [strReault stringByReplacingOccurrencesOfString:@"(" withString:@""];
    strReault = [strReault stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    // 判断账号是中国的，则要去掉+86，0086，17951等前缀
    //if ([UserDefaultManager isAccountCHN])
    //{
    // 去掉'+86'
    strReault = [strReault stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    
    BOOL bPreFix = NO;
    
    // 去掉号码前面加的"0086"
    bPreFix = [strReault hasPrefix:@"0086"];
    if (bPreFix)
    {
        strReault = [strReault stringByReplacingCharactersInRange:NSMakeRange(0, 4) withString:@""];
    }
    
    // 去掉号码前面加的“12593”
    bPreFix = [strReault hasPrefix:@"12593"];
    if (bPreFix)
    {
        strReault = [strReault stringByReplacingCharactersInRange:NSMakeRange(0, 5) withString:@""];
    }
    
    // 去掉号码前面加的“17951”
    bPreFix = [strReault hasPrefix:@"17951"];
    if (bPreFix)
    {
        strReault = [strReault stringByReplacingCharactersInRange:NSMakeRange(0, 5) withString:@""];
    }
    
    // 去掉号码前面加的“17911”
    bPreFix = [strReault hasPrefix:@"17911"];
    if (bPreFix)
    {
        strReault = [strReault stringByReplacingCharactersInRange:NSMakeRange(0, 5) withString:@""];
    }
    bPreFix = [strReault hasPrefix:@"17909"];
    if (bPreFix)
    {
        strReault = [strReault stringByReplacingCharactersInRange:NSMakeRange(0, 5) withString:@""];
    }
    //}
    
    if ([strReault length] < 1)
    {
        return @"";
    }
    else
    {
        NSString *strNewResult = [[NSString alloc] init] ;
        for( int i=0; i<[strReault length]; ++i )
        {
            NSString* strTest = [[strReault substringFromIndex:i] substringToIndex:1];
            if( strTest &&
               (NSOrderedSame == [strTest compare:@"0"] ||
                NSOrderedSame == [strTest compare:@"1"] ||
                NSOrderedSame == [strTest compare:@"2"] ||
                NSOrderedSame == [strTest compare:@"3"] ||
                NSOrderedSame == [strTest compare:@"4"] ||
                NSOrderedSame == [strTest compare:@"5"] ||
                NSOrderedSame == [strTest compare:@"6"] ||
                NSOrderedSame == [strTest compare:@"7"] ||
                NSOrderedSame == [strTest compare:@"8"] ||
                NSOrderedSame == [strTest compare:@"9"] ) )
            {
                strNewResult = [strNewResult stringByAppendingFormat:@"%@",strTest];
            }
            else
            {
                //const unsigned char* pTest = (const unsigned char*)[strTest UTF8String];
                NSLog(@"DealWithPhoneNumber WHAT? %@", strTest);
            }
        }
        
        return strNewResult;
    }
}

// 判断是哪个运营商
+ (NSString *)isWhiceOperatorThePhoneNumber:(NSString *)number
{
    
    /**
     10 * 中国移动：China Mobile
     11 * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12 */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15 * 中国联通：China Unicom
     16 * 130,131,132,152,155,156,185,186
     17 */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20 * 中国电信：China Telecom
     21 * 133,1349,153,180,189
     22 */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25 * 大陆地区固话及小灵通
     26 * 区号：010,020,021,022,023,024,025,027,028,029
     27 * 号码：七位或八位
     28 */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
   
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if ([regextestcm evaluateWithObject:number]) {
        return @"中国移动";
    }
    else if ([regextestcu evaluateWithObject:number])
    {
        return @"中国联通";
    }
    else if ([regextestct evaluateWithObject:number])
    {
        return @"中国电信";
    }
    else if ([self isValidateMobile:number])
    {
        return @"";
    }
    else
    {
        return @"未知";
    }
}

// 判断是否是电话号码
+ (BOOL)isPhoneNumber:(NSString *)number
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
     NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:number];
}

// 根据传入的时间  计算昨天   前天
+ (NSString *)dataTimeForIMCell:(NSDate *)date
{
    NSString *timeString = @"";
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSTimeInterval late =[date timeIntervalSince1970]*1;
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    
    [formatter setDateFormat:@"H"];
    int today =   [[formatter stringFromDate:dat] intValue] *3600;
    
    [formatter setDateFormat:@"m"];
    today +=  [[formatter stringFromDate:dat] intValue]*60;
    
    NSTimeInterval cha= now - late  ;
    [formatter setDateFormat:@"HH:mm"];
    timeString=[formatter stringFromDate:date];
    
    if (cha < today)
    {
        timeString=[formatter stringFromDate:date];
    }
    else if (cha >today &&cha< today +24*3600)
    {
        timeString= [NSString stringWithFormat:@"昨天 %@",timeString];
    }
    else if (cha >today &&cha< today +24*3600*2)
    {
        timeString= [NSString stringWithFormat:@"前天 %@",timeString];
    }
    else
    {
        [formatter setDateFormat:@"yyyy"];
        BOOL isSameYear = [[formatter stringFromDate:date] isEqualToString:[formatter stringFromDate:[NSDate date]]];
        if (isSameYear)
        {
            [formatter setDateFormat:@"MM-dd HH:mm"];
            timeString=[formatter stringFromDate:date];
        }
        else
        {
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            timeString=[formatter stringFromDate:date];
        }
    }
    
    return timeString;
}

// 改变子字符串的颜色
+ (NSMutableAttributedString *)foundationSubString:(NSString *)subStr  fondSuperStringRang:(NSString *)superStr withAttributedStringFont:(CGFloat)font withAttributedStringColor:(UIColor *)color
{
    NSRange subRang = [superStr rangeOfString:subStr];
    NSMutableAttributedString *superAttributeStr = [[NSMutableAttributedString alloc] initWithString:superStr];
    
    if (subRang.location != NSNotFound) {
        [superAttributeStr addAttribute:NSForegroundColorAttributeName value:color range:subRang];
        [superAttributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:subRang];
    }
    
    return superAttributeStr;
}

/**
 *  修改图片颜色
 *
 *  @param color
 *  @param image
 *
 *  @return
 */
+ (UIImage *)imageVithColor:(UIColor *)color image:(UIImage *)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextClipToMask(context, rect, image.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
    修改按键音
 */
+ (void)changeButtonTone
{
    // systemSound范围在 1000——2000
//    NSInteger systemSoundType = [YUserDefaults integerForKey:SystemeSound];
//    AudioServicesPlaySystemSound(systemSoundType);
}

/** 设置圆形图片(放到分类中使用) */
+ (UIImage *)cutCircleImage:(UIImage *)img {
    UIGraphicsBeginImageContextWithOptions(img.size, NO, 0.0);
    // 获取上下文
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    // 设置圆形
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextAddEllipseInRect(ctr, rect);
    // 裁剪
    CGContextClip(ctr);
    // 将图片画上去
    [img drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UILabel *)getLabelWithFrame:(CGRect)frame andLabelText:(NSString *)text backgroundColor:(UIColor *)backColor textColor:(UIColor *)textColor textFont:(CGFloat)font textAlignment:(NSTextAlignment)textAlignment
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text  = text;
    label.backgroundColor = backColor;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = textColor;
    label.textAlignment = textAlignment;
    return label;
}

/**
 *  处理图片拉伸问题
 *
 *  @param imageName 图片名字
 *
 *  @return 图片
 */
+ (UIImage *)resizableImage:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat imageWidth = image.size.width *0.5;
    CGFloat imageHeight = image.size.height *0.5;
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageHeight, imageWidth, imageHeight, imageWidth) resizingMode:UIImageResizingModeTile];
}

@end
