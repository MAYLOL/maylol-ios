//
//  PMLAlertController.h
//  PMLCommunity
//
//  Created by panchuang on 2018/10/10.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMLAlertController : NSObject
+ (UIAlertController *)showDefaultAlertControllerWithTitle:(NSString *)title message:(NSString *)message confirmHandler:(void (^)(UIAlertAction *action))confirmHandler cancelHandler:(void (^)(UIAlertAction *action))cancelHandler;

+ (UIAlertController *)showSheetAlertControllerWithTitle:(NSString *)title message:(NSString *)message firstTitle:(NSString *)firstTitle firstHandler:(void (^) (UIAlertAction *action))firstHandler secondTitle:(NSString *)secondTitle secondHandler:(void (^)(UIAlertAction *action))secondHandler cancelHandler:(void (^)(UIAlertAction *action))cancelHandler;
@end

