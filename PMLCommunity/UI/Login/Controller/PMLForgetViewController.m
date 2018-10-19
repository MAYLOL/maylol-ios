//
//  PMLForgetViewController.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/11.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLForgetViewController.h"
#import "PMLGetCodeButton.h"
#import "PMLPhonePrefixViewController.h"

@interface PMLForgetViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *changePWDLabel;//重置密码

@property (weak, nonatomic) IBOutlet UIButton *findPhoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *findEmailBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@property (weak, nonatomic) IBOutlet UIButton *phoneNumberBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *verifyField;
@property (weak, nonatomic) IBOutlet PMLGetCodeButton *getcodeBtn;

@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (weak, nonatomic) IBOutlet UIButton *emailFinishBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerXConstraints;
//记录每次发送的原始验证码
@property (nonatomic, copy) NSString *verCode;
//记录每次发送验证码时的手机号 每次点完成时需要比较当前手机号是否和发送验证码时的手机号是否一致 否则会导致可以随意更改别人的密码
@property (nonatomic, copy) NSString *phoneNum;
@end

@implementation PMLForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.changePWDLabel.text = kInternationalContent(@"重置密码");
    // Do any additional setup after loading the view from its nib.
    if (self.isSetting){
        [self addNavLeftButton:nil];
        [self setUpTitleViewWithText:kInternationalContent(@"重置密码") showLine:NO];
    } else {
        [self addNavLeftButton:@"login_left_arrow"];
    }

    [self setup];
}

- (void)setup {
    self.findPhoneBtn.selected = true;
    [self.findPhoneBtn setTitle:kInternationalContent(@"手机找回") forState:UIControlStateNormal];
    self.findEmailBtn.selected = false;
    [self.findEmailBtn setTitle:kInternationalContent(@"邮箱找回") forState:UIControlStateNormal];
    self.getcodeBtn.layer.borderWidth = 1;
    self.getcodeBtn.layer.borderColor = [UIColor colorWithHex:@"#D7D7D7"].CGColor;
    self.getcodeBtn.layer.masksToBounds = true;
    self.getcodeBtn.layer.cornerRadius = 5;
    self.getcodeBtn.isOK = true;
    self.getcodeBtn.backColor = [UIColor colorWithHex:@"#666666"];
    self.getcodeBtn.clickColor = [UIColor colorWithHex:@"#666666"];

    self.emailField.delegate = self;
    self.verifyField.delegate = self;
    self.phoneField.delegate = self;
    self.pwdField.delegate = self;

    [self.phoneNumberBtn addTarget:self action:@selector(switchZoneNumber:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.findPhoneBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.findEmailBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    //获取验证码
    [self.getcodeBtn addTarget:self action:@selector(clickCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.finishBtn addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside]
    ;
    [self.emailFinishBtn addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)finishAction:(UIButton *)sender {
    if (self.findPhoneBtn.selected) {
        if ([self.phoneField.text isEqualToString:self.phoneNum]) {
            [self showHUDPureTitle:kInternationalContent(@"手机号码不一致")];
            return;
        }
        if ([self.verifyField.text isEqualToString:self.verCode]) {
            [self showHUDPureTitle:kInternationalContent(@"验证码不正确")];
            return;
        }
        NSMutableDictionary *prams = [NSMutableDictionary dictionary];
        prams[@"tel"] = self.phoneNum;
        prams[@"passcode"] = [PMLTools RSAEncryption:self.pwdField.text];
        prams[@"passcode2"] = [PMLTools RSAEncryption:self.pwdField.text];
        [PMLViewModel modifyPwdByPhoneWithParams:prams requestType:PMLRequestPut success:^(NSURLSessionDataTask *task, id responeObject) {
            [self showHUDPureTitle:kInternationalContent(@"密码修改成功")];
            [self.navigationController popViewControllerAnimated:true];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self showHUDPureTitle:kInternationalContent(@"请求失败")];
        }];
    }else {
        if (![PMLTools validatePhoneNumOrEmail:self.emailField.text]) {
            return;
        }
        NSMutableDictionary *prams = [NSMutableDictionary dictionary];
        prams[@"email"] = self.emailField.text;
        [PMLViewModel modifyPwdByEmailWithParams:prams requestType:PMLRequestPut success:^(NSURLSessionDataTask *task, id responeObject) {
            [self showHUDPureTitle:kInternationalContent(@"修改链接已发送至邮箱")];
            [self.navigationController popViewControllerAnimated:true];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self showHUDPureTitle:kInternationalContent(@"请求失败")];
        }];
    }
    
}

- (void)switchAction:(UIButton *)sender {
    if ((sender == self.findPhoneBtn && self.findPhoneBtn.selected) || (sender == self.findEmailBtn && self.findEmailBtn.selected)){
        return;
    }
    self.findPhoneBtn.selected = !self.findPhoneBtn.selected;
    self.findEmailBtn.selected = !self.findEmailBtn.selected;
    if(self.findPhoneBtn.selected) {
        [UIView animateWithDuration:0.5 animations:^{
            self.bottomLine.centerX = self.findPhoneBtn.centerX;
            self.centerXConstraints.constant = 0;
        }];
        [self.scrollView setContentOffset:CGPointMake(0, 0)];
    } else {
        [UIView animateWithDuration:0.5 animations:^{
            self.bottomLine.centerX = self.findEmailBtn.centerX;
            self.centerXConstraints.constant = self.findEmailBtn.centerX - self.findPhoneBtn.centerX;
        }];
        [self.scrollView setContentOffset:CGPointMake(kScreenWidth, 0)];
    }
}

//发送验证码
- (void)clickCodeAction:(PMLGetCodeButton *)sender {
    if (![PMLTools validatePhoneNum:self.phoneField.text]) {
        return;
    }
    NSArray *verCodeArray = [PMLTools verifiCode];
    NSString *encryptCode = verCodeArray.lastObject;
    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
    prams[@"phone"] = self.phoneField.text;
    prams[@"code"] = encryptCode;
    [PMLViewModel sendVerCodeWithParams:prams requestType:PMLRequestPost success:^(NSURLSessionDataTask *task, id responeObject) {
        self.verCode = verCodeArray.firstObject;
        self.phoneNum = self.phoneField.text;
        [sender click];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (void)switchZoneNumber:(UIButton *)sender {
    typeof(self) __weak weakSelf = self;
    PMLPhonePrefixViewController *prefixVC = [[PMLPhonePrefixViewController alloc] initWithResult:^(BOOL cancel, NSString *zone, NSString *countryName) {
        [weakSelf.phoneNumberBtn setTitle:zone forState:UIControlStateNormal];
    }];
    [self.navigationController pushViewController:prefixVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma makr-UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //禁止输入空格
    NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    if (![string isEqualToString:tem]) {
        return NO;
    }

    if (textField == self.pwdField) {
        if (self.pwdField.text.length >= 20 && ![string isEqualToString:@""]) {
            self.pwdField.text = [textField.text substringToIndex:20];
            return NO;
        }
    }

    NSString *newString;
    if ([string isEqualToString:@""]) {//如果按得是删除键
        newString = [textField.text substringToIndex:range.location];
    }else{
        newString = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    if (self.findPhoneBtn.selected) {
        if (textField == self.pwdField) {
            if (newString.length >= 6 && [PMLTools validatePhoneNumOrEmail:self.phoneField.text] && [self judgeVerfyCode]) {
                [self setPhoneFinishBtnSelect];
            }else {
                [self setPhoneFinishBtnDisSelect];
            }
        }
        if (textField == self.verifyField) {
            if (newString.length > 0 && [PMLTools validatePhoneNum:self.phoneField.text] && self.pwdField.text.length >= 6) {
                [self setPhoneFinishBtnSelect];
            }else{
                [self setPhoneFinishBtnDisSelect];
            }
        }
        
        if (textField == self.phoneField) {
            if (self.pwdField.text.length >= 6 && [PMLTools validatePhoneNum:newString] && [self judgeVerfyCode]) {
                [self setPhoneFinishBtnSelect];
            }else{
                [self setPhoneFinishBtnDisSelect];
            }
        }
    }

    if (self.findEmailBtn.selected) {
        if ([PMLTools validatePhoneNumOrEmail:newString]){
            [self setEmailFinishBtnSelect];
        } else {
            [self setEmailFinishBtnDisSelect];
        }
    }
    return YES;
}


- (void)setPhoneFinishBtnDisSelect
{
    self.finishBtn.enabled = NO;
    [self.finishBtn setBackgroundColor:kRGBGrayColor(230)];
    [self.finishBtn setTitleColor:[UIColor colorWithHex:@"#CCCCCC"] forState:UIControlStateNormal];

}

- (void)setPhoneFinishBtnSelect
{
    self.finishBtn.enabled = YES;
    [self.finishBtn setBackgroundColor:kRedColor];
    [self.finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)setEmailFinishBtnDisSelect
{
    self.emailFinishBtn.enabled = NO;
    [self.emailFinishBtn setBackgroundColor:kRGBGrayColor(230)];
    [self.emailFinishBtn setTitleColor:[UIColor colorWithHex:@"#CCCCCC"] forState:UIControlStateNormal];
}

- (void)setEmailFinishBtnSelect
{
    self.emailFinishBtn.enabled = YES;
    [self.emailFinishBtn setBackgroundColor:kRedColor];
    [self.emailFinishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (BOOL)judgeVerfyCode {
    if (self.verifyField.text.length > 0){
        return true;
    }
    return false;
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
