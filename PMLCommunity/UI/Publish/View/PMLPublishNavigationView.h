//
//  PMLPublishNavigationView.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/31.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseView.h"

//typedef NS_ENUM (NSInteger, ClickType) {
//    ClickTypeCancel,
//    ClickTypePublish,
//};
//
//typedef void(^PublishNavigationViewBlock)(NSInteger type);

@protocol PMLPublishNavigationViewDelegate<NSObject>
@required
/**
 发布页面导航栏代理

 @param type 0 dismiss  1 发布
 */
- (void)topItemTouchWithType:(int)type;
@end

@interface PMLPublishNavigationView : PMLBaseView
@property (nonatomic, weak) id<PMLPublishNavigationViewDelegate> delegate;
//@property (nonatomic, copy) PublishNavigationViewBlock navigationViewBlock;
@end
