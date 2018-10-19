//
//  PMLHomeMonerAlertView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/10/18.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLHomeMonerAlertView.h"

@interface PMLHomeMonerAlertView ()
@property (weak, nonatomic) IBOutlet UILabel *articleRewardLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalRewardLabel;

@end

@implementation PMLHomeMonerAlertView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 5;
    self.layer.borderColor = kRGBAColor(230, 230, 230, 0.9).CGColor;
    self.layer.borderWidth = 1;
}

- (void)setArticleReward:(NSString *)articleReward {
    _articleReward = articleReward;
    self.articleRewardLabel.text = [NSString stringWithFormat:@"获得奖励 $ %@",_articleReward];
}

- (void)setTotalReward:(NSString *)totalReward {
    _totalReward = totalReward;
    self.totalRewardLabel.text = [NSString stringWithFormat:@"累计获得奖励 $ %@",_totalReward];
}

- (float)viewWidth {
    float topLabelWidth = [PMLTools sizeForString:self.articleRewardLabel.text font:self.articleRewardLabel.font maxSize:CGSizeMake(kScreenWidth/2, 10)].width;
    float bottomLabelWidth = [PMLTools sizeForString:self.totalRewardLabel.text font:self.totalRewardLabel.font maxSize:CGSizeMake(kScreenWidth/2, 10)].width;
    float maxWidth = topLabelWidth > bottomLabelWidth ? topLabelWidth + 30 : bottomLabelWidth + 30;
    return maxWidth;
//    if (maxWidth < kScreenWidth/2 - 50) {
//        return kScreenWidth/2 - 50;
//    }else {
//        return maxWidth;
//    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
