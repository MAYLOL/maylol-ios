//
//  PMLCommentDetailModel.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMLCommentBaseModel.h"

/**
 *  评论详情高度模型
 **/
@interface PMLCommentDetailFrameModel : NSObject
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat height2;
@property (nonatomic, assign) CGFloat heightText;
@property (nonatomic, assign) CGFloat heightText2;
@end

/**
 *  评论详情模型
 **/
@interface PMLCommentDetailModel : PMLCommentBaseModel
//评论内容
@property (nonatomic, strong) NSString *text;
//评论内容高度
@property (nonatomic, strong) PMLCommentDetailFrameModel *detailFrame;
- (instancetype)initWithCommentText:(NSString *)commentText;
+ (instancetype)initWithCommentText:(NSString *)commentText;
@end
