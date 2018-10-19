//
//  PMLCommentDetailCell.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMLCommentModel.h"
#import "PMLCommentProtocol.h"

@interface PMLCommentDetailCell : UITableViewCell

@property (nonatomic, weak)id<PMLCommentDelegate> commentDelgate;
@property (nonatomic, strong) PMLCommentModel *commentModel;


@end
