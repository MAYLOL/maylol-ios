//
//  PMLCommentDetailView.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLCommentDetailView.h"
#import "PMLCommentDetailCell.h"
#import "PMLCommentModel.h"
#import "PMLCommentDetailHeaderView.h"

static NSString *const CommentDetailCellID = @"CommentDetailCellID";//默认

@interface PMLCommentDetailView()<UITableViewDelegate, UITableViewDataSource, PMLCommentDelegate>

@end

@implementation PMLCommentDetailView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]){
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.dataSource = self;
    [self registerClass:[PMLCommentDetailCell class] forCellReuseIdentifier:CommentDetailCellID];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showsVerticalScrollIndicator = NO;
    self.estimatedSectionFooterHeight = 0.01;
    self.estimatedSectionHeaderHeight = 0.01;
}

- (void)setCommentList:(NSArray<PMLCommentModel *> *)commentList {
    if (_commentList != commentList) {
        _commentList = commentList;
        [self reloadData];
    }

}
//评论详情页面
- (void)gotoCommentListPage {
    if (self.commentDelegate != nil && [self.commentDelegate respondsToSelector:@selector(gotoCommentListPage)]){
        [self.commentDelegate gotoCommentListPage];
    }
}
//评论回复页面
- (void)gotoReplyListPageWithCommentModel:(PMLCommentModel *)commentModel {
    if (self.commentDelegate != nil && [self.commentDelegate respondsToSelector:@selector(gotoReplyListPageWithCommentModel:)]){
        [self.commentDelegate gotoReplyListPageWithCommentModel:commentModel];
    }
}

#pragma mark-UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _commentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMLCommentDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentDetailCellID forIndexPath:indexPath];
    cell.commentDelgate = self;
    cell.commentModel = _commentList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_isHeader){
        return 55;
    }
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (_isHeader){
        PMLCommentDetailHeaderView *header = [PMLCommentDetailHeaderView new];
        header.commentCount = _commentList.count;
        header.delegate = self;
        return header;
    }
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PMLCommentModel *commentModel = _commentList[indexPath.row];
    return commentModel.commentFrame.height ?: 0.01;
}
@end
