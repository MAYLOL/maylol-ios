//
//  PMLPersonalInfoTableViewCell.h
//  PMLCommunity
//
//  Created by panchuang on 2018/10/10.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PMLPersonalInfoTableViewCell : PMLBaseTableViewCell
@property (nonatomic, copy) NSString *typeString;
@property (nonatomic, copy) NSString *dataString;
@property (nonatomic, assign) NSInteger cellIndex;
@property (nonatomic, assign) BOOL fieldEnableEdit;
@end

NS_ASSUME_NONNULL_END
