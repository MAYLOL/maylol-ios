//
//  PMLShareUtilty.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/29.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMLShareUtilty : NSObject
- (void)shareSetUp;
///分享方法
- (void)shareWithUrl:(NSString *)url title:(NSString *)title desc:(NSString *)desc icon:(UIImage *)icon respVC:(UIViewController *)controller;
//+ (void)shareWithUrl:(NSString *)url title:(NSString *)title desc:(NSString *)desc icon:(UIImage *)icon respVC:(UIViewController *)controller;
+ (instancetype)defaultUtility;
@end
