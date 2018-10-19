//
//  PMLCancelAccountFinishViewController.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/9.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLCancelAccountFinishViewController.h"
#import "PMLCancelAccountFinishView.h"
#import "PMLSettingViewController.h"
#import "UIViewController+PMLViewController.h"

@interface PMLCancelAccountFinishViewController ()
@property (nonatomic, strong)PMLCancelAccountFinishView *finishView;

@end

@implementation PMLCancelAccountFinishViewController

- (void)loadView {
    _finishView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PMLCancelAccountFinishView class]) owner:nil options:nil].firstObject;
    self.view = _finishView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavLeftButton:nil];
    [self setUpTitleViewWithText:kInternationalContent(@"注销账号") showLine:NO];
    [self setup];
}

- (void)setup{
    typeof(self) __weak weakSelf = self;
    self.finishView.clickAction = ^{
        typeof(weakSelf) __strong strongSelf = weakSelf;
        [strongSelf popToViewControllerClass:[PMLSettingViewController class] animated:true];
    };
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
