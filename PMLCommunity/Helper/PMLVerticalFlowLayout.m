//
//  PMLVerticalFlowLayout.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/16.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLVerticalFlowLayout.h"

static const NSInteger columnsCount = 2;
static const CGFloat xMargin = 10;
static const CGFloat yMargin = 10;
static const UIEdgeInsets DefaultEdgeInset= {10,0,0,0};

@interface PMLVerticalFlowLayout ()
//头部视图的大小
@property (nonatomic, assign) CGSize headerSize;
//所有item的布局array
@property (nonatomic, strong) NSMutableArray *layoutAttribusArray;
//所有列的高度array
@property (nonatomic, strong) NSMutableArray *columnsHeightArray;
//获取列数
- (CGFloat)columnsCount;
//获取行间距
- (CGFloat)xMargin;
//获取列间距
- (CGFloat)yMarginAtIndexPath:(NSIndexPath *)indexPath;
//获取内边距
- (UIEdgeInsets)edgeInset;
@end

@implementation PMLVerticalFlowLayout
/**
 *  刷新布局的时候会重新调用
 */
- (void)prepareLayout
{
    [super prepareLayout];
    
    //重新刷新需要移除之前存储的高度
    [self.columnsHeightArray removeAllObjects];
    for (int i = 0; i < [self columnsCount]; i++) {
        [self.columnsHeightArray addObject:@([self edgeInset].top)];
    }
    
    // 移除以前计算的cells的attrbs
    [self.layoutAttribusArray removeAllObjects];
    
    ////添加头部视图
    UICollectionViewLayoutAttributes *headerLayout = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathWithIndex:0]];
    headerLayout.frame = CGRectMake(0, 0, self.collectionView.frame.size.width, self.headerSize.height);
    [self.layoutAttribusArray addObject:headerLayout];
    
    // 重新计算每个cell对应的atrbs, 保存到数组
    for (int i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        [self.layoutAttribusArray addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
    }
}

//返回所有的布局array
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.layoutAttribusArray;
}

//处理每个cell对应的位置和大小
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat itemWidth = floorf((self.collectionView.frame.size.width - self.edgeInset.left - self.edgeInset.right - self.xMargin * (self.columnsCount - 1))/self.columnsCount);
    
    CGFloat itemHeight = [self.delegate PML_verticalFlowLayout:self collectionView:self.collectionView heightForItemAtIndexPath:indexPath];
    
    //获取最后高度最小的那一列 假设刚开始是第0列
    NSInteger minIndex = 0;
    CGFloat minHeight = [self.columnsHeightArray[minIndex] floatValue];
    for (NSInteger i = 1; i < self.columnsHeightArray.count; i++) {
        CGFloat height = [self.columnsHeightArray[i] floatValue];
        if (minHeight > height) {
            minHeight = height;
            minIndex = i;
        }
    }
    
    CGFloat itemX = self.edgeInset.left + (self.xMargin + itemWidth) * minIndex;
    CGFloat itemY = minHeight + [self yMarginAtIndexPath:indexPath];
    
    //如果是第一行
    if (minHeight == self.edgeInset.top) {
        itemY = self.edgeInset.top;
    }
    if (indexPath.row <= 1) {
        attributes.frame = CGRectMake(itemX, itemY + self.headerSize.height, itemWidth, itemHeight);
    }else {
        attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    }
    
    self.columnsHeightArray[minIndex] = @(CGRectGetMaxY(attributes.frame));
    
    return attributes;
}

//返回内容的大小
- (CGSize)collectionViewContentSize
{
    CGFloat maxHeight = [self.columnsHeightArray.firstObject floatValue];
    for (int i = 1; i < self.columnsHeightArray.count; i++) {
        CGFloat height = [self.columnsHeightArray[i] floatValue];
        if (maxHeight < height) {
            maxHeight = height;
        }
    }
    return CGSizeMake(self.collectionView.frame.size.width, maxHeight + self.edgeInset.bottom);
}

//获取列数
- (CGFloat)columnsCount
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(PML_verticalFlowLayout:colmunsCountForCollectionView:)]) {
        return [self.delegate PML_verticalFlowLayout:self colmunsCountForCollectionView:self.collectionView];
    }else {
        return columnsCount;
    }
    
}
//获取行间距
- (CGFloat)xMargin
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(PML_verticalFlowLayout:colmunsMarginForCollectionView:)]) {
        return [self.delegate PML_verticalFlowLayout:self colmunsMarginForCollectionView:self.collectionView];
    }else {
        return xMargin;
    }
}
//获取列间距
- (CGFloat)yMarginAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(PML_verticalFlowLayout:collectionView:lineMarginItemForIndexPath:)]) {
        return [self.delegate PML_verticalFlowLayout:self collectionView:self.collectionView lineMarginItemForIndexPath:indexPath];
    } else {
        return yMargin;
    }
}
//获取内边距
- (UIEdgeInsets)edgeInset
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(PML_verticalFlowLayout:edgeInsetsForcollectionView:)]) {
        return [self.delegate PML_verticalFlowLayout:self edgeInsetsForcollectionView:self.collectionView];
    } else {
        return DefaultEdgeInset;
    }
}

- (instancetype)initWithDelegate:(id<PMLVerticalFlowLayoutDelegate>)delegate headerSize:(CGSize)headerSize
{
    if (self = [super init]) {
        _headerSize = headerSize;
    }
    return self;
}

- (id<PMLVerticalFlowLayoutDelegate>)delegate
{
    return (id<PMLVerticalFlowLayoutDelegate>)self.collectionView.dataSource;
}

#pragma mark-lazy load
-(NSMutableArray *)columnsHeightArray
{
    if (!_columnsHeightArray) {
        _columnsHeightArray = [NSMutableArray array];
    }
    return _columnsHeightArray;
}

- (NSMutableArray *)layoutAttribusArray
{
    if (!_layoutAttribusArray) {
        _layoutAttribusArray = [NSMutableArray array];
    }
    return _layoutAttribusArray;
}
@end
