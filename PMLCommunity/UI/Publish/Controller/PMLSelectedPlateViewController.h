//
//  PMLSelectedPlateViewController.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/21.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PMLSelectedPlateViewControllerDelegate <NSObject>

- (void)selectedPlate:(NSString *)plate;

@end

@interface PMLSelectedPlateViewController : PMLBaseViewController
@property (nonatomic,weak) id<PMLSelectedPlateViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
