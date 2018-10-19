//
//  PMLCommentUserModel.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLCommentUserModel.h"

@implementation PMLCommentUserModel
- (instancetype)initWithUserModel:(PMLCommentUserModel *)userModel {

    if (self = [super init]){
        _identity = userModel.identity;
        _realname = userModel.realname;
        _registerIp = userModel.registerIp;
        _tel = userModel.tel;
        _email = userModel.email;
        _userId = userModel.userId;
        _userImg = userModel.userImg;
        _username = userModel.username;
    }
    return self;
}

+ (instancetype)initWithUserModel:(PMLCommentUserModel *)userModel{

    PMLCommentUserModel *model = [[PMLCommentUserModel alloc] initWithUserModel:userModel];
    return model;
}
@end
