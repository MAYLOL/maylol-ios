//
//  PMLItemButton.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/20.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLItemButton.h"

@interface PMLItemButton ()
@property (nonatomic, strong) PMLBaseLabel *contentLabel;
@property (nonatomic, strong) PMLBaseButton *deleteBtn;
@end

@implementation PMLItemButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kRGBColor(240, 46, 68);
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    _contentLabel = [[PMLBaseLabel alloc] init];
    _contentLabel.textColor = [UIColor whiteColor];
    _contentLabel.font = [UIFont customPingFRegularFontWithSize:10];
    [_contentLabel sizeToFit];
    [self addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self);
    }];
    
    _deleteBtn = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn setImage:kImageWithName(@"beautiful_btn_delete") forState:UIControlStateNormal];
    [self addSubview:_deleteBtn];
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-5);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(7);
    }];
    
    PMLBaseButton *touchBtn = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    [touchBtn addTarget:self action:@selector(deleteBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:touchBtn];
    [touchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.centerY.equalTo(self);
        make.height.equalTo(self);
        make.width.mas_equalTo(7 * 2);
    }];
}

#pragma mark-setter getter
- (void)setContentStr:(NSString *)contentStr {
    _contentStr = contentStr;
    self.contentLabel.text = _contentStr;
}

- (UIFont *)itemFont {
    return self.contentLabel.font;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.width = [PMLTools sizeForString:self.contentLabel.text font:self.contentLabel.font maxSize:CGSizeMake(200, 50)].width + 15 + 10 + 7 +5;
    [self setCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(12, 12)];
}

#pragma marl-sender touch
- (void)deleteBtnClicked:(PMLBaseButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteItemView:)]) {
        [self.delegate deleteItemView:self];
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
