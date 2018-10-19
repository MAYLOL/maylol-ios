//
//  PMLUserUtility.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/8.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMLBaseModel.h"

@class PMLUserModel;
@interface PMLUserUtility : NSObject
+ (void)saveUserModel:(PMLUserModel *)userModel;
+ (PMLUserModel *)userModel;
+ (void)removeUserModel;
@end

@interface PMLUserModel : PMLBaseModel<NSCoding>
@property (nonatomic, copy) NSString *userid;
@property (nonatomic, copy) NSString *name;
@end
