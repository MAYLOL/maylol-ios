//
//  PMLCommentUserModel.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMLCommentBaseModel.h"

/**
 *。评论用户信息模型
 **/
@interface PMLCommentUserModel : PMLCommentBaseModel
@property (nonatomic,strong)NSString *identity;//标志
@property (nonatomic,strong)NSString *realname;//真实姓名
@property (nonatomic,strong)NSString *registerIp;//注册id
@property (nonatomic,strong)NSString *tel;//电话
@property (nonatomic,strong)NSString *email;//邮箱
@property (nonatomic,strong)NSString *userId;//用户ID
@property (nonatomic,strong)NSString *userImg;//头像
@property (nonatomic,strong)NSString *username;//用户昵称
- (instancetype)initWithUserModel:(PMLCommentUserModel *)userModel;
+ (instancetype)initWithUserModel:(PMLCommentUserModel *)userModel;
@end
