//
//  PMLShareView.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/28.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseView.h"

@protocol PMLShareViewDelegate <NSObject>
@required
- (void)shareViewPlatformBtnClickWithPlatform:(NSInteger)platformName shareTitle:(NSString *)title shareUrl:(NSString *)url shareDesc:(NSString *)desc shareImage:(UIImage *)image respondVC:(UIViewController *)shareVC;
@end

@interface PMLShareView : PMLBaseView
@property (nonatomic,weak) id<PMLShareViewDelegate> delegate;
/** 分享的地址 */
@property (nonatomic, copy) NSString *shareUrl;
/** 分享的标题 */
@property (nonatomic, copy) NSString *shareTitle;
/** 分享的描述 */
@property (nonatomic, copy) NSString *shareDesc;
/** 分享的图片 */
@property (nonatomic, strong) UIImage *shareImage;
/** 响应的vc */
@property (nonatomic, strong) UIViewController *respVC;


- (void)show;
- (void)hidden;
@end
