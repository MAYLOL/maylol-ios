//
//  PMLSearchView.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/23.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseView.h"

@interface PMLSearchView : PMLBaseView
@property (nonatomic, strong, readonly) PMLBaseTextField *searchField;
@property (nonatomic, copy) NSString *placeholderStr;
@property (nonatomic, assign, readonly) BOOL isFirstResponder;
@end
