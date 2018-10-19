//
//  PMLLoginGeneralView.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/7.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseView.h"
@class PMLBaseViewController;
typedef NS_ENUM(NSInteger,ViewType) {
    Login, //登陆页面
    RegisterWithEmail,//邮箱注册页面
    RegisterWithPhoneNum, //手机号码注册页面
    ForgetPwd, //重置密码页面
};

typedef NS_ENUM(NSInteger, EventType) {
    EventTypeRegister, //手机&邮箱注册按钮
    EventTypePhonePrefix, // 手机号码前缀
    EventTypeVerCode,  // 验证码按钮
};

typedef void(^LoginGeneralViewBlock)(NSInteger eventType);
@interface PMLLoginGeneralView : PMLBaseView
@property (nonatomic, copy) NSString *prefixString;
@property (nonatomic, copy) LoginGeneralViewBlock loginGeneralBlock;
- (instancetype)initWithFrame:(CGRect)frame type:(ViewType)type controller:(PMLBaseViewController *)controller;
@end
