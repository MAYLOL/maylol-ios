//
//  PMLFillInfoHeaderView.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/26.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLBaseView.h"

typedef void(^HeaderBlock)(void);

@interface PMLFillInfoHeaderView : PMLBaseView
@property (nonatomic, weak) UIViewController *controller;
@property (nonatomic, strong, readonly) UIImage *iconImage;
@property (nonatomic, copy) HeaderBlock headerBlock;
@end
