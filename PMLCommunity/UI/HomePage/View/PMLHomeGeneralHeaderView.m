//
//  PMLGeneralHeaderView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/21.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLHomeGeneralHeaderView.h"

@interface PMLHomeGeneralHeaderView ()
@property (nonatomic, strong) PMLBaseLabel *textLabel;
@property (nonatomic, strong) PMLBaseButton *searchBtn;
@property (nonatomic, strong) PMLBaseView *lineView;
@property (nonatomic, strong) PMLBaseView *redLineView;
@property (nonatomic, copy) NSString *topString;;
@end

@implementation PMLHomeGeneralHeaderView

- (instancetype)initWithFrame:(CGRect)frame topString:(NSString *)topString{
    if (self = [super initWithFrame:frame]) {
        _topString = topString;
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews
{
    PMLBaseLabel *textLabel = [[PMLBaseLabel alloc] init];
    textLabel.text = _topString;
    [textLabel sizeToFit];
    textLabel.textColor = [UIColor colorWithHex:@"#1a1a1a"];
    textLabel.font = [UIFont customPingFSemiboldFontWithSize:24];
    [self addSubview:textLabel];
    _textLabel = textLabel;
    
    PMLBaseButton *searchBtn = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:kImageWithName(@"hot_btn_search") forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:searchBtn];
    _searchBtn = searchBtn;
    
    PMLBaseView *lineView = [[PMLBaseView alloc] init];
    lineView.backgroundColor = kRGBGrayColor(249);
    [self addSubview:lineView];
    _lineView = lineView;
    
    PMLBaseView *redLineView = [[PMLBaseView alloc] init];
    redLineView.backgroundColor = kRedColor;
    redLineView.layer.cornerRadius = 1;
    [self addSubview:redLineView];
    _redLineView = redLineView;
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.equalTo(self);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    [_redLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textLabel);
        make.bottom.equalTo(self.lineView.mas_top);
        make.width.equalTo(self.textLabel.mas_width);
        make.height.mas_equalTo(2);
    }];
    
    [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.textLabel);
        make.right.equalTo(self).offset(-15);
    }];
}

- (void)searchBtnClicked
{
    if (self.searchBlock) {
        self.searchBlock();
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
