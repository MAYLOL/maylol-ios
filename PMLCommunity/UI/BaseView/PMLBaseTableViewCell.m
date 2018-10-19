//
//  PMLBaseTableViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/14.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseTableViewCell.h"

@implementation PMLBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the view for the selected state
}

- (void)dealloc {
    NSLog(@"%@------%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
}

@end
