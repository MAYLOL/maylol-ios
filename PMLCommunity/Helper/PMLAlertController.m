//
//  PMLAlertController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/10/10.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLAlertController.h"

@implementation PMLAlertController
+ (UIAlertController *)showDefaultAlertControllerWithTitle:(NSString *)title message:(NSString *)message confirmHandler:(void (^)(UIAlertAction *action))confirmHandler cancelHandler:(void (^)(UIAlertAction *action))cancelHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:kInternationalContent(@"确定") style:UIAlertActionStyleDefault handler:confirmHandler];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:kInternationalContent(@"取消") style:UIAlertActionStyleCancel handler:cancelHandler];
    [alert addAction:confirmAction];
    [alert addAction:cancelAction];
    return alert;
}

+ (UIAlertController *)showSheetAlertControllerWithTitle:(NSString *)title message:(NSString *)message firstTitle:(NSString *)firstTitle firstHandler:(void (^)(UIAlertAction *action))firstHandler secondTitle:(NSString *)secondTitle secondHandler:(void (^)(UIAlertAction *action))secondHandler cancelHandler:(void (^)(UIAlertAction *action))cancelHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:firstTitle style:UIAlertActionStyleDefault handler:firstHandler];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:secondTitle style:UIAlertActionStyleDefault handler:secondHandler];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:kInternationalContent(@"取消") style:UIAlertActionStyleCancel handler:cancelHandler];
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    [alert addAction:cancelAction];
    return alert;
}
@end
