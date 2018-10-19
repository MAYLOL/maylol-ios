//
//  PMLAutoScrollViewCell.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/14.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseCollectionViewCell.h"

@interface PMLAutoScrollViewCell : PMLBaseCollectionViewCell
@property (nonatomic, assign) BOOL itemSelected;
//@property (nonatomic, assign) CGFloat labelFont;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectColor;
@property (nonatomic, strong) UIFont *normalFont;
@property (nonatomic, strong) UIFont *selectFont;
@property (nonatomic, copy) NSString *itemStr;
@end
