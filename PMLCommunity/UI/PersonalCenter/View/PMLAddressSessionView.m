//
//  PMLAddressSessionView.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/26.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLAddressSessionView.h"

@interface PMLAddressSessionView()
@end

@implementation PMLAddressSessionView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = kRGBColor(236, 236, 236);
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(25);
//        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.top.equalTo(self.mas_top).offset(15);
    }];
}

- (PMLBaseLabel *)nameLabel {
    if (!_nameLabel){
        _nameLabel = [[PMLBaseLabel alloc] initWithFrame:CGRectMake(25, 15, 300, 15)];
        _nameLabel.textColor = [UIColor colorWithHex:@"#1A1A1A"];
        _nameLabel.font = [UIFont customPingFRegularFontWithSize:7];
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

@end
