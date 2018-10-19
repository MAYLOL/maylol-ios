//
//  PMLSelectedPlateHeaderView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/25.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLSelectedPlateHeaderView.h"

@interface PMLSelectedPlateHeaderView ()
@property (nonatomic, strong) PMLBaseLabel *contentLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) PMLBaseView *lineView;
@property (nonatomic, strong) UIImage *rotationImage;
@end

@implementation PMLSelectedPlateHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier  {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    [self.contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerTouch)]];
    
    _contentLabel = [[PMLBaseLabel alloc] init];
    _contentLabel.textColor = kRGBGrayColor(102);
    _contentLabel.font = [UIFont customPingFRegularFontWithSize:13];
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(25);
        make.centerY.equalTo(self.contentView);
    }];
    
    _arrowImageView = [[UIImageView alloc] init];
    [_arrowImageView sizeToFit];
    _arrowImageView.image = kImageWithName(@"release_icon_arrow");
    [self.contentView addSubview:_arrowImageView];
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-25);
        make.centerY.equalTo(self.contentView);
    }];
    
    _lineView = [[PMLBaseView alloc] init];
    _lineView.backgroundColor = kRGBGrayColor(204);
    [self.contentView addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(25);
        make.right.equalTo(self.contentView).offset(-25);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

- (void)headerTouch {
    self.selected = !self.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerView:didSelectHeaderAtSection:selectedState:)]) {
        [self.delegate headerView:self didSelectHeaderAtSection:self.section selectedState:self.selected];
    }
}

#pragma mark-setter
- (void)setSection:(NSInteger)section {
    _section = section;
}

- (void)setContent:(NSString *)content {
    _content = content;
    _contentLabel.text = content;
    
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (_selected) {
        self.arrowImageView.image = kImageWithName(@"release_icon_arrow_up");
        self.lineView.hidden = YES;
    }else {
        self.lineView.hidden = NO;
        self.arrowImageView.image = kImageWithName(@"release_icon_arrow");
    }
}

@end
