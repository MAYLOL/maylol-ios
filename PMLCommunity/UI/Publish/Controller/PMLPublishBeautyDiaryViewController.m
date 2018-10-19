//
//  PMLPublishBeautyDiaryViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/20.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLPublishBeautyDiaryViewController.h"
#import "PMLSelectItemViewController.h"
#import "CameraHelper.h"

typedef NS_ENUM(NSInteger, ImageType) {
    ImageTypeLeft,
    ImageTypeRight,
};

@interface PMLPublishBeautyDiaryViewController ()
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UIButton *leftChangeBtn;
@property (weak, nonatomic) IBOutlet UILabel *leftTipLabel;
@property (weak, nonatomic) IBOutlet UIButton *leftSmallChangeBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightChangeBtn;
@property (weak, nonatomic) IBOutlet UILabel *rightTipLabel;
@property (weak, nonatomic) IBOutlet UIButton *rightSmallChangeBtn;
@property (weak, nonatomic) IBOutlet UITextView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomTipView;
@property (weak, nonatomic) IBOutlet UIButton *selectProjectBtn;
- (IBAction)viewBtnClicked:(UIButton *)sender;
@property (nonatomic, strong) CAShapeLayer *leftLayer;
@property (nonatomic, strong) CAShapeLayer *rightLayer;

@end

@implementation PMLPublishBeautyDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];
    PMLBaseButton *rightItem = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    [rightItem setTitle:kInternationalContent(@"发布") forState:UIControlStateNormal];
    [rightItem setTitleColor:kRGBColor(225, 25, 100) forState:UIControlStateNormal];
    rightItem.titleLabel.font = [UIFont customPingFRegularFontWithSize:15];
    [rightItem addTarget:self action:@selector(publishDiary) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    _leftTipLabel.text = kInternationalContent(@"上传整容前照片");
    _rightTipLabel.text = kInternationalContent(@"上传整容后照片");
    _leftLayer = [_leftImageView setDottedBox:_leftImageView.frame cornerRadius:5 strokeColor:kRGBGrayColor(179) lineWidth:10];
    _rightLayer = [_rightImageView setDottedBox:_rightImageView.frame cornerRadius:5 strokeColor:kRGBGrayColor(179) lineWidth:10];
    _leftSmallChangeBtn.hidden = YES;
    _rightSmallChangeBtn.hidden = YES;
    
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)viewBtnClicked:(UIButton *)sender {
    //1、2 更换手术前的照片  3、4 更换手术后的照片  5 选择项目
    switch (sender.tag) {
        case 1:
        case 2:
        {
            [self pushImagePickViewController:ImageTypeLeft];
        }
            break;
        case 3:
        case 4:
        {
            [self pushImagePickViewController:ImageTypeRight];
        }
            break;
        case 5:
        {
            [self pushViewControllerWithClassName:NSStringFromClass([PMLSelectItemViewController class]) params:nil];
        }
            break;
        default:
            break;
    }
}

- (void)pushImagePickViewController:(ImageType)type {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *album = [UIAlertAction actionWithTitle:kInternationalContent(@"相册") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[CameraHelper helper] showPickerViewControllerSourceType:UIImagePickerControllerSourceTypePhotoLibrary onViewController:self completion:^(NSError *error, NSData *data) {
            if (!error) {
                if (type == ImageTypeLeft) {
                    self.leftImageView.image = [UIImage imageWithData:data];
                    self.leftLayer.strokeColor = [UIColor clearColor].CGColor;
                }else {
                    self.rightImageView.image = [UIImage imageWithData:data];
                    self.rightLayer.strokeColor = [UIColor clearColor].CGColor;
                }
                self.leftChangeBtn.hidden = YES;
                self.leftSmallChangeBtn.hidden = NO;
            }
        }];
    }];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:kInternationalContent(@"拍摄") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[CameraHelper helper] showPickerViewControllerSourceType:UIImagePickerControllerSourceTypeCamera onViewController:self completion:^(NSError *error, NSData *data) {
            if (!error) {
                if (type == ImageTypeLeft) {
                    self.leftImageView.image = [UIImage imageWithData:data];
                    self.leftLayer.strokeColor = [UIColor clearColor].CGColor;
                }else {
                    self.rightImageView.image = [UIImage imageWithData:data];
                    self.rightLayer.strokeColor = [UIColor clearColor].CGColor;
                }
                self.leftChangeBtn.hidden = YES;
                self.leftSmallChangeBtn.hidden = NO;
            }
        }];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:kInternationalContent(@"取消") style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:cancel];
    [alert addAction:album];
    [alert addAction:camera];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark-sender touch
- (void)publishDiary {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
