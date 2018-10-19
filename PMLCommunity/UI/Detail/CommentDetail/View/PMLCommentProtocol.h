//
//  PMLCommentProtocol.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/18.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//
@class PMLCommentModel;

@protocol PMLCommentDelegate <NSObject>
//评论详情页面
- (void)gotoCommentListPage;
//评论回复页面
- (void)gotoReplyListPageWithCommentModel:(PMLCommentModel *)commentModel;
@end

@protocol PMLCommentInputKViewDelegate <NSObject>
- (void)commentInputKViewSentText:(NSString *)sentText;
@end
