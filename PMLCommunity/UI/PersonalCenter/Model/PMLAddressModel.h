//
//  PMLAddressModel.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/26.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface PMLCityModel : NSObject <NSCoding>

@property (nonatomic, assign) NSInteger city_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger pro_id;
@property (nonatomic, assign) NSInteger status;

@end

@interface PMLProvinceModel : NSObject <NSCoding>

@property (nonatomic, strong) NSArray<PMLCityModel *> *cities;
@property (nonatomic, assign) NSInteger pro_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger type;

@end

@interface PMLCountryModel : NSObject <NSCoding>

@property (nonatomic, strong) NSArray<PMLProvinceModel *> *provinces;
@property (nonatomic, strong) NSString *countryName;

@end

@interface PMLAddressModel : NSObject <NSCoding>

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSArray<PMLCountryModel *> *data;
@property (nonatomic, copy) NSString *note;

@end
