//
//  PMLCommunityCollectionViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/27.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLCommunityCollectionViewCell.h"
#import "PMLHomeWaterFlowModel.h"
#import "PMLMaskView.h"
#import "PMLFreeButton.h"
#import "PMLHomeMonerAlertView.h"

@interface PMLCommunityCollectionViewCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentImageHeight;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet PMLFreeButton *moneyBtn;
@property (weak, nonatomic) IBOutlet PMLFreeButton *likeBtn;
- (IBAction)itemClicked:(PMLFreeButton *)sender;

@property (nonatomic, strong) PMLMaskView *maskView;
@property (nonatomic, strong) PMLHomeMonerAlertView *alertView;
@end

@implementation PMLCommunityCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [_likeBtn setUpImageViewSize:CGSizeMake(13, 12) margin:5 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    _iconImageView.layer.cornerRadius = 7.5;
    _iconImageView.clipsToBounds = YES;
    _contentImageView.layer.cornerRadius = 5;
    _contentImageView.clipsToBounds = YES;
    UIImage *triangleImage= kImageWithName(@"home_money_arrow");
    [_moneyBtn setUpImageViewSize:triangleImage.size margin:2 alignment:PMLFreeBtnAlignmentHorizontalRight];
    // Initialization code
}

- (void)setModel:(PMLHomeWaterFlowModel *)model {
    _model = model;
    [_contentImageView sd_setImageWithURL:[NSURL URLWithString:_model.articleCover]];
    _contentLabel.text = _model.articleTitle;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_model.authorIcon]];
    _nickNameLabel.text = _model.authorName;
    if (_model.likeNum > 999) {
        [_likeBtn setTitle:@"999+" forState:UIControlStateNormal];
    }else {
        [_likeBtn setTitle:[NSString stringWithFormat:@"%ld",_model.likeNum] forState:UIControlStateNormal];
    }
    
    [_moneyBtn setTitle:[NSString stringWithFormat:@"$%.1f",_model.moneyReward] forState:UIControlStateNormal];
    _contentImageHeight.constant = ((kScreenWidth - 40)/2)/_model.coverWH;
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
}

- (IBAction)itemClicked:(PMLFreeButton *)sender {
    
    UIWindow *window = kApplication.keyWindow;
    CGRect rect1 = [sender convertRect:sender.frame fromView:self.contentView];//获取button在contentView的位置
    CGRect rect2 = [sender convertRect:rect1 toView:window];
//    Printing description of rect2:
//    (CGRect) rect2 = (origin = (x = 10.5, y = 0), size = (width = 0.5, height = 0))
//    Printing description of rect2:
//    (CGRect) rect2 = (origin = (x = 26, y = 441), size = (width = 32, height = 10))
    switch (sender.tag) {
        case 1:
        {
            //点击金额按钮
            //                [self.delegate cellItemClicked:sender touchType:TouchItemMoney];
            self.maskView = [[PMLMaskView alloc] initMaskViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) target:self select:@selector(maskViewTouch)];
            self.maskView.backgroundColor = [UIColor clearColor];
            [kApplication.keyWindow addSubview:self.maskView];
            
            PMLHomeMonerAlertView *alertView = [PMLHomeMonerAlertView loadViewFromNib];
            alertView.articleReward = [NSString stringWithFormat:@"%.1f",_model.moneyReward];
            alertView.totalReward = [NSString stringWithFormat:@"%.1f",_model.totalReward];
            alertView.frame = CGRectMake(rect2.origin.x - 8, rect2.origin.y + rect2.size.height + 3, alertView.viewWidth, 35);
            if (alertView.bottom > kScreenHeight - kTabBar - 20) {
                alertView.bottom = rect2.origin.y - 5;
            }
            _alertView = alertView;
            [kApplication.keyWindow addSubview:alertView];
            
            [PMLTools rotationImageWithImageView:sender.imageView radian:M_PI complete:nil];
        }
            break;
            
        case 2:
        {
            //点击喜欢按钮
            if (self.delegate && [self.delegate respondsToSelector:@selector(cellItemClicked:touchType:)]) {
                [self.delegate cellItemClicked:self.indexPath touchType:TouchItemLike];
            }
            
        }
            break;
        default:
            break;
    }
}

- (void)maskViewTouch {
    [self.alertView removeFromSuperview];
    self.alertView = nil;
    [self.maskView removeFromSuperview];
    self.maskView = nil;
    [PMLTools rotationImageWithImageView:self.moneyBtn.imageView radian:2 * M_PI complete:nil];
}
@end
