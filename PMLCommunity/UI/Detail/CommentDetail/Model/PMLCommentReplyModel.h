//
//  PMLCommentReplyModel.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMLCommentBaseModel.h"
#import "PMLCommentUserModel.h"

/**
 *  评论回复高度计算模型
 **/
@interface PMLCommentReplyFrameModel : NSObject

//评论内容高度
@property (nonatomic, assign) CGFloat height;
//评论列表高度
@property (nonatomic, assign) CGFloat extHeight;

@end

/**
 *  评论回复模型
 **/
@interface PMLCommentReplyModel: PMLCommentBaseModel

@property (nonatomic, strong) PMLCommentUserModel *user;//回复用户

@property (nonatomic, strong) PMLCommentUserModel *toUser;//被回复用户

@property (nonatomic, strong) NSString *content;//回复内容

@property (nonatomic, assign) long long createTime;//评论时间

@property (nonatomic, strong) NSString *praiseCount;//点赞

@property (nonatomic, strong) NSDate *date;//时间

@property (nonatomic, strong) PMLCommentReplyFrameModel *replyFrame;//高度模型

- (instancetype)initWithFromUser:(PMLCommentUserModel *)fromUser
                          toUser:(PMLCommentUserModel *)toUser
                         content:(NSString *)content
                     praiseCount:(NSString *)praiseCount
                      createTime:(long long)createTime;

+ (instancetype)initWithFromUser:(PMLCommentUserModel *)fromUser
                          toUser:(PMLCommentUserModel *)toUser
                         content:(NSString *)content
                     praiseCount:(NSString *)praiseCount
                      createTime:(long long)createTime;
@end







