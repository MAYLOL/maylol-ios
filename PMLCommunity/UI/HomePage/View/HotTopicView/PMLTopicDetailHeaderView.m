//
//  PMLTopicDetailHeaderView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/19.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLTopicDetailHeaderView.h"

@interface PMLTopicDetailHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *topicBtn;
- (IBAction)topicBtnClicked:(UIButton *)sender;

@end

@implementation PMLTopicDetailHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    [_topicBtn setCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(12, 12)];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)topicBtnClicked:(UIButton *)sender {
}
@end
