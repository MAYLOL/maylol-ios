//
//  PMLCommentReplyView.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/18.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PMLCommentModel;
#import "PMLCommentInputView.h"

typedef void (^ReplyViewBlock)(void);
@interface PMLCommentReplyView : UIView

@property (nonatomic, strong) PMLCommentInputView *inputKView;
@property (nonatomic, strong) PMLCommentModel *commentModel;
@property (nonatomic, copy) ReplyViewBlock touchBlock;

- (void)show;
@end
