//
//  PMLAutoScrollView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/14.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLAutoScrollView.h"
#import "PMLAutoScrollViewCell.h"

static NSString *const PMLAutoScrollViewCellId = @"PMLAutoScrollViewCellId";

@interface PMLAutoScrollView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation PMLAutoScrollView
- (instancetype)initWithFrame:(CGRect)frame delegate:(id<PMLAutoScrollViewDelegate>)delegate dataSource:(NSArray *)dataSource defaultSelectIndex:(NSInteger)defaultIndex
{
    if (self = [super initWithFrame:frame]) {
        _dataArray = dataSource;
        _delegate = delegate;
        if (defaultIndex <= dataSource.count) {
            _selectIndex = defaultIndex;
        }else {
            _selectIndex = 0;
        }
        [self setUpSubViews];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //
    CGRect frame = self.frame;
//    frame.size.width = frame.size.width + 4;
    if (_showBottomLine) {
        frame.size.height = frame.size.height + 4;
    }
    self.frame = frame;
    self.collectionView.frame = self.bounds;
}

- (void)setUpSubViews
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.alwaysBounceHorizontal = YES;
    self.collectionView.bounces = NO;
    [self.collectionView registerClass:[PMLAutoScrollViewCell class] forCellWithReuseIdentifier:PMLAutoScrollViewCellId];
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self collectionView:self.collectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]];
}

#pragma mark-UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PMLAutoScrollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PMLAutoScrollViewCellId forIndexPath:indexPath];
//    cell.labelFont = self.labelFont;
    cell.selectColor = self.selectColor;
    cell.normalColor = self.normalColor;
    cell.selectFont  = self.selectFont;
    cell.normalFont = self.normalFont;
    cell.itemStr = self.dataArray[indexPath.row];
    if (indexPath.row == _selectIndex) {
        cell.itemSelected = YES;
    }else {
        cell.itemSelected = NO;
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *textStr = self.dataArray[indexPath.row];
    CGSize size;
    if (indexPath.row == _selectIndex) {
        size = [PMLTools sizeForString:textStr font:self.selectFont maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
        //这里不加0.1的话 设置的minimumInteritemSpacing无效  不知为啥...
        return CGSizeMake(size.width + 0.1, size.height);
    }else {
        size = [PMLTools sizeForString:textStr font:self.normalFont maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
    }
    return CGSizeMake(size.width, size.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//    PMLAutoScrollViewCell *cell = (PMLAutoScrollViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    CGRect rectInCollection = [collectionView convertRect:cell.frame toView:_collectionView];
//    CGRect rectInScreen = [collectionView convertRect:rectInCollection toView:self];
//    self.lineView.frame = CGRectMake(rectInScreen.origin.x, cell.size.height - 2, cell.size.width, 2);
    _selectIndex = indexPath.row;
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self.collectionView reloadData];
    if (self.delegate && [self.delegate respondsToSelector:@selector(autoScrollView:didSelectAtIndex:)]) {
        [self.delegate autoScrollView:self didSelectAtIndex:indexPath.row];
    }
    
}

- (void)setShowBottomLine:(BOOL)showBottomLine {
//    _showBottomLine = showBottomLine;
    if (_showBottomLine) {
        if (!_lineView) {
            _lineView = [[UIView alloc] initWithFrame:CGRectZero];
            _lineView.backgroundColor = kRGBColor(235, 61, 79);
            _lineView.height = 2;
            _lineView.layer.cornerRadius = 2;
            _lineView.layer.masksToBounds = YES;
            [self addSubview:_lineView];
        }
    }
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    if (selectIndex == _selectIndex) {
        return;
    }
    _selectIndex = selectIndex;
    [self collectionView:self.collectionView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0]];
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

- (void)setItemMargin:(CGFloat)itemMargin
{
    _itemMargin = itemMargin;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.minimumInteritemSpacing = _itemMargin;
//    layout.sectionInset = UIEdgeInsetsMake(0, _itemMargin/2, 0, _itemMargin/2);
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    _edgeInsets = edgeInsets;
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.sectionInset = _edgeInsets;
}

//- (uitab)
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
