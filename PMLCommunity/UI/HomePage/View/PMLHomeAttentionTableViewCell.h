//
//  PMLHomeAttentionTableViewCell.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/16.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseTableViewCell.h"
#import "PMLCommentDetailView.h"

@class PMLHomeAttentionTableViewCell;

@interface PMLHomeAttentionCommentCell : PMLBaseTableViewCell

@property (nonatomic, weak)id<PMLCommentDelegate> commentDelgate;
@property (nonatomic, strong) PMLCommentModel *commentModel;


@end

@interface PMLHomeAttentionCommentView : PMLBaseTableView

@property (nonatomic, strong)NSArray<PMLCommentModel *> *commentList;
@property (nonatomic, weak)id<PMLCommentDelegate> commentDelegate;

@end

@interface PMLHomeAttentionTableViewCell : PMLBaseTableViewCell
@property (nonatomic, strong) UIView *centerView;//存放中间内容的容器
@property (nonatomic, strong) UIImageView *contentImageView;//单张大图片
@property (nonatomic, assign) BOOL isVideo;
@property (nonatomic, strong)PMLHomeAttentionCommentView *commentView;
@property (nonatomic, assign) CGFloat commentHeight;

@property (nonatomic, copy) void(^clickAction)(void);


@end




