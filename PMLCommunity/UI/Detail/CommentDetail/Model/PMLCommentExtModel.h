//
//  PMLCommentExtModel.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMLCommentReplyModel.h"

/**
 *  评论回复列表模型
 **/
@interface PMLCommentExtFrameModel : NSObject

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat heightLiked;

@property (nonatomic, assign) CGFloat heightComments;

@end

/**
 *  评论回复列表模型
 **/
@interface PMLCommentExtModel : NSObject
//回复列表
@property (nonatomic, strong) NSMutableArray<PMLCommentReplyModel *> *replyList;
//回复列表高度
@property (nonatomic, strong) PMLCommentExtFrameModel *extensionFrame;

- (instancetype)initWithReplyList:(NSArray<PMLCommentReplyModel *> *)replyList;

+ (instancetype)initWithReplyList:(NSArray<PMLCommentReplyModel *> *)replyList;

@end
