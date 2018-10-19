//
//  PMLAttentionVideoView.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/12.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLAttentionVideoView.h"

@implementation PMLAttentionVideoView

- (instancetype)init {

    if (self = [super init]){
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
//    [self addSubview:self.contentView];
//    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).offset(0);
//        make.left.equalTo(self.mas_left).offset(0);
//        make.right.equalTo(self.mas_right).offset(0);
//        make.bottom.equalTo(self.mas_bottom).offset(0);
//    }];
}

//- (UIView *)contentView {
//    if (!_contentView){
//        _contentView = [UIView new];
//        _contentView.backgroundColor = [UIColor whiteColor];
//    }
//    return _contentView;
//}
@end
