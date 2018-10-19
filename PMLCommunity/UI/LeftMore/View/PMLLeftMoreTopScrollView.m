//
//  PMLLeftMoreTopScrollView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/24.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLLeftMoreTopScrollView.h"

#define itemFix 23
#define ItemLeftMargin 17

static const CGFloat LineViewAutomaticDimension = -1;

//标记委托对象是否实现了代理方法, 使用结构体优化方法调用次数
struct DelegateFlags {
    int didFinishSelectedItem : 1;
};

@interface PMLLeftMoreTopScrollView ()
{
    NSInteger _dataSourceCount;
}
@property (nonatomic, copy) NSArray <NSString *> *dataSource;
@property (nonatomic, assign) struct DelegateFlags delegateFlags;
@property (nonatomic, strong) PMLBaseScrollView *scrollView;
@property (nonatomic, strong) PMLBaseView *lineView;
@end

@implementation PMLLeftMoreTopScrollView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource delegate:(id<PMLLeftMoreTopScrollViewDelegate>)delegate {
    if (self = [super initWithFrame:frame]) {
        _dataSource = dataSource;
        _dataSourceCount = _dataSource.count;
        _lineWidth = LineViewAutomaticDimension;
        _delegate = delegate;
        _delegateFlags.didFinishSelectedItem = [delegate respondsToSelector:@selector(leftMoreTopScrollView:didSelectItemWithIndex:)];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    _scrollView = [[PMLBaseScrollView alloc] initWithFrame:self.bounds];
    _scrollView.bounces = NO;
    [self addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(self);
    }];
    
    _lineView = [[PMLBaseView alloc] init];
    _lineView.backgroundColor = kRGBColor(240, 46, 68);
    [_scrollView addSubview:_lineView];
    _lineView.layer.cornerRadius = 1;
    
    CGFloat itemTotalWidth = 0;
    for (int i = 0; i < _dataSourceCount; i++) {
        PMLBaseButton *item = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
        [item setTitle:_dataSource[i] forState:UIControlStateNormal];
        [item setTitleColor:kRGBGrayColor(26) forState:UIControlStateNormal];
        [item sizeToFit];
        item.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        item.tag = 10 + i;
        CGSize itemSize;
        [item addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
        item.frame = CGRectMake(ItemLeftMargin + i * itemFix + itemTotalWidth, 0, itemSize.width, itemSize.height);
        itemTotalWidth += itemSize.width;
        item.centerY = _scrollView.centerY;
        [_scrollView addSubview:item];
        if (i == _dataSourceCount - 1) {
            _scrollView.contentSize = CGSizeMake(item.right + ItemLeftMargin, 0);
        }
        if (i == 0) {
            _lineView.frame = CGRectMake(item.x, self.height - 2, itemSize.width, 2);
        }
    }
    //默认点击
    [self itemClicked:(PMLBaseButton *)[_scrollView viewWithTag:10]];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _scrollView.frame = self.bounds;
}

- (void)setDelegate:(id<PMLLeftMoreTopScrollViewDelegate>)delegate {
    _delegate = delegate;
    _delegateFlags.didFinishSelectedItem = [_delegate respondsToSelector:@selector(leftMoreTopScrollView:didSelectItemWithIndex:)];
}

- (void)itemClicked:(PMLBaseButton *)sender {
    [self setItemStates:sender];
    if (_delegateFlags.didFinishSelectedItem) {
        [self.delegate leftMoreTopScrollView:self didSelectItemWithIndex:sender.tag];
    }
}

- (void)setItemStates:(PMLBaseButton *)sender {
    if (sender.selected) {
        return;
    }
    sender.selected = !sender.selected;
    __block CGFloat itemTotalWidth = 0;
    for (int i = 0; i < _dataSourceCount; i++) {
        PMLBaseButton *item = (PMLBaseButton *)[_scrollView viewWithTag:10 + i];
        if (item == sender) {
            item.selected = YES;
            item.titleLabel.font = [UIFont customPingFSemiboldFontWithSize:20];
            
        }else {
            item.selected = NO;
            item.titleLabel.font = [UIFont customPingFRegularFontWithSize:13];
        }
        //TODO:这段要改 实现不优雅
        //item选中后 重新计算所有frame
        [UIView animateWithDuration:KAnimationDuration animations:^{
            CGSize itemSize= [PMLTools sizeForString:item.titleLabel.text font:item.titleLabel.font maxSize:CGSizeMake(100, 30)];
            item.frame = CGRectMake(ItemLeftMargin + i * itemFix + itemTotalWidth, 0, itemSize.width, itemSize.height);
            itemTotalWidth += itemSize.width;
            item.centerY = self.scrollView.centerY;
        }];
    }
    [UIView animateWithDuration:KAnimationDuration animations:^{
        self.lineView.frame = CGRectMake(sender.x, self.height - 2, sender.width, 2);
    }];
}

- (void)setSelectItemWIthIndex:(NSInteger)index {
    [self setItemStates:(PMLBaseButton *)[_scrollView viewWithTag: 10 + index]];
}

//- (void)setLineWidth:(CGFloat)lineWidth {
//    _lineWidth = lineWidth;
//}

@end
