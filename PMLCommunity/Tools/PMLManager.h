//
//  PMLManager.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/26.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMLAddressModel.h"

@interface PMLManager : NSObject
/**
 地理位置模型
 */
@property (nonatomic, strong, readonly) PMLAddressModel *addressModel;

@property (nonatomic, strong) PMLCountryModel *selectCountryModel;
@property (nonatomic, strong) PMLProvinceModel *selectProvinceModel;
@property (nonatomic, strong) PMLCityModel *selectCityModel;

+ (instancetype)shared;

+ (NSString *)GetAddress;

+ (BOOL)isSelectAddress;

/**
 *  新消息通知
 **/
+ (void)setNewsNotifi:(BOOL)S;
+ (BOOL)getNewsNotifi;
/**
 *  评论通知
 **/
+ (void)setCommentNotifi:(BOOL)S;
+ (BOOL)getCommentNotifi;
/**
 *  关注通知
 **/
+ (void)setAttentionNotifi:(BOOL)S;
+ (BOOL)getAttentionNotifi;

@end
