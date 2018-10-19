//
//  PMLLoginGeneralView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/7.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLLoginGeneralView.h"
#import "PMLBaseViewController.h"
#import "PMLFreeButton.h"

@interface PMLLoginGeneralView ()<UITextFieldDelegate>
@property (nonatomic, strong) PMLBaseLabel *welcomeLabel;
@property (nonatomic, strong) PMLBaseTextField *accountField;
@property (nonatomic, strong) PMLBaseTextField *passwordField;
@property (nonatomic, strong) PMLBaseTextField *verCodeField;
@property (nonatomic, strong) PMLBaseButton *loginBtn;
@property (nonatomic, assign) ViewType type;
@property (nonatomic, strong) PMLBaseViewController *controller;
@property (nonatomic, strong) PMLFreeButton *prefixBtn; //前缀按钮
@property (nonatomic, copy) NSString *phoneNumPrefix;//手机号码前缀
@property (nonatomic, strong) PMLBaseButton *verCodeBtn; // 验证码按钮
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger timeInter;
//记录每次发送的原始验证码
@property (nonatomic, copy) NSString *verCode;
//记录每次发送验证码时的手机号 每次点完成时需要比较当前手机号是否和发送验证码时的手机号是否一致 否则会导致可以随意更改别人的密码
@property (nonatomic, copy) NSString *phoneNum;
@end

@implementation PMLLoginGeneralView
- (instancetype)initWithFrame:(CGRect)frame type:(ViewType)type controller:(PMLBaseViewController *)controller
{
    if (self = [super initWithFrame:frame]) {
        _controller = controller;
        _type = type;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    PMLBaseLabel *welcomeLabel = [[PMLBaseLabel alloc] init];
    welcomeLabel.numberOfLines = 2;
    welcomeLabel.textColor = [UIColor colorWithHex:@"#1a1a1a"];
    [self addSubview:welcomeLabel];
    _welcomeLabel = welcomeLabel;
    [welcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(35);
        make.top.mas_equalTo(kScreenHeight * 150/1333);
    }];
    
    if (_type == RegisterWithPhoneNum) {
        PMLFreeButton *prefixBtn = [PMLFreeButton buttonWithType:UIButtonTypeCustom];
        UIImage *prefixImg =kImageWithName(@"beautiful_icon_return_gray");
        [prefixBtn setImage:prefixImg forState:UIControlStateNormal];
        [prefixBtn setTitleColor:[UIColor colorWithHex:@"#1a1a1a"] forState:UIControlStateNormal];
        prefixBtn.titleLabel.font = [UIFont customPingFMediumFontWithSize:15];
        [prefixBtn sizeToFit];
        [prefixBtn setUpImageViewSize:prefixImg.size margin:5 alignment:PMLFreeBtnAlignmentHorizontalRight];
        [prefixBtn addTarget:self action:@selector(prefixBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:prefixBtn];
        _prefixBtn = prefixBtn;
        [_prefixBtn setTitle:@"+86" forState:UIControlStateNormal];
        [prefixBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(welcomeLabel);
            make.top.equalTo(welcomeLabel.mas_bottom).offset(kScreenHeight * 90/1333);
            make.width.mas_equalTo([PMLTools sizeForString:prefixBtn.titleLabel.text font:prefixBtn.titleLabel.font maxSize:CGSizeMake(200, 200)].width + prefixImg.size.width + 5);
        }];
    }
    
    PMLBaseTextField *accountField = [[PMLBaseTextField alloc] init];
    accountField.placeholder = kInternationalContent(@"邮箱或手机号");
    accountField.borderStyle = UITextBorderStyleNone;
    if (_type == RegisterWithPhoneNum) {
        accountField.keyboardType = UIKeyboardTypeNumberPad;
    }else{
        accountField.keyboardType = UIKeyboardTypeASCIICapable;
    }
    
    accountField.font = [UIFont customPingFRegularFontWithSize:12];
    accountField.delegate = self;
    [accountField sizeToFit];
    [self addSubview:accountField];
    _accountField = accountField;
    [accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.type == RegisterWithPhoneNum) {
            make.left.equalTo(self.prefixBtn.mas_right).offset(10);
            make.bottom.equalTo(self.prefixBtn.mas_bottom);
        }else {
            make.left.equalTo(welcomeLabel);
            make.top.equalTo(welcomeLabel.mas_bottom).offset(kScreenHeight * 90/1333);
        }
        make.right.equalTo(self).offset(-35);
        
    }];
    
    PMLBaseView *accountLine = [[PMLBaseView alloc] init];
    accountLine.backgroundColor = [UIColor colorWithHex:@"#cccccc"];
    [self addSubview:accountLine];
    [accountLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(welcomeLabel);
        make.top.equalTo(accountField.mas_bottom).offset(5);
        make.right.equalTo(self).offset(-35);
        make.height.mas_equalTo(1);
    }];
    PMLBaseView *verCodeLine;
    if (self.type == RegisterWithPhoneNum) {
        PMLBaseButton *verCodeBtn = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
        verCodeBtn.layer.borderColor = [UIColor colorWithHex:@"#b3b3b3"].CGColor;
        verCodeBtn.layer.borderWidth = 1.0f;
        [verCodeBtn setTitle:kInternationalContent(@"获取验证码") forState:UIControlStateNormal];
        [verCodeBtn setTitleColor:[UIColor colorWithHex:@"#666666"] forState:UIControlStateNormal];
        verCodeBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:12];
        [verCodeBtn addTarget:self action:@selector(verCodeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:verCodeBtn];
        _verCodeBtn = verCodeBtn;
        [verCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(accountLine);
            make.width.mas_equalTo(76);
            make.height.mas_equalTo(26);
            make.top.equalTo(accountLine.mas_bottom).offset(17);
        }];
        verCodeBtn.layer.cornerRadius = 4;
        
        verCodeLine = [[PMLBaseView alloc] init];
        verCodeLine.backgroundColor = [UIColor colorWithHex:@"#cccccc"];
        [self addSubview:verCodeLine];
        [verCodeLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(accountLine);
            make.top.equalTo(verCodeBtn.mas_bottom).offset(7);
            make.height.mas_equalTo(1);
        }];
        
        PMLBaseTextField *verCodeField = [[PMLBaseTextField alloc] init];
        verCodeField.borderStyle = UITextBorderStyleNone;
        verCodeField.keyboardType = UIKeyboardTypeNumberPad;
        verCodeField.font = [UIFont customPingFRegularFontWithSize:12];
        verCodeField.placeholder = kInternationalContent(@"验证码");
        verCodeField.delegate = self;
        [verCodeField sizeToFit];
        [self addSubview:verCodeField];
        _verCodeField = verCodeField;
        [_verCodeField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(accountLine);
            make.right.equalTo(verCodeBtn.mas_left);
            make.bottom.equalTo(verCodeLine.mas_top);
        }];
        
        
    }
    
    PMLBaseTextField * passwordField = [[PMLBaseTextField alloc] init];
    passwordField.borderStyle = UITextBorderStyleNone;
    passwordField.keyboardType = UIKeyboardTypeASCIICapable;
    passwordField.secureTextEntry = YES;
    passwordField.font = [UIFont customPingFRegularFontWithSize:12];
    passwordField.delegate = self;
    [passwordField sizeToFit];
    [self addSubview:passwordField];
    _passwordField = passwordField;
    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(accountLine);
        if (self.type == RegisterWithPhoneNum) {
            make.top.equalTo(verCodeLine.mas_bottom).offset(30);
        }else{
            make.top.equalTo(accountLine.mas_bottom).offset(30);
        }
        
    }];
    
    PMLBaseView *passwordLine = [[PMLBaseView alloc] init];
    passwordLine.backgroundColor = [UIColor colorWithHex:@"#cccccc"];
    [self addSubview:passwordLine];
    [passwordLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(accountLine);
        make.top.equalTo(passwordField.mas_bottom).offset(5);
        make.height.mas_equalTo(1);
    }];
    
    PMLBaseButton *loginBtn = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    [loginBtn addTarget:self action:@selector(loginClicked) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn setBackgroundColor:[UIColor colorWithHex:@"#e6e6e6"]];
    [loginBtn setTitleColor:kRGBGrayColor(200) forState:UIControlStateDisabled];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:15];
    loginBtn.enabled = NO;
    [self addSubview:loginBtn];
    _loginBtn = loginBtn;
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(accountLine);
        make.top.equalTo(passwordLine.mas_bottom).offset(30);
        make.height.mas_equalTo(40);
    }];
    loginBtn.layer.cornerRadius = 4;
    if (_type == Login) {
        PMLBaseButton *forgetPwdBtn = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
        [forgetPwdBtn setTitle:kInternationalContent(@"忘记密码了吗？") forState:UIControlStateNormal];
        [forgetPwdBtn setTitleColor:[UIColor colorWithHex:@"#cb3340"] forState:UIControlStateNormal];
        forgetPwdBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:12];
        forgetPwdBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [forgetPwdBtn addTarget:self action:@selector(forgetBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:forgetPwdBtn];
        [forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(accountLine);
            make.top.equalTo(loginBtn.mas_bottom).offset(15);
        }];
    }
    
    PMLBaseButton *registerBtn = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    [registerBtn setTitleColor:kRedColor forState:UIControlStateNormal];
    registerBtn.titleLabel.font = [UIFont customPingFMediumFontWithSize:15];
    [registerBtn addTarget:self action:@selector(regisBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    registerBtn.layer.borderColor = kRedColor.CGColor;
    registerBtn.layer.borderWidth = 1;
    [self addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(accountLine);
        make.bottom.equalTo(self).offset(-kScreenHeight * 70/1333);
        make.height.mas_equalTo(30);
    }];
    registerBtn.layer.cornerRadius = 4;
    
    PMLBaseLabel *orLabel = [[PMLBaseLabel alloc] init];
    orLabel.textColor = [UIColor colorWithHex:@"#b3b3b3"];
    orLabel.font = [UIFont customPingFRegularFontWithSize:12];
    orLabel.text = kInternationalContent(@"或");
    [self addSubview:orLabel];
    [orLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(registerBtn.mas_top).offset(-15);
    }];
    
    PMLBaseView *leftLine = [[PMLBaseView alloc] init];
    leftLine.backgroundColor = [UIColor colorWithHex:@"#cccccc"];
    [self addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountLine);
        make.centerY.equalTo(orLabel);
        make.height.mas_equalTo(1);
        make.right.equalTo(orLabel.mas_left).offset(-10);
    }];
    
    PMLBaseView *rightLine = [[PMLBaseView alloc] init];
    rightLine.backgroundColor = [UIColor colorWithHex:@"#cccccc"];
    [self addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(accountLine);
        make.centerY.equalTo(orLabel);
        make.height.mas_equalTo(1);
        make.left.equalTo(orLabel.mas_right).offset(10);
    }];
    
    switch (_type) {
        case Login:
        {
            NSAttributedString *att = [[NSAttributedString alloc] initWithString:kInternationalContent(@"你好，\n欢迎来到MAYLOL") attributes:@{NSFontAttributeName:[UIFont customPingFSemiboldFontWithSize:24]}];
            _welcomeLabel.attributedText = att;
            accountField.placeholder = kInternationalContent(@"邮箱或手机号");
            [loginBtn setTitle:kInternationalContent(@"登录") forState:UIControlStateNormal];
            passwordField.placeholder = kInternationalContent(@"密码");
            [registerBtn setTitle:kInternationalContent(@"注册 MAYLOL 账号") forState:UIControlStateNormal];
        }
            break;
        case RegisterWithEmail:
        {
            NSAttributedString *att = [[NSAttributedString alloc] initWithString:kInternationalContent(@"邮箱注册") attributes:@{NSFontAttributeName:[UIFont customPingFSemiboldFontWithSize:24]}];
            _welcomeLabel.attributedText = att;
            accountField.placeholder = kInternationalContent(@"请输入邮箱");
            [loginBtn setTitle:kInternationalContent(@"验证邮箱") forState:UIControlStateNormal];
            passwordField.placeholder = kInternationalContent(@"密码长度6-20位");
            [registerBtn setTitle:kInternationalContent(@"使用手机号注册") forState:UIControlStateNormal];
        }
            break;
        case RegisterWithPhoneNum:
        {
            NSAttributedString *att = [[NSAttributedString alloc] initWithString:kInternationalContent(@"手机号注册") attributes:@{NSFontAttributeName:[UIFont customPingFSemiboldFontWithSize:24]}];
            _welcomeLabel.attributedText = att;
            accountField.placeholder = kInternationalContent(@"请输入手机号");
            [loginBtn setTitle:kInternationalContent(@"注册") forState:UIControlStateNormal];
            passwordField.placeholder = kInternationalContent(@"密码长度6-20位");
            [registerBtn setTitle:kInternationalContent(@"使用邮箱注册") forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
    
}

#pragma makr-UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //禁止输入空格
    NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
    if (![string isEqualToString:tem]) {
        return NO;
    }
    
    if (textField == self.passwordField) {
        if (self.passwordField.text.length >= 20 && ![string isEqualToString:@""]) {
            self.passwordField.text = [textField.text substringToIndex:20];
            return NO;
        }
    }
    
    NSString *newString;
    if ([string isEqualToString:@""]) {//如果按得是删除键
        newString = [textField.text substringToIndex:range.location];
    }else{
        newString = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    if (self.type == Login) {
        if (textField == self.accountField) {
            if (self.passwordField.text.length > 0 && [PMLTools validatePhoneNumOrEmail:newString]) {
                [self setLoginBtnSelect];
            } else {
                [self setLoginBtnDisSelect];
            }
        }
        if (textField == self.passwordField) {
            if (newString.length > 0 && [PMLTools validatePhoneNumOrEmail:self.accountField.text]) {
                [self setLoginBtnSelect];
            }else{
                [self setLoginBtnDisSelect];
            }
        }
    }
    else if (self.type == RegisterWithPhoneNum) {
        if (textField == self.verCodeField) {
            if (newString.length > 0 && [PMLTools validatePhoneNum:self.accountField.text] && self.passwordField.text.length >= 6) {
                [self setLoginBtnSelect];
            }else{
                [self setLoginBtnDisSelect];
            }
            
        }
        if (textField == self.accountField) {
            if (self.passwordField.text.length >= 6 && [PMLTools validatePhoneNum:newString] && self.verCodeField.text.length > 0) {
                [self setLoginBtnSelect];
            }else{
                [self setLoginBtnDisSelect];
            }
        }
        if (textField == self.passwordField) {
            if (newString.length >= 6 && [PMLTools validatePhoneNum:self.accountField.text] && self.verCodeField.text.length > 0)  {
                [self setLoginBtnSelect];
            }else{
                [self setLoginBtnDisSelect];
            }
        }
    }
    else {
        if (textField == self.accountField) {
            if (self.passwordField.text.length >= 6 && [PMLTools validateEmail:newString]) {
                [self setLoginBtnSelect];
            }else{
                [self setLoginBtnDisSelect];
            }
        }
        if (textField == self.passwordField) {
            if (newString.length >= 6 && [PMLTools validateEmail:self.accountField.text])  {
                [self setLoginBtnSelect];
            }else{
                [self setLoginBtnDisSelect];
            }
        }
    }
    return YES;
}

- (void)setLoginBtnDisSelect
{
    self.loginBtn.enabled = NO;
    [self.loginBtn setBackgroundColor:kRGBGrayColor(230)];
}

- (void)setLoginBtnSelect
{
    self.loginBtn.enabled = YES;
    [self.loginBtn setBackgroundColor:kRedColor];
}

#pragma mark-sender touch
- (void)loginClicked
{
    if (![PMLTools validatePhoneNumOrEmail:self.accountField.text]) {
        [_controller showHUDPureTitle:kInternationalContent(@"请输入正确的手机号或邮箱")];
        return;
    }
    
    switch (self.type) {
        case Login:
        {
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"account"] = self.accountField.text;
            params[@"passcode"] = [PMLTools RSAEncryption:self.passwordField.text];
            [PMLViewModel loginRequestWithParams:params requestType:PMLRequestPut success:^(NSURLSessionDataTask *task, id responeObject) {
                PMLUserModel *userModel = [[PMLUserModel alloc] init];
                userModel.userid = [responeObject stringForCheckedKey:@"userid"];
                userModel.name = [responeObject stringForCheckedKey:@"name"];
                [PMLUserUtility saveUserModel:userModel];
                [PMLTools writeProfileString:[responeObject stringForCheckedKey:@"accesstoken"] forKey:PMLAccessToken];
                [PMLTools writeProfileString:[responeObject stringForCheckedKey:@"refreshtoken"] forKey:PMLRefreshToken];
                [self.controller dismissViewControllerAnimated:YES completion:nil];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"%@",error);
            }];
        }
            break;
        case RegisterWithPhoneNum:
        {
            if (![self.accountField.text isEqualToString:self.phoneNum]) {
                [self.controller showHUDPureTitle:kInternationalContent(@"手机号码不一致")];
                return;
            }
            if (![PMLTools validatePhoneNum:self.accountField.text]) {
                [self.controller showHUDPureTitle:kInternationalContent(@"请输入正确的手机号")];
                return;
            }
            if (![self.verCodeField.text isEqualToString:self.verCode]) {
                [self.controller showHUDPureTitle:kInternationalContent(@"请输入正确的验证码")];
                return;
            }
            if (self.passwordField.text.length == 0) {
                [self.controller showHUDPureTitle:kInternationalContent(@"密码为空")];
                return;
            }
            if (self.passwordField.text.length < 6) {
                [self.controller showHUDPureTitle:kInternationalContent(@"密码过短")];
                return;
            }
            if (self.passwordField.text.length > 20) {
                [self.controller showHUDPureTitle:kInternationalContent(@"密码过长")];
                return;
            }
            NSMutableDictionary *prams = [NSMutableDictionary dictionary];
            prams[@"tel"] = self.phoneNum;
            prams[@"passcode"] = [PMLTools RSAEncryption:@"panchuang123"];
            prams[@"passcode2"] = [PMLTools RSAEncryption:@"panchuang123"];
            [PMLViewModel phoneRegisterWithParams:prams requestType:PMLRequestPut success:^(NSURLSessionDataTask *task, id responeObject) {
                NSLog(@"%@",responeObject);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [self.controller showHUDPureTitle:kInternationalContent(@"账号注册失败")];
            }];
        }
            break;
        case RegisterWithEmail:
        {
            
        }
            break;
        default:
            break;
    }
    
}

//忘记密码按钮
- (void)forgetBtnClicked
{
    if (self.loginGeneralBlock) {
        self.loginGeneralBlock(ForgetPwd);
    }
}
//注册按钮
- (void)regisBtnClicked
{
    if (self.loginGeneralBlock) {
        self.loginGeneralBlock(EventTypeRegister);
    }
    
}
//选择手机号前缀
- (void)prefixBtnClicked
{
    if (self.loginGeneralBlock) {
        self.loginGeneralBlock(EventTypePhonePrefix);
    }
}
//获取验证码按钮
- (void)verCodeBtnClicked
{
    if (![PMLTools validatePhoneNum:self.accountField.text]) {
        if (self.accountField.text.length == 0) {
            [self.controller showHUDPureTitle:@"请输入手机号"];
        }else {
            [self.controller showHUDPureTitle:@"请输入正确的手机号"];
        }
        return;
    }
    
    NSArray *verCodeArray = [PMLTools verifiCode];
    NSString *encryptCode = verCodeArray.lastObject;
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"phone"] = self.accountField.text;
    parms[@"code"] = encryptCode;
    [PMLViewModel sendVerCodeWithParams:parms requestType:PMLRequestPost success:^(NSURLSessionDataTask *task, id responeObject) {
        self.verCode = verCodeArray.firstObject;
        self.phoneNum = self.accountField.text;
        if (!self.timer) {
            self.timeInter = 60;
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timerMothed) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
            self.verCodeBtn.enabled = NO;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    if (self.loginGeneralBlock) {
        self.loginGeneralBlock(EventTypeVerCode);
    }
}

- (void)timerMothed
{
    _timeInter--;
    [self.verCodeBtn setTitle:[NSString stringWithFormat:@"%ld",_timeInter] forState:UIControlStateNormal];
    if (_timeInter == 0) {
        [self.timer invalidate];
        self.timer = nil;
        self.verCodeBtn.enabled = YES;
        [self.verCodeBtn setTitle:kInternationalContent(@"获取验证码") forState:UIControlStateNormal];
    }
}

#pragma mark-setter
- (void)setPrefixString:(NSString *)prefixString
{
    _prefixString = prefixString;
    [self.prefixBtn setTitle:_prefixString forState:UIControlStateNormal];
    [self.prefixBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([PMLTools sizeForString:self.prefixBtn.titleLabel.text font:self.prefixBtn.titleLabel.font maxSize:CGSizeMake(200, 200)].width + self.prefixBtn.imageView.image.size.width + 5);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
