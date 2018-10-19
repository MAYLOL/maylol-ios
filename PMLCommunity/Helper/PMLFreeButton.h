//
//  PMLCustomeButton.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/16.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseButton.h"
typedef NS_ENUM(NSUInteger,PMLFreeBtnAlignment) {
    PMLFreeBtnAlignmentHorizontalLeft,
    PMLFreeBtnAlignmentHorizontalCenter,
    PMLFreeBtnAlignmentHorizontalRight,
    PMLFreeBtnAlignmentVerticalLeft,
    PMLFreeBtnAlignmentVerticalCenter,
    PMLFreeBtnAlignmentVerticalRight,
    PMLFreeBtnAlignmentVerticalFill,
};

@interface PMLFreeButton : PMLBaseButton
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) CGFloat margin;
- (void)setUpImageViewSize:(CGSize)imageSize margin:(CGFloat)margin alignment:(PMLFreeBtnAlignment)alignment;
@end
