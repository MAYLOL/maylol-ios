//
//  PMLCommentModel.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMLCommentBaseModel.h"
#import "PMLCommentDetailModel.h"
#import "PMLCommentUserModel.h"
#import "PMLCommentExtModel.h"

/**
 * 评论主体总高度模型
 **/
@interface PMLCommentFrameModel: NSObject
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat heightDetail;
@property (nonatomic, assign) CGFloat heightExtension;

@property (nonatomic, assign) CGFloat height2;
@property (nonatomic, assign) CGFloat heightDetail2;
@property (nonatomic, assign) CGFloat heightExtension2;
@end
/**
 * 评论主体模型
 **/
@interface PMLCommentModel: PMLCommentBaseModel

@property (nonatomic, strong) NSString *currentuserID;//当前用户ID

@property (nonatomic, strong) NSString *authorUserId;//作者ID

@property (nonatomic, strong) NSString *commentId;//评论ID

@property (nonatomic, strong) NSString *contentId;//文章ID

@property (nonatomic, strong) PMLCommentUserModel *user;//用户相关

@property (nonatomic, assign) long long createTime;//评论时间

@property (nonatomic, strong) NSString *isChecked;//是否审核

@property (nonatomic, strong) NSString *isRead;//是否阅读

@property (nonatomic, assign) BOOL isRecommend;//是否有回复

@property (nonatomic, strong) NSDate *date;//时间

@property (nonatomic, strong) NSString *praiseCount;//时间

@property (nonatomic, strong) PMLCommentDetailModel *detailModel;//评论详细内容

@property (nonatomic, strong) PMLCommentExtModel *extModel; //评论回复列表模型

@property (nonatomic, strong) PMLCommentFrameModel *commentFrame;//评论详细高度模型

- (instancetype)initWithmodel:(PMLCommentModel *)model;
+ (instancetype)initWithmodel:(PMLCommentModel *)model;


/**
 *  ///////////////////////列表测试数据////////////////////////
 **/
+ (NSArray<PMLCommentModel *> *)getPMLContentCommentListModel;
/**
 *  ///////////////////////测试数据////////////////////////
 **/
+ (NSArray<PMLCommentModel *> *)getPMLCommentListModel;
+ (NSArray<PMLCommentModel *> *)insertCommentWithcontentId:(NSString *)contentId commentText:(NSString *)commentText user:(PMLCommentUserModel *)user commentList:(NSArray<PMLCommentModel *> *)commentList;
+ (PMLCommentModel *)insertCommentWithcommentId:(NSString *)commentId replyText:(NSString *)replyText user:(PMLCommentUserModel *)user commentModel:(PMLCommentModel *)commentModel;
+ (PMLCommentUserModel *)getCurrentUser;

@end
