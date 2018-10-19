//
//  PMLCommentReplyCell.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/18.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLCommentReplyCell.h"
#import "PMLCommentDetailTextView.h"
#import "PMLFreeButton.h"
#import "NSDate+PMLDate.h"

@interface PMLCommentReplyCell()
@property (nonatomic, strong) UIButton *avatarView;//头像
@property (nonatomic, strong) UIButton *usernameView;//名字
@property (nonatomic, strong) PMLBaseLabel *timeLabel;//时间
@property (nonatomic, strong) PMLFreeButton *praiseBtn;//点赞按钮
@property (nonatomic, strong) UIView *detailContainerView;
@property (nonatomic, strong) PMLCommentDetailTextView *detailView;//评论
//@property (nonatomic, strong) UIView *underLine;
@end

@implementation PMLCommentReplyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.avatarView];
    [self addSubview:self.usernameView];
    [self addSubview:self.timeLabel];
    [self addSubview:self.praiseBtn];
    [self addSubview:self.detailContainerView];
    [self.detailContainerView addSubview:self.detailView];
//    [self addSubview:self.underLine];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(15);
        make.left.mas_equalTo(self).mas_offset(25);
        make.size.mas_equalTo(CGSizeMake(27, 27));
    }];
    [self.usernameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatarView.mas_centerY).offset(0);
        make.left.mas_equalTo(self.avatarView.mas_right).mas_offset(11);
        make.right.mas_lessThanOrEqualTo(self).mas_offset(-10);
        make.height.mas_equalTo(15.0f);
    }];
    [self.detailContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.usernameView);
        make.top.mas_equalTo(self.avatarView.mas_bottom).mas_offset(2);
        make.right.mas_equalTo(self).mas_offset(-25);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-25);
        make.left.mas_equalTo(self.usernameView);
    }];
    [self.praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-25);
        make.centerY.mas_equalTo(self.timeLabel.mas_centerY);
    }];
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.detailContainerView);
    }];
//    [self.underLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.mas_bottom).offset(0);
//        make.left.equalTo(self.mas_left).offset(25);
//        make.right.equalTo(self.mas_right).offset(-25);
//        make.height.mas_equalTo(1);
//    }];
}

- (void)setReplyModel:(PMLCommentReplyModel *)replyModel {
    _replyModel = replyModel;

    [self.avatarView setImage:[UIImage imageNamed:replyModel.user.userImg] forState:UIControlStateNormal];
    [self.usernameView setTitle:replyModel.user.username forState:UIControlStateNormal];
    [self.timeLabel setText:[NSDate updateTimeForRow:[NSString stringWithFormat:@"%lld",(long long)replyModel.createTime]]];
    [self.praiseBtn setTitle:replyModel.praiseCount forState:UIControlStateNormal];
    [self.detailContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(replyModel.replyFrame.height);
    }];
    [self.detailView setDetail:replyModel.content];
}

- (void)buttonClicked:(UIButton *)sender {
}
#pragma mark- =====================getter method=====================
//- (UIView *)underLine {
//    if (!_underLine){
//        _underLine = [UIView new];
//        _underLine.backgroundColor = [UIColor colorWithHex:@"#DCDCDC"];
//    }
//    return _underLine;
//}

- (PMLCommentDetailTextView *)detailView
{
    if (!_detailView) {
        _detailView = [[PMLCommentDetailTextView alloc] init];
    }
    return _detailView;
}

- (UIButton *)avatarView
{
    if (!_avatarView) {
        _avatarView = [[UIButton alloc] init];
        [_avatarView setTag:10001];
        [_avatarView addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        _avatarView.layer.cornerRadius = 20.0f;
        _avatarView.layer.masksToBounds = YES;
    }
    return _avatarView;
}

- (UIButton *)usernameView
{
    if (!_usernameView) {
        _usernameView = [[UIButton alloc] init];
        _usernameView.tag = 10002;
        [_usernameView.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [_usernameView setTitleColor:[UIColor colorWithHex:@"#999999"] forState:UIControlStateNormal];
        [_usernameView addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _usernameView;
}

- (UIView *)detailContainerView
{
    if (!_detailContainerView) {
        _detailContainerView = [[UIView alloc] init];
    }
    return _detailContainerView;
}

- (PMLBaseLabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[PMLBaseLabel alloc] init];
        _timeLabel.textColor = [UIColor colorWithHex:@"#808080"];
        _timeLabel.font = [UIFont customPingFMediumFontWithSize:9];
        _timeLabel.text = @"08-03 15:58";
        [_timeLabel sizeToFit];
    }
    return _timeLabel;
}

- (PMLFreeButton *)praiseBtn {
    if (!_praiseBtn) {
        _praiseBtn = [PMLFreeButton buttonWithType:UIButtonTypeCustom];
        UIImage *praiseImage = kImageWithName(@"comment_icon_like");
        UIImage *praiseImageClick = kImageWithName(@"comment_icon_like_click");
        [_praiseBtn setImage:praiseImage forState:UIControlStateNormal];
        [_praiseBtn setImage:praiseImageClick forState:UIControlStateSelected];
        [_praiseBtn setTitle:@"999+" forState:UIControlStateNormal];
        [_praiseBtn setTitleColor:[UIColor colorWithHex:@"#000000"] forState:UIControlStateNormal];
        _praiseBtn.titleLabel.font = [UIFont customPingFMediumFontWithSize:7];
        [_praiseBtn setUpImageViewSize:praiseImage.size margin:2 alignment:PMLFreeBtnAlignmentHorizontalLeft];
        [_praiseBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _praiseBtn;
}
@end
