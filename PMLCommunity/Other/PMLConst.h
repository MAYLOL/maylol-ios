//
//  PMLConst.h
//  PMLCommunity
//
//  Created by panchuang on 2018/10/11.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>

//通知名称
UIKIT_EXTERN NSString *const PMLRegisterSucess;

//每次请求多少条数据
UIKIT_EXTERN NSInteger const PMLPageSize;

//网络请求基地址
UIKIT_EXTERN NSString *const PMLBaseUrl;
UIKIT_EXTERN NSString *const PMLSMSCodeURL;

//加密公钥
UIKIT_EXTERN NSString *const PMLPublicKey;

//AES256加密KEY
UIKIT_EXTERN NSString *const PMLAES256Key;

//登陆凭证
UIKIT_EXTERN NSString *const PMLAccessToken;
UIKIT_EXTERN NSString *const PMLRefreshToken;

//第三方appkey
UIKIT_EXTERN NSString *const PMLWXAppId;
UIKIT_EXTERN NSString *const PMLWXAppSecret;
UIKIT_EXTERN NSString *const PMLQQAppId;
UIKIT_EXTERN NSString *const PMLSinaAppId;
UIKIT_EXTERN NSString *const PMLWBRedirecturi;

UIKIT_EXTERN NSString *const PMLAliPayScheme;
UIKIT_EXTERN NSString *const PMLAliPayAppId;
//支付宝私钥 商户实际支付过程中参数需要放置在服务端，且整个签名过程必须在服务端进行
UIKIT_EXTERN NSString *const PMLAliPayPrivateKey;
