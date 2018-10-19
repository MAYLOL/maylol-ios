//
//  UIColor+PMLColor.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/14.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (PMLColor)
+ (UIColor *)colorWithHex:(NSString *)hexColor;
+ (UIColor *)colorWithHex:(NSString *)hexColor alpha:(CGFloat)alpha;
@end
