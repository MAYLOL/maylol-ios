//
//  PMLGamesHeaderView.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/12.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLGamesHeaderView.h"

@interface PMLGamesHeaderView()
@property (nonatomic, strong) UIImageView *iconImageView;//头像
@property (nonatomic, strong) PMLBaseLabel *nameLabel;//名字
@property (nonatomic, strong) PMLBaseLabel *signLabel;//签名
@property (nonatomic, strong) UIView *underLine;
@end

@implementation PMLGamesHeaderView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor whiteColor];

    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.backgroundColor = [UIColor redColor];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(26);
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.size.mas_equalTo(CGSizeMake(55, 55));
    }];
    [self layoutIfNeeded];

    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.iconImageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.iconImageView.bounds.size];

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.iconImageView.bounds;
    maskLayer.path = path.CGPath;
    self.iconImageView.layer.mask = maskLayer;

    _nameLabel = [[PMLBaseLabel alloc] init];
    _nameLabel.textColor = [UIColor colorWithHex:@"#262626"];
    _nameLabel.font = [UIFont customPingFSemiboldFontWithSize:15];
    [_nameLabel sizeToFit];
    _nameLabel.text = kInternationalContent(@"Zoey_zhou");
    [self addSubview:_nameLabel];

    _signLabel = [PMLBaseLabel new];
    _signLabel.textColor = [UIColor colorWithHex:@"#666666"];
    _signLabel.font = [UIFont customPingFMediumFontWithSize:12];
    [_signLabel sizeToFit];
    _signLabel.text = kInternationalContent(@"余生很短尽情享受");
    [self addSubview:_signLabel];

    UIStackView *starkView = [[UIStackView alloc] initWithArrangedSubviews:@[_nameLabel,
                                                                             _signLabel
                                                                             ]];
    starkView.spacing = 11;
    starkView.axis = UILayoutConstraintAxisVertical;
    starkView.distribution = UIStackViewDistributionEqualSpacing;
    starkView.alignment = UIStackViewAlignmentLeading;

    [self addSubview:starkView];
    [starkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView.mas_centerY).offset(0);
        make.left.equalTo(self.iconImageView.mas_right).offset(13);
    }];

   UIView *underLine = [UIView new];
    underLine.backgroundColor = [UIColor colorWithHex:@"#E6E6E6"];
    [self addSubview:underLine];
    [underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(1);
    }];
    _underLine = underLine;
}

@end
