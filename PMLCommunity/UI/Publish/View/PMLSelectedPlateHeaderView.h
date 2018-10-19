//
//  PMLSelectedPlateHeaderView.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/25.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PMLSelectedPlateHeaderView;
@protocol PMLSelectedPlateHeaderViewDelegate <NSObject>

- (void)headerView:(PMLSelectedPlateHeaderView *)headerView didSelectHeaderAtSection:(NSInteger)section selectedState:(BOOL)selectState;

@end

@interface PMLSelectedPlateHeaderView : UITableViewHeaderFooterView
@property (nonatomic,weak) id<PMLSelectedPlateHeaderViewDelegate> delegate;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) BOOL selected;
@end

