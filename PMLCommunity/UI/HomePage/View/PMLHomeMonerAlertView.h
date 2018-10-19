//
//  PMLHomeMonerAlertView.h
//  PMLCommunity
//
//  Created by panchuang on 2018/10/18.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PMLHomeMonerAlertView : PMLBaseView
@property (nonatomic, copy) NSString *articleReward;
@property (nonatomic, copy) NSString *totalReward;

@property (nonatomic, assign, readonly) float viewWidth;
@end

NS_ASSUME_NONNULL_END
