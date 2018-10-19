//
//  PMLDrawTableViewCell.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/20.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseTableViewCell.h"
@class PMLDrawerModel;
NS_ASSUME_NONNULL_BEGIN

@interface PMLDrawTableViewCell : UITableViewCell
@property (nonatomic, strong) PMLDrawerModel *dataModel;
@end

NS_ASSUME_NONNULL_END
