//
//  UIViewController+PMLViewController.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/28.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "UIViewController+PMLViewController.h"

@implementation UIViewController(PMLViewController)

- (void)popToViewControllerClass:(Class)viewControllerClass animated:(BOOL)animated {
    UIViewController *targetVC;
    for (UIViewController *vc in self.navigationController.childViewControllers) {
        if ([vc isKindOfClass:viewControllerClass]) {
            targetVC = vc;
            [self.navigationController popToViewController:vc animated:true];
        }
    }
    if (![targetVC isKindOfClass:viewControllerClass]){
        [self.navigationController popToRootViewControllerAnimated:true];
    }
}

@end
