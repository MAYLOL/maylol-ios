//
//  PMLHomeWaterFlowModel.h
//  PMLCommunity
//
//  Created by panchuang on 2018/10/17.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLBaseModel.h"

@interface PMLHomeWaterFlowModel : PMLBaseModel

/**
 文章id
 */
@property (nonatomic, copy) NSString *articleId;

/**
 文章标题
 */
@property (nonatomic, copy) NSString *articleTitle;

/**
 文章点赞数量
 */
@property (nonatomic, assign) NSInteger likeNum;

/**
 文章赏金
 */
@property (nonatomic, assign) float moneyReward;

/**
 文章作者获得的总赏金
 */
@property (nonatomic, assign) float totalReward;

/**
 文章封面
 */
@property (nonatomic, copy) NSString *articleCover;

/**
 封面图片的宽高比
 */
@property (nonatomic, assign) float coverWH;

/**
 用户是否给文章点过赞
 */
@property (nonatomic, assign) BOOL whetherLike;

/**
 作者id
 */
@property (nonatomic, copy) NSString *authorId;

/**
 作者头像
 */
@property (nonatomic, copy) NSString *authorIcon;

/**
 作者昵称
 */
@property (nonatomic, copy) NSString *authorName;

/**
 cell高度
 */
@property (nonatomic, assign) float cellHeight;
@end

