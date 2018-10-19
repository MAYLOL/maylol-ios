//
//  PMLGetCodeCell.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/10.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMLGetCodeButton.h"

typedef void(^InputBlock)(void);
typedef void(^ClickBlock)(void);

@interface PMLGetCodeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *getCodeField;
@property (weak, nonatomic) IBOutlet PMLGetCodeButton *getCodeBtn;

@property (nonatomic, copy, readonly) NSString *fieldString;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *fieldText;
@property (nonatomic, assign) BOOL fileEnable;
@property (nonatomic, copy) InputBlock inputBlock;
@property (nonatomic, copy) ClickBlock clickBlock;

@end
