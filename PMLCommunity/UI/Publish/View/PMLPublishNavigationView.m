//
//  PMLPublishNavigationView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/31.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLPublishNavigationView.h"
@implementation PMLPublishNavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    PMLBaseView *lineView = [[PMLBaseView alloc] init];
    lineView.backgroundColor =kRGBGrayColor(243);
    [self addSubview:lineView];
    PMLBaseButton *cancelBtn = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelPublishClicked) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn sizeToFit];
    [cancelBtn setTitleColor:kRGBGrayColor(101) forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:15];
    [self addSubview:cancelBtn];
    
    PMLBaseButton *publishBtn = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    [publishBtn setTitle:@"发布" forState:UIControlStateNormal];
    [publishBtn addTarget:self action:@selector(publishClicked) forControlEvents:UIControlEventTouchUpInside];
    [publishBtn setTitleColor:kRGBColor(240, 46, 68) forState:UIControlStateNormal];
    publishBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:15];
    [self addSubview:publishBtn];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.equalTo(lineView.mas_top).offset(-8);
    }];
    
    [publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(cancelBtn);
    }];
}

#pragma mark-sender touch
- (void)cancelPublishClicked
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topItemTouchWithType:)]) {
        [self.delegate topItemTouchWithType:0];
    }
}

- (void)publishClicked
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topItemTouchWithType:)]) {
        [self.delegate topItemTouchWithType:1];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
