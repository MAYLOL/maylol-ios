//
//  PMLLoginViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/7.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLLoginViewController.h"
#import "PMLRegisterViewController.h"
#import "PMLLoginGeneralView.h"
#import "PMLForgetViewController.h"

@interface PMLLoginViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) PMLLoginGeneralView *loginView;
@end

@implementation PMLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [kNotificationCenter addObserver:self selector:@selector(rigisterSuccess) name:PMLRegisterSucess object:nil];
    [self addNavLeftButton:@"login_left_arrow"];
    [self setupSubViews];
    // Do any additional setup after loading the view.
}

- (void)setupSubViews
{
    self.loginView = [[PMLLoginGeneralView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.size.height - kNavBarHeight) type:Login controller:self];
    WeakSelf(weakSelf);
    self.loginView.loginGeneralBlock = ^(NSInteger eventType) {
        switch (eventType) {
            case EventTypeRegister:
            {
                [weakSelf.navigationController pushViewController:[[PMLRegisterViewController alloc] initWithRegisterType:RegisterWithPhoneNum] animated:YES];
            }
                break;
            case EventTypeVerCode:
            {
                
            }
                break;
            case ForgetPwd:
            {
          [weakSelf.navigationController pushViewController:[PMLForgetViewController new] animated:true];
            }
                break;
            default:
                break;
        }
    };
    [self.view addSubview:self.loginView];
}

- (void)navLeftButtonClick {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
