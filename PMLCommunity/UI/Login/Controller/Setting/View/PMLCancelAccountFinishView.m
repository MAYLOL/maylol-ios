//
//  PMLCancelAccountFinishView.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/10.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLCancelAccountFinishView.h"

@interface PMLCancelAccountFinishView()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;

//
//
//
@end

@implementation PMLCancelAccountFinishView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.finishBtn.layer.cornerRadius = 3;
    self.finishBtn.layer.masksToBounds = true;
    [self.finishBtn addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
    self.titleLabel.text = kInternationalContent(@"已完成注销申请");
    self.msgLabel.text = kInternationalContent(@"Maylol团队将在60天内处理你的申请并删除所有 数据，在60天内，请不要登录Maylol，确保注销 顺利完成。");
    [self.finishBtn setTitle:kInternationalContent(@"完成并退出Maylol") forState:UIControlStateNormal];
}

- (void)finishAction:(UIButton *)sender {
    if (self.clickAction){
        self.clickAction();
    }
}

@end
