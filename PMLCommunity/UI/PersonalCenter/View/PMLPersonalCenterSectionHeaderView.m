//
//  PMLPersonalCenterSectionHeaderView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/22.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLPersonalCenterSectionHeaderView.h"

@interface PMLPersonalCenterSectionHeaderView ()
@property (nonatomic, strong) PMLBaseLabel *timeLabel;
@property (nonatomic, strong) PMLBaseView *topLineView;
@property (nonatomic, strong) PMLBaseView *pointView;
@property (nonatomic, strong) PMLBaseView *bottomLineView;
@end

@implementation PMLPersonalCenterSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews
{
    PMLBaseView *backgroundView = [[PMLBaseView alloc] init];
    backgroundView.backgroundColor = [UIColor whiteColor];
    self.backgroundView = backgroundView;
    [backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    _timeLabel = [[PMLBaseLabel alloc] init];
    _timeLabel.text = @"Label";
    _timeLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30);
        make.bottom.equalTo(self.contentView);
    }];
    
    _pointView = [[PMLBaseView alloc] init];
    _pointView.backgroundColor = kRGBGrayColor(210);
    [self.contentView addSubview:_pointView];
    [_pointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(3);
        make.centerY.equalTo(self.timeLabel);
        make.left.equalTo(self.contentView).offset(13);
    }];
    
    _topLineView = [[PMLBaseView alloc] init];
    _topLineView.backgroundColor = kRGBGrayColor(210);
    [self.contentView addSubview:_topLineView];
    [_topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo(1);
        make.bottom.equalTo(self.pointView.mas_top);
        make.centerX.equalTo(self.pointView.mas_centerX);
    }];
    
    _bottomLineView = [[PMLBaseView alloc] init];
    _bottomLineView.backgroundColor = kRGBGrayColor(210);
    [self.contentView addSubview:_bottomLineView];
    [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pointView.mas_bottom);
        make.width.mas_equalTo(1);
        make.bottom.equalTo(self.contentView);
        make.centerX.equalTo(self.pointView.mas_centerX);
    }];
    
    _pointView.layer.masksToBounds = YES;
    _pointView.layer.cornerRadius = 3.0/2;
}

- (void)setSectionIndex:(NSInteger)sectionIndex {
    _sectionIndex = sectionIndex;
    if (_sectionIndex == 0) {
        self.topLineView.hidden = YES;
    }else {
        self.topLineView.hidden = NO;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
