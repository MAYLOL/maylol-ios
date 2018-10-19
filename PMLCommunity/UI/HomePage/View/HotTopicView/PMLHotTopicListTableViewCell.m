//
//  PMLHotTopicListTableViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLHotTopicListTableViewCell.h"
#import "PMLFreeButton.h"
@interface PMLHotTopicListTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet PMLFreeButton *hotCountBtn;
@property (weak, nonatomic) IBOutlet PMLFreeButton *commentCountBtn;

@end

@implementation PMLHotTopicListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _contentLabel.font = [UIFont customPingFRegularFontWithSize:14];
    UIImage *hotImage = kImageWithName(@"home_topic_icon_hot");
    [_hotCountBtn setImage:hotImage forState:UIControlStateNormal];
    [_hotCountBtn setUpImageViewSize:hotImage.size margin:5 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    UIImage *commentImage = kImageWithName(@"home_topic_icon_comment");
    [_commentCountBtn setImage:commentImage forState:UIControlStateNormal];
    [_commentCountBtn setUpImageViewSize:commentImage.size margin:5 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    [self layoutIfNeeded];
    [_contentImageView setCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(4, 4)];
    _contentImageView.backgroundColor = kRandomColor;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
