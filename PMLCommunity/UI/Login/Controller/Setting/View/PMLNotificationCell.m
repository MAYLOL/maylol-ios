//
//  PMLNotificationCell.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/10.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLNotificationCell.h"

@interface PMLNotificationCell()

@end

@implementation PMLNotificationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.bottomLine.hidden = true;
    [self.switchControl addTarget:self action:@selector(swithAction:) forControlEvents:UIControlEventValueChanged];
}

- (void)swithAction:(UISwitch *)sender {
    if (self.swtichBlock) {
        self.swtichBlock(sender.isOn);
    };
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
