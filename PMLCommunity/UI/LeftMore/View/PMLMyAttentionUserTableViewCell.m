//
//  PMLMyAttentionUserTableViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/24.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLMyAttentionUserTableViewCell.h"

@interface PMLMyAttentionUserTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *signatureLabel;

@end

@implementation PMLMyAttentionUserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _iconImageView.layer.cornerRadius = 20;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
