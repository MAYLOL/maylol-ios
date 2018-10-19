//
//  PMLAddressLocationCell.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/26.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PMLAddressLocationCellDelegate <NSObject>
- (void)loactionCountry:(NSString *)country;
@end

@interface PMLAddressLocationCell : UITableViewCell
@property (nonatomic, strong) PMLBaseLabel *nameLabel;//名字
@property (nonatomic, weak)id<PMLAddressLocationCellDelegate> delegate;

@end
