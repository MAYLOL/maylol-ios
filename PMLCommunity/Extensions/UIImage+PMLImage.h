//
//  UIImage+PMLImage.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/14.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (PMLImage)
+(UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size;
+(UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size corner:(CGFloat)corner;
+(UIImage *)imageFromColor:(UIColor *)color size:(CGSize)size corner:(CGFloat)corner borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
- (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha image:(UIImage *)image;
+ (UIImage *)imageWithBase64Str:(NSString *)base64Str;
@end
