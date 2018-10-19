//
//  PMLHotTopicHeaderView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/21.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLHotTopicHeaderView.h"
#import "PMLFreeButton.h"
@interface PMLHotTopicHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *focusonTopicBtn;
@property (weak, nonatomic) IBOutlet UILabel *answerNumLabel;
@property (weak, nonatomic) IBOutlet PMLFreeButton *writeAnswerBtn;
@property (weak, nonatomic) IBOutlet PMLFreeButton *sortingBtn;

@end

@implementation PMLHotTopicHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    UIImage *answerImage = self.writeAnswerBtn.imageView.image;
    [self.writeAnswerBtn setUpImageViewSize:answerImage.size margin:8 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    [self.sortingBtn setUpImageViewSize:CGSizeMake(9, 6) margin:4 alignment:PMLFreeBtnAlignmentHorizontalRight];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
