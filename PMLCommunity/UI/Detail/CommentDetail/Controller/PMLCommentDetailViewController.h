//
//  PMLCommentDetailViewController.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMLBaseViewController.h"
#import "PMLCommentDetailView.h"

@interface PMLCommentDetailViewController : PMLBaseViewController
@property (nonatomic, strong)NSArray<PMLCommentModel *> *commentList;
@property (nonatomic, strong)PMLCommentDetailView *detailView;
@end
