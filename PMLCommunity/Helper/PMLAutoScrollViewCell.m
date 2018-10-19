//
//  PMLAutoScrollViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/14.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLAutoScrollViewCell.h"

@interface PMLAutoScrollViewCell ()
@property (nonatomic, strong) UILabel *itemLabel;
@end

@implementation PMLAutoScrollViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _itemLabel = [[UILabel alloc] init];
        _itemLabel.textAlignment = NSTextAlignmentCenter;
        [_itemLabel sizeToFit];
//        _labelFont = 13;
        _normalColor = [UIColor colorWithHex:@"#999999"];
        _selectColor = [UIColor colorWithHex:@"#000000"];
        _normalFont = [UIFont customPingFRegularFontWithSize:13];
        _selectFont = [UIFont customPingFMediumFontWithSize:13];
        [self.contentView addSubview:_itemLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _itemLabel.frame = self.contentView.bounds;
}

- (void)setItemStr:(NSString *)itemStr {
    _itemStr = itemStr;
    _itemLabel.text = _itemStr;
}

//- (void)setLabelFont:(CGFloat)labelFont {
//    _labelFont = labelFont;
//}

- (void)setSelectColor:(UIColor *)selectColor {
    _selectColor = selectColor;
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
}

- (void)setNormalFont:(UIFont *)normalFont {
    _normalFont = normalFont;
}

- (void)setSelectFont:(UIFont *)selectFont {
    _selectFont = selectFont;
}

- (void)setItemSelected:(BOOL)itemSelected {
    _itemSelected = itemSelected;
    if (_itemSelected) {
        _itemLabel.textColor = self.selectColor;
        _itemLabel.font = self.selectFont;
    }else {
        _itemLabel.textColor = self.normalColor;
        _itemLabel.font = self.normalFont;
    }
    
    
}
@end
