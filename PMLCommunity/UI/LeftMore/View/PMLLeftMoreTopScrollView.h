//
//  PMLLeftMoreTopScrollView.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/24.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseView.h"

@class PMLLeftMoreTopScrollView;
@protocol PMLLeftMoreTopScrollViewDelegate <NSObject>

- (void)leftMoreTopScrollView:(PMLLeftMoreTopScrollView *)scrollView didSelectItemWithIndex:(NSInteger)index;

@end

@interface PMLLeftMoreTopScrollView : PMLBaseView
//红线的宽度 (默认为item的宽度)
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic,weak) id<PMLLeftMoreTopScrollViewDelegate> delegate;
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource delegate:(id<PMLLeftMoreTopScrollViewDelegate>)delegate;
- (void)setSelectItemWIthIndex:(NSInteger)index;
@end

