//
//  PMLMyCommentsTableViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/25.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLMyCommentsTableViewCell.h"

@interface PMLMyCommentsTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentContentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *authorIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorNickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalLabel;
@property (weak, nonatomic) IBOutlet UILabel *articleContentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *articleImageView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (weak, nonatomic) IBOutlet UIView *smallContentView;
- (IBAction)checkOriginalBtnClicked:(UIButton *)sender;

@end
@implementation PMLMyCommentsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    [_userIconImageView setCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(15, 15)];
    [_authorIconImageView setCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(12.5, 12.5)];
    _smallContentView.layer.cornerRadius = 5;
    _userIconImageView.backgroundColor = kRandomColor;
    _authorIconImageView.backgroundColor = kRandomColor;
    // Initialization code
}


- (IBAction)checkOriginalBtnClicked:(UIButton *)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
