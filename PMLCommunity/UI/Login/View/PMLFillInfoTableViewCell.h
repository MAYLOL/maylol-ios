//
//  PMLFillInfoTableViewCell.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/26.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLBaseTableViewCell.h"

typedef void(^InputBlock)(void);

@interface PMLFillInfoTableViewCell : PMLBaseTableViewCell
@property (nonatomic, copy, readonly) NSString *fieldString;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *fieldText;
@property (nonatomic, assign) BOOL fileEnable;
@property (nonatomic, copy) InputBlock inputBlock;
@end
