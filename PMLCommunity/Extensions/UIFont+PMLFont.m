//
//  UIFont+PMLFont.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/14.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "UIFont+PMLFont.h"
@implementation UIFont (PMLFont)
//苹方细体
+ (UIFont *)customPingFLightFontWithSize:(CGFloat)size
{
    if ([kSystemVersion doubleValue] >= 9.0) {
        return [UIFont fontWithName:@"PingFangTC-Light" size:size];
    }else {
        return [UIFont fontWithName:@".PingFang-SC-Light" size:size];
    }
}
//苹方常规
+ (UIFont *)customPingFRegularFontWithSize:(CGFloat)size
{
    if ([kSystemVersion doubleValue] >= 9.0) {
        return [UIFont fontWithName:@"PingFangTC-Regular" size:size];
    }else {
        return [UIFont fontWithName:@".PingFang-SC-Regular" size:size];
    }
}

//苹方中等
+ (UIFont *)customPingFMediumFontWithSize:(CGFloat)size
{
    if ([kSystemVersion doubleValue] >= 9.0) {
        return [UIFont fontWithName:@"PingFangTC-Medium" size:size];
    }else {
        return [UIFont fontWithName:@".PingFang-SC-Medium" size:size];
    }
}

//苹方粗体
+ (UIFont *)customPingFSemiboldFontWithSize:(CGFloat)size
{
    if ([kSystemVersion doubleValue] >= 9.0) {
        return [UIFont fontWithName:@"PingFangTC-Semibold" size:size];
    }else {
        return [UIFont fontWithName:@".PingFang-SC-Semibold" size:size];
    }
}
@end
