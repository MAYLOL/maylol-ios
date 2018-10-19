//
//  PMLContentDetailMoreCollectionCell.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/14.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLContentDetailMoreCollectionCell.h"
#import "PMLFreeButton.h"

@interface PMLContentDetailMoreCollectionCell()
@property (nonatomic, strong) PMLBaseLabel *timeLabel;//时间
@property (nonatomic, strong) PMLFreeButton *praiseBtn;//点赞按钮
@property (nonatomic, strong) UIButton *moreBtn;//更多
@end

@implementation PMLContentDetailMoreCollectionCell
- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.timeLabel];
    [self addSubview:self.praiseBtn];
    [self addSubview:self.moreBtn];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(25);
        make.bottom.equalTo(self.praiseBtn.mas_top).offset(-15);
    }];
    
    [self.praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(25);
        make.bottom.equalTo(self.mas_bottom).offset(-23);
    }];

    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-25);
        make.bottom.equalTo(self.mas_bottom).offset(-23);
    }];
}

- (void)moreBtnClicked {

}

- (void)praiseBtnClicked {

}

#pragma mark- =====================getter method=====================
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
        UIImage *praiseImage = kImageWithName(@"home_icon_like");
        UIImage *praiseImageClick = kImageWithName(@"home_icon_like_click");
        [_praiseBtn setImage:praiseImage forState:UIControlStateNormal];
        [_praiseBtn setImage:praiseImageClick forState:UIControlStateSelected];
        [_praiseBtn setTitle:@"999+" forState:UIControlStateNormal];
        [_praiseBtn setTitleColor:[UIColor colorWithHex:@"#000000"] forState:UIControlStateNormal];
        _praiseBtn.titleLabel.font = [UIFont customPingFMediumFontWithSize:7];
        [_praiseBtn setUpImageViewSize:praiseImage.size margin:2 alignment:PMLFreeBtnAlignmentHorizontalLeft];
        [_praiseBtn addTarget:self action:@selector(praiseBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _praiseBtn;
}

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:kImageWithName(@"home_follow_icon_more") forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_moreBtn sizeToFit];
    }
    return _moreBtn;
}

@end
