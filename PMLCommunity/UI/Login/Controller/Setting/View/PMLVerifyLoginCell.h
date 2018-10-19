//
//  PMLVerifyLoginCell.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/9.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseTableViewCell.h"

typedef void(^InputBlock)(void);

@interface PMLVerifyLoginCell : PMLBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@property (weak, nonatomic) IBOutlet UIView *bottonLine;

@property (nonatomic, copy, readonly) NSString *fieldString;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *fieldText;
@property (nonatomic, assign) BOOL fileEnable;
@property (nonatomic, copy) InputBlock inputBlock;

@end
