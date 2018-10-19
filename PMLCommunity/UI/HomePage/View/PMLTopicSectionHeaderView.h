//
//  PMLTopicSectionHeaderView.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/12.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TopicSectionHeaderViewBlock)(NSInteger index);
@interface PMLTopicSectionHeaderView : UITableViewHeaderFooterView
@property (nonatomic, copy) NSString *typeString;
@property (nonatomic, assign) NSInteger headerIndex;
@property (nonatomic, copy) TopicSectionHeaderViewBlock headerViewBlock;
@end
