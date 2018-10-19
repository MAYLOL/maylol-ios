//
//  PMLLeftColumnView.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/20.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseView.h"
typedef void (^ColumnViewBlock)(void);
@interface PMLLeftColumnView : PMLBaseView
@property (nonatomic, copy) ColumnViewBlock touchBlock;
- (void)show;
@end
