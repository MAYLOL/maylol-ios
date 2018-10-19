//
//  PMLItemButton.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/20.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseView.h"

@class PMLItemButton;
@protocol PMLItemButtonDelegate <NSObject>
- (void)deleteItemView:(PMLItemButton *)item;
@end

@interface PMLItemButton : PMLBaseView
@property (nonatomic, copy) NSString *contentStr;
@property (nonatomic, strong, readonly) UIFont *itemFont;
@property (nonatomic,weak) id<PMLItemButtonDelegate> delegate;
@end

