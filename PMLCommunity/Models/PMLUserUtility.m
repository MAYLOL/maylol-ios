//
//  PMLUserUtility.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/8.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLUserUtility.h"

@implementation PMLUserUtility
+ (void)saveUserModel:(PMLUserModel *)userModel
{
    [NSKeyedArchiver archiveRootObject:userModel toFile:kUserFilePath];
}
+ (PMLUserModel *)userModel
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:kUserFilePath];
}

+ (void)removeUserModel
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:kUserFilePath]) {
        [fileManager removeItemAtPath:kUserFilePath error:nil];
    }
}
@end


@implementation PMLUserModel
MJCodingImplementation;
@end
