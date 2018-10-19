//
//  PMLMyDiaryTableViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/14.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLMyDiaryTableViewCell.h"
#import "UIView+Gradient.h"
@interface PMLMyDiaryTableViewCell ()
@property (nonatomic, strong) UIImageView *leftIconImageView;
@property (nonatomic, strong) PMLBaseLabel *diaryTitleLabel;
@property (nonatomic, strong) PMLBaseLabel *createTimeLabel;
@property (nonatomic, strong) PMLBaseLabel *updateTimeLabel;
@property (nonatomic, strong) PMLBaseLabel *diaryCountLabel;
@property (nonatomic, strong) PMLBaseButton *writeDiaryBtn;
@property (nonatomic, strong) UIImageView *contentImageView;
@end

@implementation PMLMyDiaryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    PMLBaseView *cellContentView = [[PMLBaseView alloc] init];
    [self.contentView addSubview:cellContentView];
    [cellContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.contentView).offset(8);
        make.bottom.equalTo(self.contentView).offset(8);
    }];
    
    _contentImageView = [[UIImageView alloc] init];
    _contentImageView.backgroundColor = kRandomColor;
    [cellContentView addSubview:_contentImageView];
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cellContentView).offset(-15);
        make.centerY.equalTo(cellContentView);
        make.width.height.mas_equalTo(103);
    }];
    
    _leftIconImageView = [[UIImageView alloc] init];
    _leftIconImageView.image = kImageWithName(@"beautiful_icon_title");
    [cellContentView addSubview:_leftIconImageView];
    [_leftIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cellContentView).offset(15);
        make.top.equalTo(cellContentView).offset(15);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(18);
    }];
    
    _diaryTitleLabel = [[PMLBaseLabel alloc] init];
    _diaryTitleLabel.textColor = kRGBGrayColor(26);
    _diaryTitleLabel.font = [UIFont customPingFSemiboldFontWithSize:18];
    [cellContentView addSubview:_diaryTitleLabel];
    [_diaryTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftIconImageView.mas_right).offset(10);
        make.centerY.equalTo(self.leftIconImageView);
        make.right.equalTo(self.contentImageView.mas_left).offset(15);
    }];
    
    _createTimeLabel = [[PMLBaseLabel alloc] init];
    _createTimeLabel.textColor = kRGBGrayColor(26);
    _createTimeLabel.font = [UIFont customPingFRegularFontWithSize:9];
    [cellContentView addSubview:_createTimeLabel];
    [_createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftIconImageView);
        make.top.equalTo(self.diaryTitleLabel.mas_bottom).offset(15);
    }];
    
    _updateTimeLabel = [[PMLBaseLabel alloc] init];
    _updateTimeLabel.textColor = kRGBGrayColor(26);
    _updateTimeLabel.font = [UIFont customPingFRegularFontWithSize:9];
    [cellContentView addSubview:_updateTimeLabel];
    [_updateTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftIconImageView);
        make.top.equalTo(self.createTimeLabel.mas_bottom).offset(5);
    }];
    
    _diaryCountLabel = [[PMLBaseLabel alloc] init];
    _diaryCountLabel.textColor = kRGBGrayColor(26);
    _diaryCountLabel.font = [UIFont customPingFRegularFontWithSize:9];
    [cellContentView addSubview:_diaryCountLabel];
    [_diaryCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftIconImageView);
        make.top.equalTo(self.updateTimeLabel.mas_bottom).offset(5);
    }];
    _writeDiaryBtn = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    [_writeDiaryBtn setTitle:kInternationalContent(@"连载") forState:UIControlStateNormal];
    [_writeDiaryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _writeDiaryBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:15];
    [cellContentView addSubview:_writeDiaryBtn];
    [_writeDiaryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftIconImageView);
        make.bottom.equalTo(self.contentImageView.mas_bottom);
        make.width.mas_equalTo(102);
        make.height.mas_equalTo(25);
    }];
    [_writeDiaryBtn setGradientBackgroundWithColors:@[kRGBColor(255, 77, 77),kRGBColor(255, 73, 147)] locations:nil startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
    [self layoutIfNeeded];
    
    [_writeDiaryBtn setCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
    [_contentImageView setCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
    
    cellContentView.layer.cornerRadius = 10;
    cellContentView.layer.shadowColor = kRGBAColor(128, 128, 128, 0.15).CGColor;
    cellContentView.layer.shadowOffset = CGSizeMake(1, 1);
    cellContentView.layer.shadowRadius = 5;
    cellContentView.layer.shadowOpacity = 1.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
