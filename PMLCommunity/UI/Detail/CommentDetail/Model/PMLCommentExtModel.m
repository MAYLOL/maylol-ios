//
//  PMLCommentExtModel.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLCommentExtModel.h"

#define     EDGE_MOMENT_EXTENSION       5.0f

@implementation PMLCommentExtFrameModel
@end

@implementation PMLCommentExtModel

- (CGFloat)heightLiked
{
    CGFloat height = 0.0f;
    return height;
}

- (CGFloat)heightComments
{
    CGFloat height = 0.0f;
    for (PMLCommentReplyModel *replyModel in self.replyList) {
        height += replyModel.replyFrame.height;
    }
    return height;
}

#pragma mark - # Getter
- (PMLCommentExtFrameModel *)extensionFrame
{
    if (_extensionFrame == nil) {
        _extensionFrame = [[PMLCommentExtFrameModel alloc] init];
        _extensionFrame.height = 0.0f;
        if (self.replyList.count > 0) {
            _extensionFrame.height += EDGE_MOMENT_EXTENSION;
        }
        _extensionFrame.height += _extensionFrame.heightComments = [self heightComments];
    }
    return _extensionFrame;
}

- (instancetype)initWithReplyList:(NSArray<PMLCommentReplyModel *> *)replyList {

    if (self = [super init]){
        _replyList = [[NSMutableArray alloc] initWithArray:replyList];
    }
    return self;
}

+ (instancetype)initWithReplyList:(NSArray<PMLCommentReplyModel *> *)replyList {
    PMLCommentExtModel *commentExtision = [[PMLCommentExtModel alloc]initWithReplyList:replyList];
    return commentExtision;
}

@end
