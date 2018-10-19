//
//  PMLLeftColumnTableViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/21.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLLeftColumnTableViewCell.h"

@interface PMLLeftColumnTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@end

@implementation PMLLeftColumnTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _rightLabel.font = [UIFont customPingFRegularFontWithSize:13];
    // Initialization code
}

- (void)setLabelString:(NSString *)labelString
{
    _labelString = labelString;
    self.rightLabel.text = _labelString;
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    self.leftImageView.image = kImageWithName(_imageName);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
