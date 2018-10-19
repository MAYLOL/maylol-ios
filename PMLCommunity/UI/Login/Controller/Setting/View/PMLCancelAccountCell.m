//
//  PMLCancelAccountCell.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/9.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLCancelAccountCell.h"

@implementation PMLCancelAccountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.logoutBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:15];
    self.logoutBtn.userInteractionEnabled = false;
    [self.logoutBtn setTitle:kInternationalContent(@"注销账号") forState:UIControlStateNormal];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    // Configure the view for the selected state
}

@end
