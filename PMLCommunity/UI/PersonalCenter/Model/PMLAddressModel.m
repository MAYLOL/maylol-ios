//
//  PMLAddressModel.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/26.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLAddressModel.h"

@implementation PMLCityModel
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:@"name"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}
@end

@implementation PMLProvinceModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"cities" : @"sub_administrative_area"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"cities" : [PMLCityModel class]};
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.cities forKey:@"cities"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.cities = [aDecoder decodeObjectForKey:@"cities"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

@end

@implementation PMLCountryModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"provinces" : [PMLProvinceModel class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"provinces" : @"administrative_area",
             @"countryName" : @"name"
             };
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.provinces forKey:@"provinces"];
    [aCoder encodeObject:self.countryName forKey:@"countryName"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.provinces = [aDecoder decodeObjectForKey:@"provinces"];
        self.countryName = [aDecoder decodeObjectForKey:@"countryName"];
    }
    return self;
}
@end

@implementation PMLAddressModel

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"data" : [PMLCountryModel class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"data" : @"country"
             };
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.data forKey:@"data"];
    [aCoder encodeObject:self.note forKey:@"note"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.data = [aDecoder decodeObjectForKey:@"data"];
        self.note = [aDecoder decodeObjectForKey:@"note"];
    }
    return self;
}
@end
