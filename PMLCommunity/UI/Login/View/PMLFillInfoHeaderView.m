//
//  PMLFillInfoHeaderView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/26.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLFillInfoHeaderView.h"
#import "CameraHelper.h"
#import "PMLAlertController.h"

@interface PMLFillInfoHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *defaultImageView;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (nonatomic, strong) CAShapeLayer *iconshapeLayer;

@end

@implementation PMLFillInfoHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconshapeLayer = [_iconImageView setDottedBox:_iconImageView.bounds cornerRadius:5 strokeColor:kRGBGrayColor(153) lineWidth:4];
    _iconImageView.userInteractionEnabled = YES;
    [_iconImageView addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedIcon)]];
}

- (void)selectedIcon {
    UIAlertController *alert = [PMLAlertController showSheetAlertControllerWithTitle:kInternationalContent(@"添加头像") message:nil firstTitle:kInternationalContent(@"相册") firstHandler:^(UIAlertAction *action) {
        [[CameraHelper helper] showPickerViewControllerSourceType:UIImagePickerControllerSourceTypePhotoLibrary onViewController:self.controller completion:^(NSError *error, NSData *data) {
            if (!error) {
                self.iconImageView.image = [UIImage imageWithData:data];
                self.iconshapeLayer.strokeColor = [UIColor clearColor].CGColor;
                self.defaultImageView.hidden = YES;
                self.tipLabel.hidden = YES;
                if (self.headerBlock) {
                    self.headerBlock();
                }
            }
        }];
    } secondTitle:kInternationalContent(@"拍摄") secondHandler:^(UIAlertAction *action) {
        [[CameraHelper helper] showPickerViewControllerSourceType:UIImagePickerControllerSourceTypeCamera onViewController:self.controller completion:^(NSError *error, NSData *data) {
            if (!error) {
                self.iconImageView.image = [UIImage imageWithData:data];
                self.iconshapeLayer.strokeColor = [UIColor clearColor].CGColor;
                self.defaultImageView.hidden = YES;
                self.tipLabel.hidden = YES;
                if (self.headerBlock) {
                    self.headerBlock();
                }
            }
        }];
    } cancelHandler:nil];

    [self.controller presentViewController:alert animated:YES completion:nil];
}

- (UIImage *)iconImage {
    return self.iconImageView.image;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
