//
//  PMLDiaryMenuTableViewCell.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/14.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseTableViewCell.h"

typedef NS_ENUM(NSInteger,CellType) {
    Left,
    Center,
    Right,
};

@interface PMLDiaryMenuTableViewCell : PMLBaseTableViewCell
@property (nonatomic, assign) CellType type;
@end
