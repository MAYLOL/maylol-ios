//
//  PMLManager.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/26.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLManager.h"


@interface PMLManager()
@property (nonatomic, strong, readwrite) PMLAddressModel *addressModel;
@end

@implementation PMLManager
@synthesize selectCountryModel = _selectCountryModel;
@synthesize selectProvinceModel = _selectProvinceModel;
@synthesize selectCityModel = _selectCityModel;

+ (instancetype)shared {
    static dispatch_once_t onceToken;
    static PMLManager *shared = nil;
    dispatch_once(&onceToken, ^{
        if (shared == nil) {
            shared = [[self alloc] init];
        }
    });
    return shared;
}

+ (NSString *)GetAddress {
    NSString *country = [PMLManager shared].selectCountryModel.countryName ?: @"";
    NSString *province = [PMLManager shared].selectProvinceModel.name ?: @"";
    NSString *city = [PMLManager shared].selectCityModel.name ?: @"";
    NSString *address = [NSString stringWithFormat:@"%@ %@ %@",country, province, city];
    return address;
}

+ (BOOL)isSelectAddress {
    if ([PMLTools CheckParam:[PMLManager GetAddress]]) {
        return false;
    }
    return true;
}

- (void)setSelectCityModel:(PMLCityModel *)selectCityModel {
    _selectCityModel = selectCityModel;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:selectCityModel];
    [PMLTools writeObject:data forKey:@"_selectCityModel"];
}

- (void)setSelectProvinceModel:(PMLProvinceModel *)selectProvinceModel {
    _selectProvinceModel = selectProvinceModel;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:selectProvinceModel];
    [PMLTools writeObject:data forKey:@"_selectProvinceModel"];
}

- (void)setSelectCountryModel:(PMLCountryModel *)selectCountryModel {
    _selectCountryModel = selectCountryModel;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:selectCountryModel];
    [PMLTools writeObject:data forKey:@"_selectCountryModel"];
}

- (PMLCityModel *)selectCityModel {
    if (!_selectCityModel){
        NSData *data = (NSData *)[PMLTools readObject:@"_selectCityModel"];
        PMLCityModel *selectCityModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if(!selectCityModel){
            selectCityModel = [PMLCityModel new];
        }
        _selectCityModel = selectCityModel;
    }
    return _selectCityModel;
}

- (PMLProvinceModel *)selectProvinceModel {
    if (!_selectProvinceModel){
        NSData *data = (NSData *)[PMLTools readObject:@"_selectProvinceModel"];
        PMLProvinceModel *selectProvinceModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if(!selectProvinceModel){
            selectProvinceModel = [PMLProvinceModel new];
        }
        _selectProvinceModel = selectProvinceModel;
    }
    return _selectProvinceModel;
}

- (PMLCountryModel *)selectCountryModel {
    if (!_selectCountryModel){
        NSData *data = (NSData *)[PMLTools readObject:@"_selectCountryModel"];
        PMLCountryModel *selectCountryModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if(!selectCountryModel){
            selectCountryModel = [PMLCountryModel new];
        }
        _selectCountryModel = selectCountryModel;
    }
    return _selectCountryModel;
}

- (PMLAddressModel *)addressModel {
    if (!_addressModel) {
        NSString *languageResourceStr = @"MLRegion_zh-Hans";
        if ([kCurrentLanguage isEqualToString:@"zh-Hans-CN"]) {
            languageResourceStr = @"MLRegion_zh-Hans";
        } else {
            languageResourceStr = @"MLRegion_en";
        }
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:languageResourceStr ofType:@"plist"];
        NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        _addressModel = [PMLAddressModel mj_objectWithKeyValues:data];
    }
    return _addressModel;
}

#pragma mark- ===================== method=====================

/**
 *  新消息通知
 **/
+ (void)setNewsNotifi:(BOOL)S {
    [PMLTools writeBoolValue:S forKey:@"PMLNewNotificationKey"];
}

+ (BOOL)getNewsNotifi {
    return [PMLTools readBoolValue:@"PMLNewNotificationKey"];
}
/**
 *  评论通知
 **/
+ (void)setCommentNotifi:(BOOL)S {
    [PMLTools writeBoolValue:S forKey:@"PMLCommentNotificationKey"];
}

+ (BOOL)getCommentNotifi {
    return [PMLTools readBoolValue:@"PMLCommentNotificationKey"];
}
/**
 *  关注通知
 **/
+ (void)setAttentionNotifi:(BOOL)S {
    [PMLTools writeBoolValue:S forKey:@"PMLAttentionNotificationKey"];
}

+ (BOOL)getAttentionNotifi {
    return [PMLTools readBoolValue:@"PMLAttentionNotificationKey"];
}












@end
