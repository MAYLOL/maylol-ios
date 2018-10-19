//
//  PMLGetCodeButton.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/10.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMLGetCodeButton : UIButton

@property (nonatomic,strong)UIColor *backColor;
@property (nonatomic,strong)UIColor *clickColor;

@property (nonatomic,assign)BOOL isOK;

- (void)click;
@end
