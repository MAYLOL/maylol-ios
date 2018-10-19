//
//  PMLNickNameViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/26.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLNickNameViewController.h"

@interface PMLNickNameViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UITextField *nickNameField;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
- (IBAction)nextBtnClicked:(UIButton *)sender;

@end

@implementation PMLNickNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleLabel.text = kInternationalContent(@"填写昵称");
    _tipLabel.text = kInternationalContent(@"注册成功后，昵称不能修改");
    _nickNameField.placeholder = kInternationalContent(@"填写昵称");
    [_nextBtn setTitle:kInternationalContent(@"下一步") forState:UIControlStateNormal];
    _nextBtn.enabled = YES;
    // Do any additional setup after loading the view from its nib.
}

#pragma mark-UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //禁止输入空格
    NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    if (![string isEqualToString:tem]) {
        return NO;
    }
    if ([NSString stringWithFormat:@"%@%@",textField.text,string].length > 0) {
        self.nextBtn.enabled = YES;
        [self.nextBtn setBackgroundColor:kRedColor];
    }else {
        self.nextBtn.enabled = NO;
        [self.nextBtn setBackgroundColor:kRGBGrayColor(230)];
    }
    return YES;
}

- (IBAction)nextBtnClicked:(UIButton *)sender {
    
}
@end
