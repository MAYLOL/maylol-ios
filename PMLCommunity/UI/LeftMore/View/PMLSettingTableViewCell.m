//
//  PMLSettingTableViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/25.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLSettingTableViewCell.h"

@interface PMLSettingTableViewCell ()

@end

@implementation PMLSettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImage *arrowImage = kImageWithName(@"beautiful_icon_return");
    _arrowImageView.image = [arrowImage imageWithColor:kRGBGrayColor(153)];
    _rightLabel.text = [NSString stringWithFormat:@"%@ %@",kInternationalContent(@"版本"),[PMLTools getAppVersion]];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
