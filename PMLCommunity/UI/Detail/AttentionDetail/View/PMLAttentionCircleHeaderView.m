//
//  PMLAttentionCircleHeaderView.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/8.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLAttentionCircleHeaderView.h"

@interface PMLAttentionCircleHeaderView()
@property (nonatomic, strong) PMLBaseLabel *textLabel;
@property (nonatomic, strong) PMLBaseView *lineView;
@property (nonatomic, strong) PMLBaseView *redLineView;
@property (nonatomic, copy) NSString *topString;;
@end

@implementation PMLAttentionCircleHeaderView

- (instancetype)initWithFrame:(CGRect)frame topString:(NSString *)topString{
    if (self = [super initWithFrame:frame]) {
        _topString = topString;
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews
{
    PMLBaseLabel *textLabel = [[PMLBaseLabel alloc] init];
    textLabel.text = _topString;
    [textLabel sizeToFit];
    textLabel.textColor = [UIColor colorWithHex:@"#1a1a1a"];
    textLabel.font = [UIFont customPingFSemiboldFontWithSize:24];
    [self addSubview:textLabel];
    _textLabel = textLabel;

    PMLBaseView *lineView = [[PMLBaseView alloc] init];
    lineView.backgroundColor = kRGBGrayColor(249);
    [self addSubview:lineView];
    _lineView = lineView;

    PMLBaseView *redLineView = [[PMLBaseView alloc] init];
    redLineView.backgroundColor = kRedColor;
    redLineView.layer.cornerRadius = 1;
    [self addSubview:redLineView];
    _redLineView = redLineView;

    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.equalTo(self);
    }];

    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];

    [_redLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textLabel);
        make.bottom.equalTo(self.lineView.mas_top);
        make.width.equalTo(self.textLabel.mas_width);
        make.height.mas_equalTo(2);
    }];
}
@end
