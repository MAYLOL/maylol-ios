//
//  PMLPublishArticleViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/31.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLPublishArticleViewController.h"
#import "PMLPublishNavigationView.h"
#import "PMLPublishBottomView.h"
#import "PMLTextAttachment.h"
#import "PMLBaseTextView.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import "PMLCommunity-Swift.h"
#import <Aztec/Aztec-Swift.h>
//#import <>

@interface PMLPublishArticleViewController ()<UITextViewDelegate,UIScrollViewDelegate,TZImagePickerControllerDelegate>
//@property (nonatomic, assign) NSRange pickerImageRange; //记录选择图片时的位置
@property (nonatomic, strong) PMLPublishBottomView *bottomToolBar;
@property (nonatomic, strong) TextView *richTextView;
@property (nonatomic, strong) NSMutableArray *selectedAssets;
@property (nonatomic, strong) NSMutableArray *selectedPhotos;
//及时记录变化的内容
@property (nonatomic, strong) NSMutableAttributedString *locationStr;
@end

@implementation PMLPublishArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [kNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [kNotificationCenter addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    [self setupNativeBar];
    
//    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(popView)]];
    // Do any additional setup after loading the view.
}

//- (void)popView
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
}

//把最新内容都赋给self.locationStr
-(void)setInitLocation
{
    self.locationStr=nil;
    self.locationStr=[[NSMutableAttributedString alloc]initWithAttributedString:self.richTextView.attributedText];
    if (self.richTextView.textStorage.length>0) {
//        self.placeholderLabel.hidden=YES;
    }
}

-(void)setupNativeBar {
    
    PMLPublishNavigationView *navigationView = [[PMLPublishNavigationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarHeight)];
    WeakSelf(weakSelf);
//    navigationView.navigationViewBlock = ^(NSInteger type) {
//        switch (type) {
//            case ClickTypeCancel:
//            {
//                if ([weakSelf.richTextView isFirstResponder]) {
//                    [weakSelf.richTextView resignFirstResponder];
//                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [weakSelf dismissViewControllerAnimated:YES completion:nil];
//                    });
//                }else{
//                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
//                }
//            }
//                break;
//            case ClickTypePublish:
//            {
//                
//            }
//                break;
//            default:
//                break;
//        }
//    };
    [self.view addSubview:navigationView];
    
    PMLPublishBottomView *bottomToolBar = [[PMLPublishBottomView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 40, kScreenWidth, 40)];
    bottomToolBar.bottomViewBlock = ^(NSInteger ClickedType) {
        switch (ClickedType) {
            case ClickedTypeImage:
            {
//                weakSelf.pickerImageRange = weakSelf.richTextView.selectedRange;
                NSLog(@"图片");
                [weakSelf.richTextView resignFirstResponder];
                [weakSelf pushImagePickViewConyroller:ClickedTypeImage];
//                TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:weakSelf];
//                [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, PHAsset *asset) {
//                    NSLog(@"%@",coverImage);
//                    NSLog(@"%@",asset);
//                }];
//                [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//                    for (UIImage *image in photos) {
//                        [weakSelf setImageText:image withRange:weakSelf.pickerImageRange appenReturn:YES];
//                    }
//                }];
//                [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
            }
                break;
            case ClickedTypeVideo:
            {
                [weakSelf pushImagePickViewConyroller:ClickedTypeVideo];
            }
                break;
            case ClickedTypeSet:
            {
                NSLog(@"设置");
            }
                break;
            case ClickedTypeArrow:
            {
                if (weakSelf.bottomToolBar.arrowHidden) {
                    [weakSelf.richTextView becomeFirstResponder];
                }else{
                    [weakSelf.richTextView resignFirstResponder];
                }
                weakSelf.bottomToolBar.arrowHidden = !weakSelf.bottomToolBar.arrowHidden;
                NSLog(@"隐藏显示");
            }
                break;
            default:
                break;
        }
    };
    [self.view addSubview:bottomToolBar];
    self.bottomToolBar = bottomToolBar;
    self.richTextView = [[TextView alloc] initWithDefaultFont:[UIFont systemFontOfSize:15] defaultParagraphStyle:ParagraphStyle.defaultParagraphStyle defaultMissingImage:kImageWithName(@"home_suspension_icon")];
    UIMenuController.sharedMenuController.menuItems = @[];
    
//    self.textView = [[PMLBaseTextView alloc] init];
    self.richTextView.delegate = self;
    [self.richTextView becomeFirstResponder];
//    self.textView.placeholder = @"请填写内容";
    [self.view addSubview:self.richTextView];

    [self.richTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(navigationView.mas_bottom).offset(10);
        make.bottom.equalTo(bottomToolBar.mas_top);
    }];
    
}

- (void)pushImagePickViewConyroller:(ClickedType)type
{
    TZImagePickerController *imagePickVC = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickVC.selectedAssets = self.selectedAssets;
    imagePickVC.videoMaximumDuration = 2 * 60; //单位：秒
    
    [imagePickVC setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }];
    imagePickVC.showPhotoCannotSelectLayer = YES;
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 30;
    NSInteger widthHeight = self.view.width - 2 * left;
    NSInteger top = (self.view.height - widthHeight) / 2;
    imagePickVC.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    if (ClickedTypeImage == type) {
        imagePickVC.allowTakeVideo = NO;
        imagePickVC.allowTakePicture = YES;
        imagePickVC.allowPickingImage = YES;
        imagePickVC.allowPickingVideo = NO;
        WeakSelf(weakSelf);
        [imagePickVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            UIImage *image = photos[0];
            [weakSelf insterImage:image];
        }];
    }else {
        imagePickVC.allowTakeVideo = YES;
        imagePickVC.allowTakePicture = NO;
        imagePickVC.allowPickingImage = NO;
        imagePickVC.allowPickingVideo = YES;
        [imagePickVC setDidFinishPickingVideoHandle:^(UIImage *coverImage, PHAsset *asset) {
            
        }];
    }
    [self presentViewController:imagePickVC animated:YES completion:nil];
}

- (void)insterImage:(UIImage *)image
{
//    ImageAttachment *attachment = [self.richTextView replaceWithImageAt:self.richTextView.selectedRange sourceURL:nil placeHolderImage:image identifier:nil];
//    self.richTextView.textStorage.editedRange
//    attachment.ali
//    int a = [self.richTextView adjusind];
//    [self.richTextView remo];
//    [self.richTextView replaceWithImage:richTextView.selectedRange sourceURL:nil placeHolderImage:image];
//    ImageAttachment *attachment = [self.richTextView replace];
}

////设置图片
//- (void)setImageText:(UIImage *)img withRange:(NSRange)range appenReturn:(BOOL)appen
//{
//    if (nil == img) {
//        return;
//    }
//    if (![img isKindOfClass:[UIImage class]]) {
//        return;
//    }
//    UIImage *image = img;
//
//    CGFloat imgWidth = 0;
//    CGFloat imgHeight = 0;
//    if (image.size.width > (kScreenWidth - 10)) {
//        imgHeight = image.size.height * (kScreenWidth - 10)/image.size.width;
//        imgWidth = kScreenWidth - 10;
//    }
//
//    PMLTextAttachment *textAttachment = [[PMLTextAttachment alloc] init];
//    textAttachment.imageFlag = kRichTextImageFlag;
//    textAttachment.image = image;
//    textAttachment.imageSize = CGSizeMake(imgWidth, imgHeight);
//
//    if (appen) {
//        NSAttributedString *imageAtt = [self appendReturn:[NSAttributedString attributedStringWithAttachment:textAttachment]];
//        [self.textView.textStorage insertAttributedString:imageAtt atIndex:range.location];
//    }else{
//        if (_textView.textStorage.length>0) {
//            //replace image image-二次编辑
//            [self.textView.textStorage replaceCharactersInRange:range withAttributedString:[NSAttributedString attributedStringWithAttachment:textAttachment]];
//        }
//    }
//    self.textView.selectedRange = NSMakeRange(range.location + 1, range.length);
//    //设置locationStr的设置
//    [self setInitLocation];
//}
//
//#pragma mark - 添加图片的时候前后自动换行
//-(NSAttributedString *)appendReturn:(NSAttributedString*)imageStr
//{
//    NSAttributedString * returnStr=[[NSAttributedString alloc]initWithString:@"\n"];
//    NSMutableAttributedString * att=[[NSMutableAttributedString alloc]initWithAttributedString:imageStr];
//    for (int i = 0 ; i < 3; i++) {
//        [att appendAttributedString:returnStr];
//    }
//    [att insertAttributedString:returnStr atIndex:0];
//    return att;
//}


#pragma mark-UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.bottomToolBar.arrowHidden = NO;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //[text isEqualToString:@""] 表示输入的是退格键
    if (![text isEqualToString:@""]) {
//        self.textView.showPlaceholder = YES;
    }
    //range.location == 0 && range.length == 1 表示输入的是第一个字符
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1) {
//        self.textView.showPlaceholder = NO;
    }
    return YES;
}


#pragma mark-keyboardAnimation
- (void)keyboardWillShow:(NSNotification *)notify
{
    //键盘高度
    CGFloat height = [[[notify userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //取得键盘的动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.bottomToolBar.bottom = kScreenHeight - height;
    }];
}

- (void)keyboardWillHidden:(NSNotification *)notify
{
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.bottomToolBar.bottom = kScreenHeight;
    }];
}

#pragma mark-sender touch

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"%@------%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    [kNotificationCenter removeObserver:self];
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
