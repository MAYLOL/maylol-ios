//
//  PMLCommunityCollectionViewCell.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/27.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLBaseCollectionViewCell.h"

typedef NS_ENUM(NSInteger, TouchItemType) {
    TouchItemMoney,
    TouchItemLike,
};

@protocol PMLCommunityCollectionViewCellDelegate <NSObject>
- (void)cellItemClicked:(NSIndexPath *)indexPath touchType:(TouchItemType)type;
@end

@class PMLHomeWaterFlowModel;

@interface PMLCommunityCollectionViewCell : PMLBaseCollectionViewCell
@property (nonatomic,weak) id<PMLCommunityCollectionViewCellDelegate> delegate;
@property (nonatomic, strong) PMLHomeWaterFlowModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

