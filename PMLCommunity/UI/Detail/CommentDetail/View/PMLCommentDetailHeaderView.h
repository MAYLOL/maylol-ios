//
//  PMLCommentDetailHeaderView.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMLCommentProtocol.h"

@interface PMLCommentDetailHeaderView : UIView

@property (nonatomic, assign)NSInteger commentCount;
@property (nonatomic, weak)id<PMLCommentDelegate> delegate;

@end
