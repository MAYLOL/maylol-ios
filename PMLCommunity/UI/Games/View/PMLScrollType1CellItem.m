//
//  PMLScrollType1CellItem.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/12.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLScrollType1CellItem.h"

@interface PMLScrollType1CellItem()
@property (weak, nonatomic) IBOutlet UIView *ringView;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIView *littleView;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;


@end

@implementation PMLScrollType1CellItem

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.ringView.layer.borderColor = [UIColor colorWithHex:@"#FF0068"].CGColor;
    self.ringView.layer.borderWidth = 1;
    self.ringView.layer.masksToBounds = true;
    self.ringView.layer.cornerRadius = 43/2;

    self.iconView.backgroundColor = [UIColor blackColor];
    self.iconView.layer.cornerRadius = 38/2;
    self.iconView.layer.masksToBounds = true;

    self.littleView.layer.cornerRadius = 13/2;
    self.littleView.layer.masksToBounds = true;

    self.ringView.hidden = true;
    self.littleView.hidden = true;
    self.tipsLabel.hidden = true;
}

- (void)setNumberStr:(NSString *)numberStr {
    self.ringView.hidden = false;
    self.littleView.hidden = false;
    self.tipsLabel.hidden = false;
    self.tipsLabel.text = numberStr;
}
- (void)setIsHide:(BOOL)isHide {
    _isHide = isHide;
    self.ringView.hidden = isHide;
    self.littleView.hidden = isHide;
    self.tipsLabel.hidden = isHide;
}

@end
