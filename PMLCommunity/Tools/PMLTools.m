//
//  PMLTools.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLTools.h"
#import "RSA.h"
@implementation PMLTools

//检查参数是否为空
+ (BOOL)CheckParam:(NSString *)paramStr
{
    if ((YES == [@"" isEqualToString:paramStr]) || (YES == ([@"" isEqualToString:paramStr] || (nil == paramStr))) || (NULL == paramStr) || ([@"<null>" isEqualToString:paramStr]) || ([paramStr isKindOfClass:[NSNull class]]) || [[paramStr  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] == 0) {
        return YES;
    }
    
    return NO;
}

//检查参数是不是全是数字
+ (BOOL)CheckParamInputShouldNumber:(NSString *)str{
    if (str.length == 0) {
        return NO;
    }
    NSString * regex = @"[0-9]*";
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

//获取文字高度
+ (CGSize)sizeForString:(NSString *)value font:(UIFont *)font maxSize:(CGSize)maxSize
{
    UILabel *detailTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, maxSize.width, maxSize.height)];
    [detailTextLabel sizeToFit];
    detailTextLabel.font = font;
    detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    detailTextLabel.text = value;
    CGSize deSize = [detailTextLabel sizeThatFits:CGSizeMake(maxSize.width, maxSize.height+1)];
    return deSize;
}

//计算文字高度，可以处理计算带行间距的
+ (CGSize)sizeWithAttr:(NSAttributedString *)attr maxSize:(CGSize)maxSize
{
    CGRect rect = [attr boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin context:nil];
    return rect.size;
}

//判断是否包含中文
+ (BOOL)containChinese:(NSString *)str
{
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

//去除html标签
+ (NSString *)filterHTML:(NSString *)html
{
    if (html) {
        NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n" options:0 error:nil];
        html=[regularExpretion stringByReplacingMatchesInString:html options:NSMatchingReportProgress range:NSMakeRange(0, html.length) withTemplate:@""];
    }
    
    return html;
    //    NSString * regEx = @"<([^>]*)>";
    //    html = [html stringByReplacingOccurrencesOfString:regEx withString:@""];
}

//验证手机号
+ (BOOL)validatePhoneNum:(NSString *)phoneNum
{
    NSString * MOBILE = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:phoneNum];
}

//验证邮箱
+ (BOOL)validateEmail:(NSString *)strEmail
{
//    NSString *regex = @"^[a-zA-Z0-9_-]+@[a-zA-Z0-9_-]+(\\.[a-zA-Z0-9_-]+)+$";
    NSString *regex = @"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTest evaluateWithObject:strEmail];
}

//验证手机或邮箱
+ (BOOL)validatePhoneNumOrEmail:(NSString *)string
{
    if ([PMLTools validateEmail:string] || [PMLTools validatePhoneNum:string]) {
        return YES;
    }else{
        return NO;
    }
}

//获取当前的试图控制器
+ (UIViewController *)getCurrentViewController{
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    UIViewController *currentViewController = window.rootViewController;
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;            if (childViewControllerCount > 0) {
                currentViewController = currentViewController.childViewControllers.lastObject;                return currentViewController;
            } else {
                return currentViewController;
            }
        }
    }
    return currentViewController;
}

+ (void)writeBoolValue:(BOOL)content forKey:(NSString *)key {
    NSUserDefaults *prof = [NSUserDefaults standardUserDefaults];
    [prof setBool:content forKey:key];
    [prof synchronize];
}

+ (BOOL)readBoolValue:(NSString *)key {
    NSUserDefaults *prof = [NSUserDefaults standardUserDefaults];
    return [prof boolForKey:key];
}

+ (void)writeProfileString:(NSString *)content forKey:(NSString *)key {
    NSUserDefaults *prof = [NSUserDefaults standardUserDefaults];
    [prof setObject:content forKey:key];
    [prof synchronize];
}

+ (NSString *)readProfileString:(NSString *)key {
    NSUserDefaults *prof = [NSUserDefaults standardUserDefaults];
    NSObject * obj = [prof objectForKey:key];
    if ([NSNull null] == obj) {
        return @"";
    }
    if (obj == nil) {
        return @"";
    }
    return (NSString *)obj;
}

+ (void)writeObject:(id)content forKey:(NSString *)key {
    NSUserDefaults *prof = [NSUserDefaults standardUserDefaults];
    [prof setObject:content forKey:key];
    [prof synchronize];
    
}

+ (NSObject *)readObject:(NSString *)key {
    NSUserDefaults *prof = [NSUserDefaults standardUserDefaults];
    NSObject * obj = [prof objectForKey:key];
    if ([NSNull null] == obj) {
        return nil;
    }
    if (obj == nil) {
        return nil;
    }
    return obj;
}

/**
 *  删除
 */
+ (void)removeObjectForkey:(NSString *)key {
    NSUserDefaults *prof = [NSUserDefaults standardUserDefaults];
    [prof removeObjectForKey:key];
    [prof synchronize];
}

/**
 根据圆心坐标、半径和角度计算圆弧上的点坐标

 @param center 圆心
 @param angle 角度值，是0～360之间的值
 @param radius 圆周半径
 @return 坐标点
 */
+ (CGPoint)calcCircleCoordinateWithCenter:(CGPoint)center andWithAngle:(CGFloat)angle andWithRadius:(CGFloat)radius
{
    CGFloat x2 = radius*cosf(angle*M_PI/180);
    CGFloat y2 = radius*sinf(angle*M_PI/180);
    return CGPointMake(center.x+x2, center.y-y2);
}

/**
 计算时间间隔

 @param str 时间字符 （格式为yyyy-MM-dd HH:mm:ss.SSS或时间戳）
 @return 时间间隔
 */
+ (NSString *)compareCurrentTime:(NSString *)str
{
    //检查是不是时间戳
    BOOL isTimeStamp = [PMLTools CheckParamInputShouldNumber:str];
    //时间差
    NSTimeInterval timeInterval;
    if (isTimeStamp) {
        // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
        NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
        // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
        NSTimeInterval createTime =[str floatValue]/1000;
        // 得到两个时间差
        timeInterval = currentTime - createTime;
    }else {
        // 把字符串转为NSdate
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *timeDate = [dateFormatter dateFromString:str];
        NSDate *currentDate = [NSDate date];
        // 得到两个时间差
        timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    }
    
    long temp = 0;
    NSString *result;
    if (timeInterval/60 < 1)
    {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分钟前",temp];
    }
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    } else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    return  result;
}

/**
 切圆角
 
 @param frame view的frame
 @param corners 圆角类型
 @param cornerRadii 圆角大小
 @return 圆角layer
 */
+ (CAShapeLayer *)viewCornerWithFrame:(CGRect)frame byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii
{
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:frame byRoundingCorners:corners cornerRadii:cornerRadii];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = frame;
    maskLayer.shadowPath = path.CGPath;
    return maskLayer;
}


/**
 判断图片类型

 @param data 图片数据
 @return 图片类型
 */
+ (NSString *)contentTypeForImageData:(NSData *)data
{
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
    }
    return nil;
}
+ (int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

/**
 旋转图片
 
 @param imageView 需要旋转的imageview
 @param radian 旋转弧度
 @param complete 旋转完成后的回调
 */
+ (void)rotationImageWithImageView:(UIImageView *)imageView radian:(CGFloat)radian complete:(void (^)(UIImage * image))complete {
    __block UIImage *image;
    [UIView animateWithDuration:0.2f animations:^{
        imageView.transform = CGAffineTransformMakeRotation(radian);
    } completion:^(BOOL finished) {
        UIGraphicsBeginImageContextWithOptions(imageView.image.size, NO, 0);
        [imageView drawRect:CGRectMake(0, 0, imageView.image.size.width, imageView.image.size.height)];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        if (complete) {
            complete(image);
        }
    }];
}

/**
 获取APP版本号
 
 @return APP版本号
 */
+ (NSString *)getAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}


/**
 获取UUID

 @return UUID
 */
+ (NSString *)getUUID {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    return result;
}


/**
 对字符串进行RSA加密

 @param string 原始字符串
 @return 加密后字符串
 */
+ (NSString *)RSAEncryption:(NSString *)string {
    return [RSA encryptString:string publicKey:PMLPublicKey];
}

/**
 获取六位随机数

 @return 原始随机数和加密后的随机数
 */
+ (NSArray *)verifiCode {
    NSTimeInterval random = [NSDate timeIntervalSinceReferenceDate];
    NSString *randomString = [NSString stringWithFormat:@"%.6f",random];
//    NSArray  *array = [randomString componentsSeparatedByString:@"."];
    NSString *originalCode = [[randomString componentsSeparatedByString:@"."] objectAtIndex:1];
    //加密逻辑 分别将第一位和第三位 第四位和第六位交换位置 然后判断调换后的第一位和第三位分别和第二位相加的结果 如果结果大于9 则不使用相加后的数 否则使用相加后的数 判断调换后的第四位和第六位分别和第五位相加的结果 如果结果大于9 则不使用相加后的数 否则使用相加后的数
    int first  = [[originalCode substringWithRange:NSMakeRange(0, 1)] intValue];
    int second = [[originalCode substringWithRange:NSMakeRange(1, 1)] intValue];
    int third  = [[originalCode substringWithRange:NSMakeRange(2, 1)] intValue];
    int fourth = [[originalCode substringWithRange:NSMakeRange(3, 1)] intValue];
    int fifth  = [[originalCode substringWithRange:NSMakeRange(4, 1)] intValue];
    int sixth  = [[originalCode substringWithRange:NSMakeRange(5, 1)] intValue];
    NSString *encryptCode = [NSString stringWithFormat:@"%d%d%d%d%d%d",(third + second) > 9 ? second:(third + second), second, (first + second) > 9 ? first:(first + second), (sixth + fifth) > 9 ? sixth:(sixth + fifth),fifth, (fourth + fifth) > 9 ? fourth:(fourth + fifth)];
    
    return @[originalCode,encryptCode];
}

/**
 *  获取本地文件字符串
 **/
+ (NSString *)getTxtWithfileName:(NSString *)filename type:(NSString *)type {
    NSString *txtPath = [[NSBundle mainBundle]pathForResource:filename ofType:type];
    NSData *contentData = [NSData dataWithContentsOfFile:txtPath];
    NSString *contentStr = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
    return contentStr;
}


/**
 根据生日计算年龄

 @param birthday 生日
 @return 年龄
 */
+ (NSString *)getAgeWith:(NSDate*)birthday {
    //日历
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger unitFlags = NSCalendarUnitYear;
    NSDateComponents *components = [gregorian components:unitFlags fromDate:birthday toDate:[NSDate  date] options:0];
    return [NSString stringWithFormat:@"%ld%@",[components year] + 1,kInternationalContent(@"岁")];
}

/**
 根据生日计算星座

 @param m 月
 @param d 日
 @return 星座
 */
+ (NSString *)getAstroWithMonth:(NSInteger)m day:(NSInteger)d {
    NSString *astroString = @"魔羯水瓶双鱼白羊金牛双子巨蟹狮子处女天秤天蝎射手魔羯";
    NSString *astroFormat = @"102123444543";
    NSString *result;
    if (m<1||m>12||d<1||d>31){
        return @"错误日期格式!";
    }
    
    if(m==2 && d>29)
    {
        return @"错误日期格式!!";
    }else if(m==4 || m==6 || m==9 || m==11) {
        if (d>30) {
            return @"错误日期格式!!!";
        }
    }
    result = [NSString stringWithFormat:@"%@",[astroString substringWithRange:NSMakeRange(m*2-(d < [[astroFormat substringWithRange:NSMakeRange((m-1), 1)] intValue] - (-19))*2,2)]];
    return kInternationalContent([result stringByAppendingString:@"座"]);
}

/**
 *  计算缓存
**/
+ (float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

+ (float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize = 0;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[PMLTools fileSizeAtPath:absolutePath];
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}
/**
 *  清除缓存
 **/
+ (void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}
@end
