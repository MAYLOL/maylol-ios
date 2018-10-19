//
//  PMLHomeRecommendTopicTableViewCell.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/20.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseTableViewCell.h"

typedef void(^RecommendTopicBlock)(NSInteger index);
@interface PMLHomeRecommendTopicTableViewCell : PMLBaseTableViewCell
@property (nonatomic, copy) RecommendTopicBlock recommendTopicBLock;
@property (nonatomic, assign) NSInteger cellIndex;
@end
