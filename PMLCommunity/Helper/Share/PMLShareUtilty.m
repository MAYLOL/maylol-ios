//
//  PMLShareUtilty.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/29.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLShareUtilty.h"
#import "PMLShareView.h"
#import "PMLSharePlatform.h"
#import <UMShare/UMShare.h>

static PMLShareUtilty *defaultUtility = nil;

@interface PMLShareUtilty ()<PMLShareViewDelegate>
@property (nonatomic, strong) PMLShareView *shareView;

@end

@implementation PMLShareUtilty

+ (instancetype)defaultUtility
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultUtility = [[self alloc] init];
    });
    return defaultUtility;
}
- (void)shareSetUp
{
    //关闭强制验证https，可允许http图片分享
    [UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
    /* 设置分享到QQ互联的appID
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
    /* 设置Twitter的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Twitter appKey:@"fB5tvRpna1CKK97xZUslbxiet"  appSecret:@"YcbSvseLIwZ4hZg9YmgJPP5uWzd4zr6BpBKGZhf07zzh3oj62K" redirectURL:nil];
    
    /* 设置Facebook的appKey和UrlString */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Facebook appKey:@"506027402887373" appSecret:nil redirectURL:@"http://www.umeng.com/social"];
    
}

- (void)shareWithUrl:(NSString *)url title:(NSString *)title desc:(NSString *)desc icon:(UIImage *)icon respVC:(UIViewController *)controller
{
    _shareView = [[PMLShareView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 210, kScreenWidth, 210)];
    _shareView.delegate = self;
    _shareView.shareUrl = url;
    _shareView.shareTitle = title;
    _shareView.shareDesc = desc;
    _shareView.shareImage = icon;
    _shareView.respVC = controller;
    [_shareView show];
}

//+ (void)shareWithUrl:(NSString *)url title:(NSString *)title desc:(NSString *)desc icon:(UIImage *)icon respVC:(UIViewController *)controller
//{
//    if (shareInstance == nil) {
//        shareInstance = [[PMLShareUtilty alloc] init];
//        shareInstance.shareView = [[PMLShareView alloc] initWithFrame:CGRectMake(0, kScreenHeight - 210, kScreenWidth, 210)];
//        shareInstance.shareView.delegate = shareInstance;
//    }
//    shareInstance.shareView.shareUrl = url;
//    shareInstance.shareView.shareTitle = title;
//    shareInstance.shareView.shareDesc = desc;
//    shareInstance.shareView.shareImage = icon;
//    shareInstance.shareView.respVC = controller;
//    [shareInstance.shareView show];
//}

- (void)shareViewPlatformBtnClickWithPlatform:(NSInteger)platformName shareTitle:(NSString *)title shareUrl:(NSString *)url shareDesc:(NSString *)desc shareImage:(UIImage *)image respondVC:(UIViewController *)shareVC
{
    [_shareView hidden];
    switch (platformName) {
        case WXSession:
        {
            
        }
            break;
            
        case WXTimeLine:
        {
            
        }
            break;
        case QQ:
        {
            
        }
            break;
        case QQZone:
        {
            
        }
            break;
        case Sina:
        {
            
        }
            break;
        case Facebook:
        {
            
        }
            break;
        case Twitter:
        {
            
        }
            break;
        case Instagram:
        {
            
        }
            break;
        case LINE:
        {
            
        }
            break;
        case KaokaoTalk:
        {
            
        }
            break;

        default:
            break;
    }
}
@end
