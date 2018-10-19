//
//  PMLMaskView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLMaskView.h"

@interface PMLMaskView ()
@end

@implementation PMLMaskView
- (instancetype)initMaskViewWithFrame:(CGRect)frame target:(id)target select:(SEL)select
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = kMaskAlpha;
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:target action:select]];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
