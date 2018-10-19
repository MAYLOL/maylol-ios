//
//  PMLPublishBottomView.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/31.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseView.h"

typedef NS_ENUM(NSInteger, ClickedType) {
    ClickedTypeImage, //图片
    ClickedTypeVideo, //视频
//    ClickedTypeDraft, //草稿
//    ClickedTypeAt,    //@
    ClickedTypeSet,   //设置
    ClickedTypeArrow, //隐藏显示键盘
};

@protocol PMLPublishBottomViewDelegate<NSObject>

/**
 按钮点击代理

 @param itemType 0 图片  1 视频 2 设置  3 隐藏/显示键盘
 */
- (void)itemTouch:(int)itemType;
@end

typedef void(^PublishBottomViewBlock)(NSInteger ClickedType);

@interface PMLPublishBottomView : PMLBaseView
@property (nonatomic,weak) id<PMLPublishBottomViewDelegate> delegate;
@property (nonatomic, assign) BOOL arrowHidden;
@property (nonatomic, copy) PublishBottomViewBlock bottomViewBlock;
@end
