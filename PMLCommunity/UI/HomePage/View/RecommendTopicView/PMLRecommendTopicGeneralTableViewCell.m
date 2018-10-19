//
//  PMLRecommendTopicGeneralTableViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLRecommendTopicGeneralTableViewCell.h"
#import "PMLFreeButton.h"

@interface PMLRecommendTopicGeneralTableViewCell ()
@property (strong, nonatomic)  UIImageView *leftImageView;
@property (strong, nonatomic)  UIImageView *iconImageView;
@property (strong, nonatomic)  PMLBaseLabel *nickNameLabel;
@property (strong, nonatomic)  PMLBaseLabel *contentLabel;
@property (strong, nonatomic)  PMLFreeButton *lookCountBtn;
@property (strong, nonatomic)  PMLFreeButton *commentCountBtn;
@property (strong, nonatomic)  PMLFreeButton *likeCountBtn;

@end

@implementation PMLRecommendTopicGeneralTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    _leftImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_leftImageView];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(10);
        make.height.mas_equalTo(85);
        make.width.equalTo(self.leftImageView.mas_height);
    }];
    _leftImageView.backgroundColor = kRandomColor;
    
    _iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftImageView);
        make.left.equalTo(self.leftImageView.mas_right).offset(20);
        make.width.height.mas_equalTo(25);
    }];
    _iconImageView.backgroundColor = kRandomColor;
    
    _nickNameLabel = [[PMLBaseLabel alloc] init];
    _nickNameLabel.textColor = kRGBGrayColor(101);
    _nickNameLabel.font = [UIFont customPingFMediumFontWithSize:12];
    [_nickNameLabel sizeToFit];
    [self.contentView addSubview:_nickNameLabel];
    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.centerY.equalTo(self.iconImageView);
    }];
    
    _contentLabel = [[PMLBaseLabel alloc] init];
    _contentLabel.textColor = kRGBGrayColor(50);
    _contentLabel.font = [UIFont customPingFRegularFontWithSize:12];
    _contentLabel.numberOfLines = 2;
    _contentLabel.text = @"单机读卡打回家撒客户端阿双方结婚时大部分伺服电机副书记代表";
    [_contentLabel sizeToFit];
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView);
        make.right.equalTo(self.contentView).offset(-50);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(10);
    }];
    
    _lookCountBtn = [PMLFreeButton buttonWithType:UIButtonTypeCustom];
    [_lookCountBtn setTitleColor:kRGBGrayColor(120) forState:UIControlStateNormal];
    _lookCountBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:10];
    UIImage *lookImage = kImageWithName(@"home_topic_see");
    [_lookCountBtn setImage:lookImage forState:UIControlStateNormal];
    [_lookCountBtn setTitle:@"你好啊 啊啊" forState:UIControlStateNormal];
    [_lookCountBtn setUpImageViewSize:lookImage.size margin:4 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    [_likeCountBtn sizeToFit];
    [self.contentView addSubview:_lookCountBtn];
    [_lookCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView);
        make.bottom.equalTo(self.leftImageView);
    }];
    
    _commentCountBtn = [PMLFreeButton buttonWithType:UIButtonTypeCustom];
    [_commentCountBtn setTitleColor:kRGBGrayColor(120) forState:UIControlStateNormal];
    _commentCountBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:10];
    UIImage *commentImage = kImageWithName(@"home_topic_icon_comment");
    [_commentCountBtn setImage:commentImage forState:UIControlStateNormal];
    [_commentCountBtn setUpImageViewSize:commentImage.size margin:4 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    [_commentCountBtn sizeToFit];
    [self.contentView addSubview:_commentCountBtn];
    [_commentCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lookCountBtn.mas_right).offset(15);
        make.bottom.equalTo(self.leftImageView);
    }];
    
    _likeCountBtn = [PMLFreeButton buttonWithType:UIButtonTypeCustom];
    [_likeCountBtn setTitleColor:kRGBGrayColor(120) forState:UIControlStateNormal];
    _likeCountBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:10];
    UIImage *likeImage = kImageWithName(@"home_topic_icon_like");
    [_likeCountBtn setImage:likeImage forState:UIControlStateNormal];
    [_likeCountBtn setUpImageViewSize:likeImage.size margin:4 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    [_likeCountBtn sizeToFit];
    [self.contentView addSubview:_likeCountBtn];
    [_likeCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentCountBtn.mas_right).offset(15);
        make.bottom.equalTo(self.leftImageView);
    }];
    
    PMLBaseView *lineView = [[PMLBaseView alloc] init];
    lineView.backgroundColor = kRGBGrayColor(220);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImageView);
        make.right.equalTo(self.contentView).offset(-15);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.leftImageView setCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(4, 4)];
    [self.iconImageView setCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(25.0/2, 25.0/2)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
