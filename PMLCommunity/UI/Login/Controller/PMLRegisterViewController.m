//
//  PMLRegisterViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/7.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLRegisterViewController.h"
#import "PMLPhonePrefixViewController.h"

@interface PMLRegisterViewController ()
@property (nonatomic, assign) ViewType type;
@property (nonatomic, strong) PMLLoginGeneralView *registerView;
@end

@implementation PMLRegisterViewController
- (instancetype)initWithRegisterType:(ViewType)type
{
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:@"login_left_arrow"];
    [self setupSubViews];
    // Do any additional setup after loading the view.
}

- (void)setupSubViews
{
    PMLLoginGeneralView *registerView = [[PMLLoginGeneralView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.size.height - kNavBarHeight) type:_type controller:self];
    WeakSelf(weakSelf);
    registerView.loginGeneralBlock = ^(NSInteger eventType) {
        switch (eventType) {
            case EventTypeRegister:
            {
                if (weakSelf.type == RegisterWithEmail) {
                    //如果当前页面是手机号注册页面
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }else{
                    //如果当前页面是邮箱注册页面
                    [weakSelf.navigationController pushViewController:[[PMLRegisterViewController alloc] initWithRegisterType:RegisterWithEmail] animated:YES];
                }
            }
                break;
            case EventTypeVerCode:
            {

            }
                break;
            case EventTypePhonePrefix:
            {
                PMLPhonePrefixViewController *prefixVC = [[PMLPhonePrefixViewController alloc] initWithResult:^(BOOL cancel, NSString *zone, NSString *countryName) {
                    weakSelf.registerView.prefixString = zone;
                }];
                [self.navigationController pushViewController:prefixVC animated:YES];
            }
                break;
            default:
                break;
        }
    };
    [self.view addSubview:registerView];
    _registerView = registerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
