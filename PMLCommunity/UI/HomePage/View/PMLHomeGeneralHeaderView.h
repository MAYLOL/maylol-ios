//
//  PMLGeneralHeaderView.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/21.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseView.h"
typedef void(^SearchBlock)(void);
@interface PMLHomeGeneralHeaderView : PMLBaseView
@property (nonatomic, copy) SearchBlock searchBlock;
- (instancetype)initWithFrame:(CGRect)frame topString:(NSString *)topString;
@end
