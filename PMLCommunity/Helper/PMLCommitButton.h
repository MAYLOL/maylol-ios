//
//  PMLCommitButton.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/26.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLBaseButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface PMLCommitButton : PMLBaseButton

/**
 enable背景颜色
 */
@property (nonatomic, strong) UIColor *normalColor;

/**
 disable背景颜色
 */
@property (nonatomic, strong) UIColor *disableColor;


/**
 enable字体颜色
 */
@property (nonatomic, strong) UIColor *normalTitleColor;

/**
 disable字体颜色
 */
@property (nonatomic, strong) UIColor *disableTitleColor;
@end

NS_ASSUME_NONNULL_END
