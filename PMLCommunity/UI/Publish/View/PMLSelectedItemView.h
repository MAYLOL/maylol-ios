//
//  PMLSelectedItemView.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/20.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseView.h"

@protocol PMLSelectedItemViewDelegate <NSObject>

- (void)deleteItemComplete:(CGFloat)itemViewHeight;

@end

@interface PMLSelectedItemView : PMLBaseView
//是否可以选择多个标签
@property (nonatomic, assign) BOOL alone;
//是否显示title
@property (nonatomic, assign) BOOL showTitle;
@property (nonatomic,weak) id<PMLSelectedItemViewDelegate> delegate;

//根据内容刷新itemview
- (void)refreshItemViewWithContent:(NSArray <NSString *>*)contentArray complete:(void (^)(CGFloat itemViewHeight))complete;
//删除所有按钮
- (void)deleteAllItems;
//所有item
- (NSMutableArray <NSString *>*)allItemsContent;
@end

