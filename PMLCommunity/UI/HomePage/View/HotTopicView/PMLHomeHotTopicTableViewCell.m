//
//  PMLHomeHotTopicTableViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/20.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLHomeHotTopicTableViewCell.h"
#import "PMLFreeButton.h"

@interface PMLHomeHotTopicTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet PMLFreeButton *hotNumberBtn;
@property (weak, nonatomic) IBOutlet PMLFreeButton *commentedBtn;
@property (weak, nonatomic) IBOutlet UIImageView *topicImageView;

@end

@implementation PMLHomeHotTopicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.font = [UIFont customPingFRegularFontWithSize:14];
    self.hotNumberBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:10];
    self.commentedBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:10];
    UIImage *hotImage = kImageWithName(@"home_topic_icon_hot");
    [_hotNumberBtn setImage:hotImage forState:UIControlStateNormal];
    [_hotNumberBtn setUpImageViewSize:hotImage.size margin:5 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    UIImage *commentImage = kImageWithName(@"home_topic_icon_comment");
    [_commentedBtn setImage:commentImage forState:UIControlStateNormal];
    [_commentedBtn setUpImageViewSize:commentImage.size margin:5 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    [self layoutIfNeeded];
    _topicImageView.backgroundColor = kRandomColor;
    [_topicImageView setCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(4, 4)];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
