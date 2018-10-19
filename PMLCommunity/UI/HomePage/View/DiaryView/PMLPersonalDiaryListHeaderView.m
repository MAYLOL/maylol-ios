//
//  PMLBeautyDiaryDetailHeaderView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLPersonalDiaryListHeaderView.h"

@interface PMLPersonalDiaryListHeaderView ()
@property (strong, nonatomic)  UIImageView *iconImageView;
@property (strong, nonatomic)  PMLBaseLabel *nickNameLabel;
@property (strong, nonatomic)  PMLBaseLabel *timeLabel;
@property (strong, nonatomic)  PMLBaseLabel *diaryCountLabel;
@property (strong, nonatomic)  UIButton *focusBtn;
@property (strong, nonatomic)  PMLBaseLabel *diaryTypeLabel;

@end

@implementation PMLPersonalDiaryListHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    _iconImageView = [[UIImageView alloc] init];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(25);
        make.top.equalTo(self).offset(15);
        make.width.height.mas_equalTo(88);
    }];
    
    _nickNameLabel = [[PMLBaseLabel alloc] init];
    _nickNameLabel.textColor = kRGBGrayColor(26);
    _nickNameLabel.font = [UIFont customPingFSemiboldFontWithSize:15];
    [self addSubview:_nickNameLabel];
    [_nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(20);
        make.top.equalTo(self.iconImageView);
    }];
    
    _timeLabel = [[PMLBaseLabel alloc] init];
    _timeLabel.textColor = kRGBGrayColor(26);
    _timeLabel.font = [UIFont customPingFRegularFontWithSize:11];
    [self addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickNameLabel);
        make.top.equalTo(self.nickNameLabel.mas_bottom).offset(8);
    }];
    
    _diaryCountLabel = [[PMLBaseLabel alloc] init];
    _diaryCountLabel.textColor = kRGBGrayColor(26);
    _diaryCountLabel.font = [UIFont customPingFRegularFontWithSize:11];
    [self addSubview:_diaryCountLabel];
    [_diaryCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickNameLabel);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(5);
    }];
    
    _focusBtn = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    [_focusBtn setTitleColor:kRGBGrayColor(251) forState:UIControlStateNormal];
    _focusBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_focusBtn];
    [_focusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nickNameLabel);
        make.bottom.equalTo(self.iconImageView);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    _diaryTypeLabel = [[PMLBaseLabel alloc] init];
    _diaryTypeLabel.textColor = kRGBGrayColor(102);
    _diaryTypeLabel.font = [UIFont customPingFMediumFontWithSize:12];
    [self addSubview:_diaryTypeLabel];
    [_diaryTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(15);
        make.right.equalTo(self).offset(-15);
    }];
    
    PMLBaseView *lineView = [[PMLBaseView alloc] init];
    lineView.backgroundColor = kRGBGrayColor(204);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.diaryTypeLabel.mas_bottom).offset(10);
    }];
    [self layoutIfNeeded];
    self.iconImageView.backgroundColor = kRandomColor;
    [self.iconImageView setCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
}

@end
