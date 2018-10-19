//
//  PMLHomeParticipateTopicTableViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLHomeParticipateTopicTableViewCell.h"

@interface PMLHomeParticipateTopicTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
- (IBAction)participationBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *participationBtn;

@end

@implementation PMLHomeParticipateTopicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = [UIFont customPingFMediumFontWithSize:14];
    self.participationBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:12];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//参与按钮点击
- (IBAction)participationBtnClicked:(UIButton *)sender {
}
@end
