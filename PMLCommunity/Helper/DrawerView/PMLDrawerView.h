//
//  PMLDrawerView.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/20.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseView.h"

@class PMLDrawerView;
@protocol PMLDrawerViewDelegate <NSObject>
- (void)pmlDrawerView:(PMLDrawerView *)drawerView didFinishSelectedItem:(NSString *)itemContent;
@end

static NSString *const DrawLeftTableViewCellId = @"DrawLeftTableViewCellId";
static NSString *const DrawCenterTableViewCellId = @"DrawCenterTableViewCellId";
static NSString *const DrawRightTableViewCellId = @"DrawRightTableViewCellId";
@class PMLDrawerModel;
@interface PMLDrawerView : PMLBaseView
@property (nonatomic, weak) id<PMLDrawerViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray <PMLDrawerModel *>*leftDataArray;
@property (nonatomic, strong) NSMutableArray <PMLDrawerModel *>*centerDataArray;
@property (nonatomic, strong) NSMutableArray <PMLDrawerModel *>*rightDataArray;
- (instancetype)initWithFrame:(CGRect)frame controller:(UIViewController *)controller;
- (void)layout;
@end


@interface PMLDrawerModel : PMLBaseModel
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *itemId;
@property (nonatomic, assign) BOOL selected;
@end
