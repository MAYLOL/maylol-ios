//
//  PMLPersonalCenterHeaderView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/22.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLPersonalCenterHeaderView.h"
#import "PMLFreeButton.h"

@interface PMLPersonalCenterHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet PMLFreeButton *ageBtn;
@property (weak, nonatomic) IBOutlet UILabel *constellationLabel; // 星座
@property (weak, nonatomic) IBOutlet PMLFreeButton *locationBtn;
@property (weak, nonatomic) IBOutlet PMLFreeButton *professionBtn;//职业
@property (weak, nonatomic) IBOutlet UILabel *signatureLabel;
- (IBAction)editInfoBtnClicked:(PMLBaseButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *focusLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishLabel;
@property (weak, nonatomic) IBOutlet UILabel *praiseLabel;
@property (weak, nonatomic) IBOutlet UILabel *myPublishLabel;

@property (weak, nonatomic) IBOutlet UIImageView *jumpWalletImageView;
@property (weak, nonatomic) IBOutlet UILabel *jumpWalletLabel;
@property (weak, nonatomic) IBOutlet UIImageView *jumpFocusImageView;
@property (weak, nonatomic) IBOutlet UILabel *jumpFocusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *jumpFansImageView;
@property (weak, nonatomic) IBOutlet UILabel *jumpFansLabel;


@property (weak, nonatomic) IBOutlet UIView *walletView;
@property (weak, nonatomic) IBOutlet UIView *focusView;
@property (weak, nonatomic) IBOutlet UIView *fansView;

@end

@implementation PMLPersonalCenterHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.focusLabel.text = @"125\n关注";
    self.fansLabel.text = @"8888\n粉丝";
    self.publishLabel.text = @"1543\n发布";
    self.praiseLabel.text = @"156887\n获赞";
    [self.ageBtn setUpImageViewSize:self.ageBtn.imageView.image.size margin:6 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    [self.locationBtn setUpImageViewSize:self.locationBtn.imageView.image.size margin:6 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    [self.professionBtn setUpImageViewSize:self.professionBtn.imageView.image.size margin:6 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    self.jumpWalletLabel.font = [UIFont customPingFRegularFontWithSize:13];
    self.jumpFocusLabel.font = [UIFont customPingFRegularFontWithSize:13];
    self.jumpFansLabel.font = [UIFont customPingFRegularFontWithSize:13];
    self.myPublishLabel.font = [UIFont customPingFSemiboldFontWithSize:15];
    self.myPublishLabel.text = kInternationalContent(@"我的发布");
    [self.walletView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpViewTouch:)]];
    [self.focusView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpViewTouch:)]];
    [self.fansView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpViewTouch:)]];
    
}

- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    self.jumpWalletImageView.image = kImageWithName([_imageArray stringAtCheckedIndex:0]);
    self.jumpFocusImageView.image = kImageWithName([_imageArray stringAtCheckedIndex:1]);
    self.jumpFansImageView.image = kImageWithName([_imageArray stringAtCheckedIndex:2]);
}

- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    self.jumpWalletLabel.text = [_titleArray stringAtCheckedIndex:0];
    self.jumpFocusLabel.text = [_titleArray stringAtCheckedIndex:1];
    self.jumpFansLabel.text = [_titleArray stringAtCheckedIndex:2];
}
- (IBAction)editInfoBtnClicked:(PMLBaseButton *)sender {
}

- (void)jumpViewTouch:(UITapGestureRecognizer *)tap
{
    if (self.headerViewTouchBlock) {
        UIView *view = tap.view;
        NSInteger tag = view.tag;
        switch (tag) {
            case 1:
            {
                //钱包
                self.headerViewTouchBlock(HeaderViewTouchWallet);
            }
                break;
            case 2:
            {
                //关注圈
                self.headerViewTouchBlock(HeaderViewTouchFocus);
            }
                break;
            case 3:
            {
                //粉丝圈
                self.headerViewTouchBlock(HeaderViewTouchFans);
            }
                break;
            default:
                break;
        }
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
