//
//  PMLBaseTextView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/14.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseTextView.h"

#define placeholderFont [UIFont systemFontOfSize:14]

@interface PMLBaseTextView ()
@property (nonatomic, strong) PMLBaseLabel *placeholderLabel;
@end

@implementation PMLBaseTextView

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.placeholderLabel.text = _placeholder;
}

- (PMLBaseLabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        CGSize size = [PMLTools sizeForString:self.placeholder font:placeholderFont maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
        _placeholderLabel = [[PMLBaseLabel alloc] initWithFrame:CGRectMake(5, 6, size.width, size.height)];
        _placeholderLabel.textColor = [UIColor lightGrayColor];
        _placeholderLabel.font = placeholderFont;
        _placeholderLabel.text = self.placeholder;
        [self addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
}

- (void)setShowPlaceholder:(BOOL)showPlaceholder
{
    _showPlaceholder = showPlaceholder;
    self.placeholderLabel.hidden = _showPlaceholder;
}
- (void)dealloc {
    NSLog(@"%@------%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
