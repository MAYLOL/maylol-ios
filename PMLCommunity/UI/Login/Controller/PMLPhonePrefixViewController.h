//
//  PMLPhonePrefixViewController.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/8.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseViewController.h"

typedef void(^ResultHanler)(BOOL cancel,NSString *zone,NSString *countryName);

@interface PMLPhonePrefixViewController : PMLBaseViewController
- (instancetype)initWithResult:(ResultHanler)result;
@end
