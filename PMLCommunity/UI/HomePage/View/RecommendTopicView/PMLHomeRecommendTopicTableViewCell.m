//
//  PMLHomeRecommendTopicTableViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/20.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLHomeRecommendTopicTableViewCell.h"
#import "PMLFreeButton.h"

@interface PMLHomeRecommendTopicTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
- (IBAction)moreBtnClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet PMLFreeButton *lookCountBtn;
@property (weak, nonatomic) IBOutlet PMLFreeButton *commentedCountBtn;
@property (weak, nonatomic) IBOutlet PMLFreeButton *likeCountBtn;

@end

@implementation PMLHomeRecommendTopicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.font = [UIFont customPingFMediumFontWithSize:12];
    self.titleLabel.font = [UIFont customPingFRegularFontWithSize:14];
    self.contentLabel.font = [UIFont customPingFRegularFontWithSize:12];
    self.lookCountBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:10];
    self.commentedCountBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:10];
    self.likeCountBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:10];
    [self layoutIfNeeded];
    self.contentImageView.backgroundColor = kRandomColor;
    self.iconImageView.backgroundColor = kRandomColor;
    [self.contentImageView setCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(4, 4)];
    [self.iconImageView setCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(15, 15)];
    UIImage *lookImage = kImageWithName(@"home_topic_see");
    [_lookCountBtn setImage:lookImage forState:UIControlStateNormal];
    [_lookCountBtn setUpImageViewSize:lookImage.size margin:5 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    UIImage *commentImage = kImageWithName(@"home_topic_icon_comment");
    [_commentedCountBtn setImage:commentImage forState:UIControlStateNormal];
    [_commentedCountBtn setUpImageViewSize:commentImage.size margin:5 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    UIImage *likeImage = kImageWithName(@"home_topic_icon_like");
    [_likeCountBtn setImage:likeImage forState:UIControlStateNormal];
    [_likeCountBtn setUpImageViewSize:likeImage.size margin:5 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    // Initialization code
}

#pragma mark-setter
- (void)setCellIndex:(NSInteger)cellIndex {
    _cellIndex = cellIndex;
}

- (IBAction)moreBtnClicked:(UIButton *)sender {
    if (self.recommendTopicBLock) {
        self.recommendTopicBLock(self.cellIndex);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
