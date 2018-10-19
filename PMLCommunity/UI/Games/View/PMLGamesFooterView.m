//
//  PMLGamesFooterView.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/12.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLGamesFooterView.h"

@interface PMLGamesFooterView()

@end

@implementation PMLGamesFooterView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    UIView *underLine = [UIView new];
    underLine.backgroundColor = [UIColor colorWithHex:@"#E6E6E6"];
    [self addSubview:underLine];
    [underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(1);
    }];
}

@end
