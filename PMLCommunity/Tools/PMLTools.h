//
//  PMLTools.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PMLTools : NSObject
//检查参数是否为空字符串或空指针 YES:为空 NO:不为空
+ (BOOL)CheckParam:(NSString *)paramStr;
//检查参数是不是全是数字
+ (BOOL)CheckParamInputShouldNumber:(NSString *)str;
//获取文字宽高
+ (CGSize)sizeForString:(NSString *)value font:(UIFont *)font maxSize:(CGSize)maxSize;
//计算文字高度，可以处理计算带行间距的
+ (CGSize)sizeWithAttr:(NSAttributedString *)attr maxSize:(CGSize)maxSize;
//判断是否包含中文
+ (BOOL)containChinese:(NSString *)str;
//去除html标签
+ (NSString *)filterHTML:(NSString *)html;
//验证手机号
+ (BOOL)validatePhoneNum:(NSString *)phoneNum;
//验证邮箱
+ (BOOL)validateEmail:(NSString *)strEmail;
//验证手机或邮箱
+ (BOOL)validatePhoneNumOrEmail:(NSString *)string;
//获取当前的试图控制器
+ (UIViewController *)getCurrentViewController;

/**
 *  保存字符串
 *
 *  @param content 内容
 *  @param key     关键字
 */
+ (void) writeProfileString:(NSString *)content forKey:(NSString *)key;
/**
 *  读取字符串
 */
+ (NSString *)readProfileString:(NSString *)key;

/**
 *  保存对象
 *
 *  @param content 内容 NSObject类型
 *  @param key     关键字
 */
+ (void) writeObject:(id)content forKey:(NSString *)key;
/**
 *  读取对象
 */
+ (NSObject *)readObject:(NSString *)key;

/**
 *  删除关键字（包含字符串、bool值、NSObject类型的）
 */
+ (void)removeObjectForkey:(NSString *)key;

/**
 *  写入BOOL值
 */
+ (void)writeBoolValue:(BOOL)content forKey:(NSString *)key;
/**
 *  读取Bool值
 */
+ (BOOL)readBoolValue:(NSString *)key;

/**
 根据圆心坐标、半径和角度计算圆弧上的点坐标
 
 @param center 圆心
 @param angle 角度值，是0～360之间的值
 @param radius 圆周半径
 @return 坐标点
 */
+ (CGPoint)calcCircleCoordinateWithCenter:(CGPoint)center andWithAngle:(CGFloat)angle andWithRadius:(CGFloat)radius;

/**
 计算时间间隔
 
 @param str 时间字符 （格式为yyyy-MM-dd HH:mm:ss.SSS或时间戳）
 @return 时间间隔
 */
+ (NSString *)compareCurrentTime:(NSString *)str;

/**
 切圆角

 @param frame view的frame
 @param corners 圆角类型
 @param cornerRadii 圆角大小
 @return 圆角layer
 */
+ (CAShapeLayer *)viewCornerWithFrame:(CGRect)frame byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

/**
 判断图片类型
 
 @param data 图片数据
 @return 图片类型
 */
+ (NSString *)contentTypeForImageData:(NSData *)data;

/**
 *  范围随机数
 **/
+ (int)getRandomNumber:(int)from to:(int)to;

/**
 旋转图片
 
 @param imageView 需要旋转的imageview
 @param radian 旋转弧度
 @param complete 旋转完成后的回调
 */
+ (void)rotationImageWithImageView:(UIImageView *)imageView radian:(CGFloat)radian complete:(void (^)(UIImage * image))complete;

/**
 获取APP版本号

 @return APP版本号
 */
+ (NSString *)getAppVersion;

/**
 获取UUID
 
 @return UUID
 */
+ (NSString *)getUUID;

/**
 对字符串进行RSA加密
 
 @param string 原始字符串
 @return 加密后字符串
 */
+ (NSString *)RSAEncryption:(NSString *)string;

/**
 获取六位随机数
 
 @return 原始随机数和加密后的随机数
 */
+ (NSArray *)verifiCode;

/**
 *  获取本地文件字符串
 **/
+ (NSString *)getTxtWithfileName:(NSString *)filename type:(NSString *)type;

/**
 根据生日计算年龄
 
 @param birthday 生日
 @return 年龄
 */
+ (NSString *)getAgeWith:(NSDate*)birthday;

/**
 根据生日计算星座
 
 @param m 月
 @param d 日
 @return 星座
 */
+ (NSString *)getAstroWithMonth:(NSInteger)m day:(NSInteger)d;

/**
 *  计算缓存
 **/
+ (float)folderSizeAtPath:(NSString *)path;

/**
 *  清除缓存
 **/
+ (void)clearCache:(NSString *)path;

@end
