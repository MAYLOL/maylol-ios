//
//  UIFont+PMLFont.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/14.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (PMLFont)

/**
 苹方细体

 @param size 字体大小
 @return 字体
 */
+ (UIFont *)customPingFLightFontWithSize:(CGFloat)size;
/**
 苹方常规
 
 @param size 字体大小
 @return 字体
 */
+ (UIFont *)customPingFRegularFontWithSize:(CGFloat)size;
/**
 苹方中等
 
 @param size 字体大小
 @return 字体
 */
+ (UIFont *)customPingFMediumFontWithSize:(CGFloat)size;
/**
 苹方粗体
 
 @param size 字体大小
 @return 字体
 */
+ (UIFont *)customPingFSemiboldFontWithSize:(CGFloat)size;

@end
