//
//  PMLBeautyDiaryTableViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBeautyDiaryTableViewCell.h"
#import "PMLFreeButton.h"
@interface PMLBeautyDiaryTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftContentImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightContentImageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicTypeLabel;
@property (weak, nonatomic) IBOutlet PMLFreeButton *lookCountBtn;
@property (weak, nonatomic) IBOutlet PMLFreeButton *commentCountBtn;
@property (weak, nonatomic) IBOutlet PMLFreeButton *likeCountBtn;
@property (weak, nonatomic) IBOutlet UILabel *afterLabel;
@property (weak, nonatomic) IBOutlet UILabel *beforeLabel;

@end
@implementation PMLBeautyDiaryTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _iconImageView.backgroundColor = kRandomColor;
    _leftContentImageView.backgroundColor = kRandomColor;
    _rightContentImageView.backgroundColor = kRandomColor;
    _afterLabel.backgroundColor = kRGBAColor(0, 0, 0, 0.6);
    _beforeLabel.backgroundColor = kRGBAColor(0, 0, 0, 0.6);
    [self layoutIfNeeded];
    _leftContentImageView.layer.cornerRadius = 4;
    _rightContentImageView.layer.cornerRadius = 4;
    [_iconImageView setCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(25.0/2, 25.0/2)];
    [_afterLabel setCorners:UIRectCornerBottomLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(4, 4)];
    [_beforeLabel setCorners:UIRectCornerBottomLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(4, 4)];
    UIImage *lookImage = kImageWithName(@"home_topic_see");
    [_lookCountBtn setImage:lookImage forState:UIControlStateNormal];
    [_lookCountBtn setUpImageViewSize:lookImage.size margin:5 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    UIImage *commentImage = kImageWithName(@"home_topic_icon_comment");
    [_commentCountBtn setImage:commentImage forState:UIControlStateNormal];
    [_commentCountBtn setUpImageViewSize:commentImage.size margin:5 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    UIImage *likeImage = kImageWithName(@"home_topic_icon_like");
    [_likeCountBtn setImage:likeImage forState:UIControlStateNormal];
    [_likeCountBtn setUpImageViewSize:likeImage.size margin:5 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
