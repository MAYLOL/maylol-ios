//
//  PMLAutoScrollView.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/14.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseView.h"
@class PMLAutoScrollView;
@protocol PMLAutoScrollViewDelegate <NSObject>
- (void)autoScrollView:(PMLAutoScrollView *)autoScrollView didSelectAtIndex:(NSInteger)index;
@end

@interface PMLAutoScrollView : PMLBaseView
//数据源
@property (nonatomic, copy) NSArray *dataArray;
//item字体大小
//@property (nonatomic, assign) CGFloat labelFont;
//默认颜色
@property (nonatomic, strong) UIColor *normalColor;
//选中颜色
@property (nonatomic, strong) UIColor *selectColor;
//默认字体
@property (nonatomic, strong) UIFont *normalFont;
//选中字体
@property (nonatomic, strong) UIFont *selectFont;
//item间距
@property (nonatomic, assign) CGFloat itemMargin;
//
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
//是否显示下划线
@property (nonatomic, assign) BOOL showBottomLine;
//设置偏移量Item
@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, weak) id<PMLAutoScrollViewDelegate>delegate;

/**
 初始化方法

 @param frame frame
 @param delegate 代理
 @param dataSource 数据源
 @param defaultIndex 默认选中的item
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame delegate:(id<PMLAutoScrollViewDelegate>)delegate dataSource:(NSArray *)dataSource defaultSelectIndex:(NSInteger)defaultIndex;
@end
