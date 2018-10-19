//
//  PMLNavigationViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseNavigationViewController.h"

@interface PMLBaseNavigationViewController ()

@end

@implementation PMLBaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//- (void)setTitle:(NSString *)title {
//    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.font = [UIFont systemFontOfSize:15];
//    titleLabel.textColor = [UIColor blackColor];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    [titleLabel sizeToFit];
//    self.navigationItem.titleView = titleLabel;
//}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    // 修改tabBra的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
