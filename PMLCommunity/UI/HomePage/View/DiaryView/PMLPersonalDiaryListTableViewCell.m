//
//  PMLPersonalDiaryListTableViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLPersonalDiaryListTableViewCell.h"
#import "PMLFreeButton.h"
@interface PMLPersonalDiaryListTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *diaryIndexLabel;
@property (weak, nonatomic) IBOutlet UIView *centerContentView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *afterLabel;
@property (weak, nonatomic) IBOutlet UILabel *beforeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet PMLFreeButton *commentCountBtn;
@property (weak, nonatomic) IBOutlet PMLFreeButton *likeCountBtn;

@end

@implementation PMLPersonalDiaryListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _leftImageView.backgroundColor = kRandomColor;
    _rightImageView.backgroundColor = kRandomColor;
//    _centerContentView.backgroundColor = [UIColor grayColor];
    _leftImageView.layer.cornerRadius = 4;
    _rightImageView.layer.cornerRadius = 4;
    [_afterLabel setCorners:UIRectCornerBottomLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(4, 4)];
    [_beforeLabel setCorners:UIRectCornerBottomLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(4, 4)];
//    [_centerContentView setCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(10, 10)];
    _centerContentView.layer.cornerRadius = 10;
    _centerContentView.layer.shadowColor = kRGBAColor(128, 128, 128, 0.3).CGColor;
    _centerContentView.layer.shadowOffset = CGSizeMake(1, 3);
    _centerContentView.layer.shadowRadius = 5;
    _centerContentView.layer.shadowOpacity = 1.0;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
