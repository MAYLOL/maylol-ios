//
//  PMLAddressCell.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/27.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLAddressCell.h"

@interface PMLAddressCell()
@property (nonatomic, strong) UIView *underLine;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) PMLBaseLabel *selectLabel;
@end

@implementation PMLAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.nameLabel];
    [self addSubview:self.underLine];
    [self addSubview:self.iconImageView];
    [self addSubview:self.selectLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(17);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
    [self.underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(17);
        make.right.equalTo(self.mas_right).offset(-17);
        make.height.mas_equalTo(0.3);
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-17);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
    [self.selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.iconImageView.mas_left).offset(-6);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
}

- (void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType {
    if (accessoryType == UITableViewCellAccessoryDisclosureIndicator){
        self.iconImageView.hidden = false;
    } else {
        self.iconImageView.hidden = true;
    }
}
- (void)setIsSelectAddress:(BOOL)isSelectAddress {
    _isSelectAddress = isSelectAddress;
    self.selectLabel.hidden = !isSelectAddress;
}


#pragma mark- =====================getter method=====================
- (UIView *)underLine {
    if (!_underLine){
        _underLine = [UIView new];
        _underLine.backgroundColor = [UIColor colorWithHex:@"#CCCCCC"];
    }
    return _underLine;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView){
        _iconImageView = [[UIImageView alloc] init];
        [_iconImageView setImage:kImageWithName(@"release_icon_arrow")];
    }
    return _iconImageView;
}

- (PMLBaseLabel *)nameLabel {
    if (!_nameLabel){
        _nameLabel = [[PMLBaseLabel alloc] initWithFrame:CGRectMake(25, 15, 300, 15)];
        _nameLabel.textColor = [UIColor colorWithHex:@"#1A1A1A"];
        _nameLabel.font = [UIFont customPingFRegularFontWithSize:15];

        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

- (PMLBaseLabel *)selectLabel {
    if (!_selectLabel){
        _selectLabel = [[PMLBaseLabel alloc] initWithFrame:CGRectZero];
        _selectLabel.textColor = [UIColor colorWithHex:@"#999999"];
        _selectLabel.font =  [UIFont customPingFRegularFontWithSize:15];
        _selectLabel.text = kInternationalContent(@"已选地区");
        _selectLabel.textAlignment = NSTextAlignmentRight;
        _selectLabel.hidden = true;
        [_selectLabel sizeToFit];
    }
    return _selectLabel;
}
@end
