//
//  PMLPersonalCenterHeaderView.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/22.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseView.h"

typedef NS_ENUM(NSInteger, HeaderViewTouchType) {
    HeaderViewTouchWallet,
    HeaderViewTouchFocus,
    HeaderViewTouchFans,
    HeaderViewTouchEditInfo,
};

typedef void(^HeaderViewTouchBlock)(HeaderViewTouchType type);

@interface PMLPersonalCenterHeaderView : PMLBaseView
@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, copy) HeaderViewTouchBlock headerViewTouchBlock;
@end
