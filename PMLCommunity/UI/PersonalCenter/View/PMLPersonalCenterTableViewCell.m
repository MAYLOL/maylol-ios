//
//  PMLPersonalCenterTableViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/22.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLPersonalCenterTableViewCell.h"
@interface PMLPersonalCenterTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *bottomContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTimeLabel;

@end

@implementation PMLPersonalCenterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellIndex:(NSInteger)cellIndex {
    _cellIndex = cellIndex;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
