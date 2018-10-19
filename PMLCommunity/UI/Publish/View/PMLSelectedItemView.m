//
//  PMLSelectedItemView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/20.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLSelectedItemView.h"
#import "PMLItemButton.h"

#define ItemHeight 25
#define ViewDefaultHeight self.showTitle?40:0
#define ItemTopBottomMargin 10
#define ItemMargin 5
#define ItemLeftRight 15

@interface PMLSelectedItemView ()<PMLItemButtonDelegate>
@property (nonatomic, strong) PMLBaseLabel *titleLabel;
@property (nonatomic, strong) PMLBaseView *lineView;
//保存item的数组
@property (nonatomic, strong) NSMutableArray <PMLItemButton *>*itemArray;
@end

@implementation PMLSelectedItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _showTitle = YES;
        [self setupSubViews];
    }
    
    return self;
}

- (void)setupSubViews {
    _titleLabel = [[PMLBaseLabel alloc] init];
    [_titleLabel sizeToFit];
    _titleLabel.textColor = kRGBGrayColor(26);
    _titleLabel.font = [UIFont customPingFSemiboldFontWithSize:16];
    _titleLabel.text = kInternationalContent(@"项目标签");
    [self addSubview:_titleLabel];
    
    _lineView = [[PMLBaseView alloc] init];
    _lineView.backgroundColor = kRGBGrayColor(230);
    [self addSubview:_lineView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.lineView.frame = CGRectMake(0, self.height - 1, self.width, 1);
    if (_showTitle) {
        self.titleLabel.frame = CGRectMake(15, 10, 80, 17);
    }else {
        self.titleLabel.frame = CGRectZero;
    }
}

- (void)refreshItemViewWithContent:(NSArray <NSString *>*)contentArray complete:(void (^)(CGFloat itemViewHeight))complete {
    //如果只需要一个item
    if (_alone) {
        if (self.itemArray.count > 0) {
            PMLItemButton *lastItem = [self.itemArray lastObject];
            lastItem.contentStr = [contentArray lastObject];
        }else {
            [self createItemWithContent:[contentArray lastObject]];
        }
    }else {
        __block BOOL contains = NO;
        [contentArray enumerateObjectsUsingBlock:^(NSString * _Nonnull content, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.itemArray enumerateObjectsUsingBlock:^(PMLItemButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.contentStr isEqualToString:content]) {
                    contains = YES;
                    *stop = YES;
                }
            }];
            if (!contains) {
                [self createItemWithContent:content];
            }
            //重置判断条件
            contains = NO;
        }];
//        for (PMLItemButton * obj in self.itemArray) {
//            if ([obj.contentStr isEqualToString:content]) {
//                return;
//            }
//        }
//        [self createItemWithContent:content];
    }
    complete([self.itemArray lastObject].bottom + ItemTopBottomMargin);
}

- (void)createItemWithContent:(NSString *)content {
    
    PMLItemButton *lastItem = [self.itemArray lastObject];
    PMLItemButton *item = [[PMLItemButton alloc] init];
    item.delegate = self;
    CGFloat itemWidth = [PMLTools sizeForString:content font:lastItem ? lastItem.itemFont : [UIFont customPingFRegularFontWithSize:10] maxSize:CGSizeMake(200, 50)].width + 15 + 10 + 7 + 5;
    if (lastItem) {
        if (itemWidth + lastItem.right > self.width - 30) {
            item.frame = CGRectMake(ItemLeftRight, lastItem.bottom + ItemMargin, itemWidth,ItemHeight);
        }else {
            item.frame = CGRectMake(lastItem.right + ItemMargin, lastItem.y, itemWidth,ItemHeight);
        }
    }else {
        item.frame = CGRectMake(ItemLeftRight, _titleLabel.bottom + ItemTopBottomMargin, itemWidth, ItemHeight);
    }
    
    item.contentStr = content;
    [self addSubview:item];
    [self.itemArray addObject:item];
}

- (void)deleteAllItems {
    [self.itemArray removeAllObjects];
    for (PMLItemButton *item in self.subviews) {
        [item removeFromSuperview];
    }
}

- (NSMutableArray <NSString *>*)allItemsContent {
    NSMutableArray *contentArray = [NSMutableArray array];
    for (PMLItemButton *item in self.itemArray) {
        [contentArray addObject:item.contentStr];
    }
    return contentArray;
}
#pragma mark-PMLItemButtonDelegate
- (void)deleteItemView:(PMLItemButton *)item {
    NSInteger index = [self.itemArray indexOfObject:item];
    //删除item
    [self.itemArray removeObject:item];
    [item removeFromSuperview];
    //删除按钮后调整按钮布局 刷新view高度
    CGFloat itemViewHeight = 0;
    if (self.itemArray.count > 0 ) {
        for (NSInteger i = index; i < self.itemArray.count; i++) {
            if (index > 0) {
                PMLItemButton *subItem = self.itemArray[i - 1];//取前一个按钮
                PMLItemButton *item = self.itemArray[i];
                if (subItem.right + item.width > self.width - 30) {
                    item.frame = CGRectMake(ItemLeftRight, subItem.bottom + ItemMargin, item.width, item.height);
                }else {
                    item.frame = CGRectMake(subItem.right + ItemMargin, subItem.y, item.width, item.height);
                }
            }else {
                PMLItemButton *item = self.itemArray[i];
                if (i == 0) {
                    item.frame = CGRectMake(ItemLeftRight, _titleLabel.bottom + ItemTopBottomMargin, item.width, item.height);
                }else {
                    PMLItemButton *beforeItem = self.itemArray[i - 1];
                    if (beforeItem.right + item.width > self.width - 30) {
                        item.frame = CGRectMake(ItemLeftRight, beforeItem.bottom + ItemMargin, item.width, item.height);
                    }else {
                        item.frame = CGRectMake(beforeItem.right + ItemMargin, beforeItem.y, item.width, item.height);
                    }
                }
            }
            
            
            
        }
        itemViewHeight = [self.itemArray lastObject].bottom + ItemTopBottomMargin;
    }else {
        itemViewHeight = ViewDefaultHeight;
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(deleteItemComplete:)]) {
        [self.delegate deleteItemComplete:itemViewHeight];
    }
}

#pragma mark-setter
- (NSMutableArray *)itemArray {
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

- (void)setShowTitle:(BOOL)showTitle {
    _showTitle = showTitle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
