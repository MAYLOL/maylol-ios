//
//  PMLCommitButton.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/26.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLCommitButton.h"

@implementation PMLCommitButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        self.backgroundColor = kRGBGrayColor(230);
        [self setTitleColor:kRGBGrayColor(204) forState:UIControlStateNormal];
        self.normalTitleColor = [UIColor whiteColor];
        self.disableTitleColor = kRGBGrayColor(200);
        self.normalColor = kRedColor;
        self.disableColor = kRGBGrayColor(230);
    }
    return self;
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
}

- (void)setDisableColor:(UIColor *)disableColor {
    _disableColor = disableColor;
}

- (void)setNormalTitleColor:(UIColor *)normalTitleColor {
    _normalTitleColor = normalTitleColor;
}

- (void)setDisableTitleColor:(UIColor *)disableTitleColor {
    _disableTitleColor = disableTitleColor;
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    if (enabled) {
        [self setTitleColor:self.normalTitleColor forState:UIControlStateNormal];
        self.backgroundColor = self.normalColor;
    }else {
        [self setTitleColor:self.disableTitleColor forState:UIControlStateNormal];
        self.backgroundColor = self.disableColor;
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
