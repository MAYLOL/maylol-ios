//
//  PMLContentDetailUserCollectionCell.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/14.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLContentDetailUserCollectionCell.h"

@interface PMLContentDetailUserCollectionCell()
@property (nonatomic, strong) UIImageView *iconImageView;//头像
@property (nonatomic, strong) PMLBaseLabel *nameLabel;//名字
@property (nonatomic, strong) PMLBaseLabel *signLabel;//签名
@property (nonatomic, strong) PMLBaseButton *careBtn;//关注
@end

@implementation PMLContentDetailUserCollectionCell
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
        make.size.mas_equalTo(CGSizeMake(50, 50));
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
    _signLabel.textColor = [UIColor colorWithHex:@"#262626"];
    _signLabel.font = [UIFont customPingFRegularFontWithSize:10];
    [_signLabel sizeToFit];
    _signLabel.text = kInternationalContent(@"余生很短尽情享受");
    [self addSubview:_signLabel];

    UIStackView *starkView = [[UIStackView alloc] initWithArrangedSubviews:@[_nameLabel,
                                                                             _signLabel
                                                                             ]];
    starkView.spacing = 6;
    starkView.axis = UILayoutConstraintAxisVertical;
    starkView.distribution = UIStackViewDistributionEqualSpacing;
    starkView.alignment = UIStackViewAlignmentLeading;

    [self addSubview:starkView];
    [starkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.iconImageView.mas_centerY).offset(0);
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
    }];

    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];
    [self addSubview:redView];
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-26);
        make.centerY.equalTo(self.iconImageView.mas_centerY).offset(0);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(55);
    }];
    [self layoutIfNeeded];
    UIBezierPath *rPath = [UIBezierPath bezierPathWithRoundedRect:redView.bounds cornerRadius:10];
    CAShapeLayer *rMaskLayer = [CAShapeLayer layer];
    rMaskLayer.frame = redView.bounds;
    rMaskLayer.path = rPath.CGPath;
    redView.layer.mask = rMaskLayer;
    
    PMLBaseButton *careBtn = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    //    [careBtn addTarget:self action:@selector(loginClicked) forControlEvents:UIControlEventTouchUpInside];
    [careBtn setBackgroundColor:[UIColor whiteColor]];
    [careBtn setTitle:kInternationalContent(@"关注") forState:UIControlStateNormal];
    [careBtn setTitleColor:[UIColor colorWithHex:@"#F02E44"] forState:UIControlStateDisabled];
    [careBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    careBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:11];
    careBtn.enabled = NO;
    [self addSubview:careBtn];
    _careBtn = careBtn;
    [careBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-27);
        make.centerY.equalTo(self.iconImageView.mas_centerY).offset(0);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(53);
    }];
    [self layoutIfNeeded];
    UIBezierPath *cPath = [UIBezierPath bezierPathWithRoundedRect:self.careBtn.bounds cornerRadius:9];
    CAShapeLayer *cMaskLayer = [CAShapeLayer layer];
    cMaskLayer.frame = self.careBtn.bounds;
    cMaskLayer.path = cPath.CGPath;
    self.careBtn.layer.mask = cMaskLayer;
}
@end
