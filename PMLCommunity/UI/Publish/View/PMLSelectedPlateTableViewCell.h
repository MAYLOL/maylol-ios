//
//  PMLSelectedPlateTableViewCell.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/25.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PMLSelectedPlateTableViewCell : PMLBaseTableViewCell
@property (nonatomic, assign) BOOL showLine;
@property (nonatomic, copy) NSString *content;
@end

NS_ASSUME_NONNULL_END
