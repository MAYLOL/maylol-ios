//
//  PMLNotificationCell.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/10.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SwtichBlock)(BOOL);

@interface PMLNotificationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;
@property (weak, nonatomic) IBOutlet UISwitch *switchControl;
@property (nonatomic, copy)SwtichBlock swtichBlock;

@end
