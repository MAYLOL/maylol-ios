//
//  PMLSelectCoverViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/19.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLSelectCoverViewController.h"
#import "CameraHelper.h"

@interface PMLSelectCoverViewController ()
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) PMLFreeButton *changeCoverBtn;
@property (nonatomic, strong) PMLBaseButton *smallChangeBtn;
@end

@implementation PMLSelectCoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTitleViewWithText:kInternationalContent(@"选择封面") showLine:NO];
    [self setupNavItem];
    [self setupSubViews];
    // Do any additional setup after loading the view.
}

- (void)setupNavItem {
    PMLBaseButton *leftItem = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    [leftItem setTitle:kInternationalContent(@"取消") forState:UIControlStateNormal];
    [leftItem setTitleColor:kRGBGrayColor(101) forState:UIControlStateNormal];
    [leftItem sizeToFit];
    leftItem.titleLabel.font = [UIFont customPingFRegularFontWithSize:15];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItem];
    
    PMLBaseButton *rightItem = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    [rightItem setTitle:kInternationalContent(@"发布") forState:UIControlStateNormal];
    [rightItem setTitleColor:kRGBColor(225, 25, 100) forState:UIControlStateNormal];
    [rightItem sizeToFit];
    rightItem.titleLabel.font = [UIFont customPingFRegularFontWithSize:15];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
}

- (void)setupSubViews {
    _coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, kScreenWidth - 30, (kScreenWidth - 15) * 200/345)];
    _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    _coverImageView.clipsToBounds = YES;
    [self.view addSubview:_coverImageView];
    
    _changeCoverBtn = [PMLFreeButton buttonWithType:UIButtonTypeCustom];
    [_changeCoverBtn sizeToFit];
    [_changeCoverBtn setTitle:kInternationalContent(@"点击上传文章封面") forState:UIControlStateNormal];
    [_changeCoverBtn setTitleColor:kRGBGrayColor(204) forState:UIControlStateNormal];
    _changeCoverBtn.titleLabel.font = [UIFont customPingFMediumFontWithSize:13];
    _changeCoverBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    UIImage *defaultImage = kImageWithName(@"release_btn_photo");
    [_changeCoverBtn setImage:defaultImage forState:UIControlStateNormal];
    [_changeCoverBtn setUpImageViewSize:defaultImage.size margin:15 alignment:PMLFreeBtnAlignmentVerticalCenter];
    [_changeCoverBtn addTarget:self action:@selector(changeCoverImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_changeCoverBtn];
    _changeCoverBtn.frame = CGRectMake(15, 50, kScreenWidth - 30, (kScreenWidth - 15) * 200/345);
    
    _smallChangeBtn = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    [_smallChangeBtn setTitle:kInternationalContent(@"更换") forState:UIControlStateNormal];
    [_smallChangeBtn setTitleColor:kRGBGrayColor(230) forState:UIControlStateNormal];
    _smallChangeBtn.titleLabel.font = [UIFont customPingFMediumFontWithSize:15];
    [_smallChangeBtn addTarget:self action:@selector(changeCoverImage) forControlEvents:UIControlEventTouchUpInside];
    _smallChangeBtn.backgroundColor = kRGBGrayColor(76);
    _smallChangeBtn.alpha = 0.7;
    _smallChangeBtn.layer.cornerRadius = 5;
    _smallChangeBtn.hidden = YES;
    [self.view addSubview:_smallChangeBtn];
    [_smallChangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.coverImageView).offset(-10);
        make.top.equalTo(self.coverImageView).offset(10);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(25);
    }];
}

- (void)changeCoverImage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:kInternationalContent(@"更换封面") message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *album = [UIAlertAction actionWithTitle:kInternationalContent(@"相册") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[CameraHelper helper] showPickerViewControllerSourceType:UIImagePickerControllerSourceTypePhotoLibrary onViewController:self completion:^(NSError *error, NSData *data) {
            if (!error) {
                self.changeCoverBtn.hidden = YES;
                self.smallChangeBtn.hidden = NO;
                self.coverImageView.image = [UIImage imageWithData:data];
            }
            
        }];
    }];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:kInternationalContent(@"拍摄") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[CameraHelper helper] showPickerViewControllerSourceType:UIImagePickerControllerSourceTypeCamera onViewController:self completion:^(NSError *error, NSData *data) {
            if (!error) {
                self.changeCoverBtn.hidden = YES;
                self.smallChangeBtn.hidden = NO;
                self.coverImageView.image = [UIImage imageWithData:data];
            }
        }];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:kInternationalContent(@"取消") style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:cancel];
    [alert addAction:album];
    [alert addAction:camera];
    [self presentViewController:alert animated:YES completion:nil];
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
