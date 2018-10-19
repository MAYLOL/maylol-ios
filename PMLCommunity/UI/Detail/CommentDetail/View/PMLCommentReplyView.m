//
//  PMLCommentReplyView.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/18.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLCommentReplyView.h"
#import "PMLCommentReplyCell.h"
#import "PMLCommentModel.h"
#import "PMLCommentInputView.h"
#import "PMLCommentDetailCell.h"
#import <MJRefresh/MJRefresh.h>

static NSString *const PMLCommentReplyCellID = @"PMLCommentReplyCellID";//默认

@interface PMLCommentReplyView()<UITableViewDelegate, UITableViewDataSource, PMLCommentInputKViewDelegate>
@property (nonatomic, strong)UIView *maskView;
@property (nonatomic, strong)UIView *contentView;
@property (nonatomic, strong)UITableView *repleView;
@property (nonatomic, strong)UIButton *closeBtn;
@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)PMLCommentDetailCell *commentHeaderView;
@end

@implementation PMLCommentReplyView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.maskView];
    [self addSubview:self.contentView];
    [self addSubview:self.closeBtn];
    [self addSubview:self.titleLabel];
    [self addSubview:self.commentHeaderView];
    [self addSubview:self.repleView];
    [self addSubview:self.inputKView];//输入框
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(16);
        make.centerX.equalTo(self.contentView.mas_centerX).offset(0);
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.contentView.mas_top).offset(6);
        make.centerY.equalTo(self.titleLabel.mas_centerY).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(65);
    }];
    [self.inputKView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(- iPhone_X_Bottom_Safe);
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.height.mas_equalTo(50);
    }];
    [self.commentHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(13);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(100);
    }];
    [self.repleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commentHeaderView.mas_bottom).offset(0);
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.bottom.equalTo(self.inputKView.mas_top).offset(0);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}


- (void)loadNewData {
    NSLog(@"下拉刷新");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.repleView.mj_header endRefreshing];
    });
}

- (void)loadMoreData {
    NSLog(@"上拉加载");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.repleView.mj_footer endRefreshingWithNoMoreData];
    });
}

- (void)setCommentModel:(PMLCommentModel *)commentModel {
    _commentModel = commentModel;
     NSString *replyC = [NSString stringWithFormat:@"%ld%@%@",commentModel.extModel.replyList.count, kInternationalContent(@"条"), kInternationalContent(@"回复")];
    self.titleLabel.text = replyC;
    self.commentHeaderView.commentModel = commentModel;
    [self.commentHeaderView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(commentModel.commentFrame.height);
    }];
    [self.commentHeaderView layoutIfNeeded];
    [self.repleView reloadData];
}

- (void)maskViewTouch {
    [self hide];
}

- (void)show {
     CGFloat Vheight = kScreenHeight * 607/667;
    [UIView animateWithDuration:0.3f animations:^{
        self.contentView.y = Vheight;
        self.maskView.alpha = 0.4;
    }];
}

- (void)hide {
    [self.inputKView resignFirstResponster];
    CGFloat Vheight = kScreenHeight;
    [UIView animateWithDuration:0.3f animations:^{
        self.contentView.y = Vheight;
        self.maskView.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.touchBlock) {
            self.touchBlock();
        }
    }];
}

- (void)buttonClicked:(UIButton *)sender{
    [self hide];
}

#pragma mark- ============PMLCommentInputKViewDelegate method============
//评论完成回调文字
- (void)commentInputKViewSentText:(NSString *)sentText {
    if([PMLTools CheckParam:sentText]){
        return;
    }
   PMLCommentModel *commM = [PMLCommentModel insertCommentWithcommentId:@"10021" replyText:sentText user:[PMLCommentModel getCurrentUser] commentModel:self.commentModel];
    self.commentModel = commM;
    [self.repleView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:true];
}

#pragma mark-UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _commentModel.extModel.replyList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMLCommentReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLCommentReplyCellID forIndexPath:indexPath];
    cell.replyModel = _commentModel.extModel.replyList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
       PMLCommentReplyModel *replyModel = _commentModel.extModel.replyList[indexPath.row];
    return replyModel.replyFrame.extHeight ?: 0.01;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.inputKView resignFirstResponster];
}
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[PMLMaskView alloc] initMaskViewWithFrame:self.bounds target:self select:@selector(maskViewTouch)];
        _maskView.alpha = 0.4;
    }
    return _maskView;
}

- (UIView *)contentView {
    if (!_contentView){

        CGFloat Vheight = kScreenHeight * 607/667;
        CGFloat Vy = kScreenHeight - Vheight;
       UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, Vy , kScreenWidth, Vheight)];
        contentView.backgroundColor = [UIColor whiteColor];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:15];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = self.bounds;
        maskLayer.path = path.CGPath;
        contentView.layer.mask = maskLayer;
        _contentView = contentView;
    }
    return _contentView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[PMLBaseLabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithHex:@"#1A1A1A"];
        _titleLabel.font = [UIFont customPingFMediumFontWithSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

- (UITableView *)repleView {
    if (!_repleView){
        UITableView *repleView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        repleView.delegate = self;
        repleView.dataSource = self;
        [repleView registerClass:[PMLCommentReplyCell class] forCellReuseIdentifier:PMLCommentReplyCellID];
        repleView.separatorStyle = UITableViewCellSeparatorStyleNone;
        repleView.showsVerticalScrollIndicator = NO;
        repleView.estimatedSectionFooterHeight = 0.01;
        repleView.estimatedSectionHeaderHeight = 0.01;
        repleView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        MJRefreshAutoStateFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];

        [footer setTitle:@"~到底了~" forState:MJRefreshStateNoMoreData];
        repleView.mj_footer = footer;
        _repleView = repleView;
    }
    return _repleView;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.tag = 10005;
        [_closeBtn setImage:kImageWithName(@"search_icon_eooro") forState:UIControlStateNormal];
        [_closeBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 25)];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_closeBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    }
    return _closeBtn;
}

- (PMLCommentDetailCell *)commentHeaderView {
    if (!_commentHeaderView) {
        _commentHeaderView = [[PMLCommentDetailCell alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    }
    return _commentHeaderView;
}

- (PMLCommentInputView *)inputKView {
    if (!_inputKView){
        _inputKView = [[PMLCommentInputView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - kNavBarHeight - iPhone_X_Bottom_Safe - 50,  [UIScreen mainScreen].bounds.size.width, 50)];
        _inputKView.inputKDelegate = self;
    }
    return _inputKView;
}
@end
