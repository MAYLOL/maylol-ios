//
//  PMLVerticalFlowLayout.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/16.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PMLVerticalFlowLayout;
@protocol PMLVerticalFlowLayoutDelegate <NSObject>
@required

/**
 每个item的高度

 @param layout layout
 @param collectionVew collectionView
 @param indexPath indexPath
 @return 返回值
 */
- (CGFloat)PML_verticalFlowLayout:(PMLVerticalFlowLayout *)layout collectionView:(UICollectionView *)collectionVew heightForItemAtIndexPath:(NSIndexPath *)indexPath;
@optional

/**
 列数

 @param layout layout
 @param collectionVew collectionView
 @return 返回值
 */
- (CGFloat)PML_verticalFlowLayout:(PMLVerticalFlowLayout *)layout colmunsCountForCollectionView:(UICollectionView *)collectionVew;

/**
 列间距

 @param layout layout
 @param collectionVew collectionView
 @return 返回值
 */
- (CGFloat)PML_verticalFlowLayout:(PMLVerticalFlowLayout *)layout colmunsMarginForCollectionView:(UICollectionView *)collectionVew;

/**
 行间距

 @param layout layout
 @param collectionVew collectionView
 @param indexPath indexPath
 @return 返回值
 */
- (CGFloat)PML_verticalFlowLayout:(PMLVerticalFlowLayout *)layout collectionView:(UICollectionView *)collectionVew lineMarginItemForIndexPath:(NSIndexPath *)indexPath;

/**
 内边距

 @param layout layout
 @param collectionVew collectionView
 @return 返回值
 */
- (UIEdgeInsets)PML_verticalFlowLayout:(PMLVerticalFlowLayout *)layout edgeInsetsForcollectionView:(UICollectionView *)collectionVew;

@end
@interface PMLVerticalFlowLayout : UICollectionViewLayout

/**
 初始化实例

 @param delegate 设置代理
 @param headerSize 头部视图大小  如果没有 可以设置为zero
 @return 返回实例
 */
- (instancetype)initWithDelegate:(id<PMLVerticalFlowLayoutDelegate>)delegate headerSize:(CGSize)headerSize;
@end
