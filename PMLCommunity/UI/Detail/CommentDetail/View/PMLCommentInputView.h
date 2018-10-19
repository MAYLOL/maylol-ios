//
//  PMLCommentInputView.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+PMLViewFrom.h"
#import "PMLCommentProtocol.h"

@interface PMLCommentInputView : UIView

@property (nonatomic, strong) UITextView *inputTV;
@property (nonatomic, strong) UIButton *sentButton;
@property (nonatomic, copy) void(^clickActionHandle)(void);
@property (nonatomic, copy) void(^textHandle) (NSString *msg);
@property (nonatomic, weak) id<PMLCommentInputKViewDelegate> inputKDelegate;

- (void)becomeFirstResponster;
- (void)becomeFirstResponsterWithtxtHandle:(void(^)(NSString *msg))txtHandle;
- (void)resignFirstResponster;
- (BOOL)isFirstResponsder;
@end
