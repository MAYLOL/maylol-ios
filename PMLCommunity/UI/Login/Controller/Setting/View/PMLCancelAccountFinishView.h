//
//  PMLCancelAccountFinishView.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/10.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BlockAction)(void);

@interface PMLCancelAccountFinishView : UIView
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (nonatomic,copy)BlockAction clickAction;

@end
