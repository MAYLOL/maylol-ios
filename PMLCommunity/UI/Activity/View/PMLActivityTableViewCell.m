//
//  PMLActivityTableViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/21.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLActivityTableViewCell.h"

@interface PMLActivityTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
- (IBAction)watchMoreBtnClicked:(UIButton *)sender;
@end

@implementation PMLActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.font = [UIFont customPingFSemiboldFontWithSize:14];
    self.timeLabel.font = [UIFont customPingFRegularFontWithSize:13];
    self.contentLabel.font = [UIFont customPingFRegularFontWithSize:15];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)watchMoreBtnClicked:(UIButton *)sender {
}
@end
