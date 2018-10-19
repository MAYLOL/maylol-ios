//
//  PMLPublishTopView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/28.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLPublishTopView.h"

@implementation PMLPublishTopView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userInteractionEnabled = YES;
    self.nameField.placeholder = kInternationalContent(@"发布到板块");
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectTouch)]];
}

- (void)selectTouch {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectPlate)]) {
        [self.delegate selectPlate];
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
