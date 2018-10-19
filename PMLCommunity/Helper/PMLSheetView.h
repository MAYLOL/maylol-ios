//
//  PMLSheetView.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/18.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseView.h"

typedef void(^SheetViewBlock)(NSInteger index);

@interface PMLSheetView : PMLBaseView
- (instancetype)initWithDatasource:(NSArray <NSString *> *)datasource complate:(SheetViewBlock)complate;
- (void)show;
@end
