//
//  PMLCommentDetailTextView.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLCommentDetailTextView.h"

@implementation PMLCommentDetailTextView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.textLabel];

        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.mas_equalTo(self);
        }];
    }
    return self;
}

- (void)setDetail:(NSString *)detail
{
    _detail = detail;
    [self.textLabel setText:detail];
//    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(detail.detailFrame.heightText);
//    }];
}

#pragma mark - # Getter
- (UILabel *)textLabel
{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc] init];
        [_textLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_textLabel setTextColor:[UIColor colorWithHex:@"#666666"]];
        [_textLabel setNumberOfLines:0];
    }
    return _textLabel;
}

@end
