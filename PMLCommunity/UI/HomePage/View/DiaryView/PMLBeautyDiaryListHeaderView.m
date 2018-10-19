//
//  PMLBeautyDiaryListHeaderView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBeautyDiaryListHeaderView.h"
#import "PMLFreeButton.h"
@interface PMLBeautyDiaryListHeaderView ()
@property (nonatomic, strong) PMLBaseButton *myDiaryBtn;
@property (nonatomic, strong) PMLBaseButton *diaryTypeBtn;
@property (nonatomic, strong) PMLBaseButton *arrowBtn;
@property (nonatomic, strong) PMLBaseButton *latestDiaryBtn;
@end

@implementation PMLBeautyDiaryListHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    PMLBaseView *bottomLineView = [[PMLBaseView alloc] init];
    bottomLineView.backgroundColor = kRGBGrayColor(240);
    [self addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    PMLBaseView *leftLineView = [[PMLBaseView alloc] init];
    leftLineView.backgroundColor = kRGBGrayColor(184);
    [self addSubview:leftLineView];
    [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(10);
        make.centerX.equalTo(self).multipliedBy(0.65);
    }];
    
    PMLBaseView *rightLineView = [[PMLBaseView alloc] init];
    rightLineView.backgroundColor = kRGBGrayColor(184);
    [self addSubview:rightLineView];
    [rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(10);
        make.centerX.equalTo(self).multipliedBy(1.35);
    }];
    
    _myDiaryBtn = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    [_myDiaryBtn setTitle:kInternationalContent(@"我的日记") forState:UIControlStateNormal];
    [_myDiaryBtn setTitleColor:kRGBGrayColor(102) forState:UIControlStateNormal];
    [_myDiaryBtn setTitleColor:kRGBGrayColor(26) forState:UIControlStateSelected];
    _myDiaryBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:12];
    _myDiaryBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _myDiaryBtn.tag = 1;
    [_myDiaryBtn addTarget:self action:@selector(headerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_myDiaryBtn];
    [_myDiaryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.right.equalTo(leftLineView.mas_left);
    }];
    
    _arrowBtn = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    UIImage *arrowImage = kImageWithName(@"beautiful_icon_return_gray");
    [_arrowBtn setImage:arrowImage forState:UIControlStateNormal];
//    [_arrowBtn setImage:kImageWithName(@"beautiful_icon_return_red") forState:UIControlStateSelected];
    [self addSubview:_arrowBtn];
    [_arrowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(rightLineView.mas_left).offset(-3);
        make.size.mas_equalTo(arrowImage.size);
    }];
    
    _diaryTypeBtn = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    [_diaryTypeBtn setTitle:kInternationalContent(@"自体脂肪填充爱神的箭奥斯卡的") forState:UIControlStateNormal];
    _diaryTypeBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:12];
    _diaryTypeBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_diaryTypeBtn setTitleColor:kRGBGrayColor(102) forState:UIControlStateNormal];
    [_diaryTypeBtn setTitleColor:kRGBGrayColor(26) forState:UIControlStateSelected];
    _diaryTypeBtn.tag = 2;
    [_diaryTypeBtn addTarget:self action:@selector(headerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _diaryTypeBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:_diaryTypeBtn];
    [_diaryTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(leftLineView.mas_right);
        make.right.equalTo(self.arrowBtn.mas_left);
    }];
    
    _latestDiaryBtn = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    [_latestDiaryBtn setTitle:kInternationalContent(@"最新日记") forState:UIControlStateNormal];
    [_latestDiaryBtn setTitleColor:kRGBGrayColor(102) forState:UIControlStateNormal];
    [_latestDiaryBtn setTitleColor:kRGBGrayColor(26) forState:UIControlStateSelected];
    _latestDiaryBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:12];
    _latestDiaryBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _latestDiaryBtn.tag = 3;
    [_latestDiaryBtn addTarget:self action:@selector(headerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_latestDiaryBtn];
    [_latestDiaryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.left.equalTo(rightLineView.mas_right);
    }];
    
}

- (void)headerBtnClicked:(UIButton *)sender {
    if (!sender.selected) {
        for (int i = 1; i < 4; i++) {
            PMLBaseButton *button = (PMLBaseButton *)[self viewWithTag:i];
            button.selected = NO;
            if (i == 2) {
                [PMLTools rotationImageWithImageView:self.arrowBtn.imageView radian:2 * M_PI complete:^(UIImage *image) {
                    
                }];
            }
        }
        sender.selected = YES;
    }else{
        if (sender.tag == 2 && self.diaryHeaderBlock) {
            if (self.arrowBtn.selected) {
                [PMLTools rotationImageWithImageView:self.arrowBtn.imageView radian:2 * M_PI complete:^(UIImage *image) {
                    
                }];
            }else {
                [PMLTools rotationImageWithImageView:self.arrowBtn.imageView radian:M_PI complete:^(UIImage *image) {
                    
                }];
            }
            self.arrowBtn.selected  = !self.arrowBtn.selected;
            
        }
        return;
    }
    if (self.diaryHeaderBlock) {
        switch (sender.tag) {
            case 1:
            {
                self.diaryHeaderBlock(MyDiary);
            }
                break;
            case 2:
            {
                [PMLTools rotationImageWithImageView:self.arrowBtn.imageView radian:M_PI complete:^(UIImage *image) {
                    
                }];
                self.arrowBtn.selected = YES;
               self.diaryHeaderBlock(ChangeDiary);
            }
                break;
            case 3:
            {
                self.diaryHeaderBlock(LatestDiary);
            }
                break;
            default:
                break;
        }
    }
}

- (void)setselectBtn:(NSInteger)index {
    _selectIndex = index;
    for (int i = 1; i < 4; i++) {
        PMLBaseButton *button = (PMLBaseButton *)[self viewWithTag:i];
        if (i == _selectIndex) {
            button.selected = YES;
        }else{
            button.selected = NO;
        }
    }
    
    if (2 == _selectIndex) {
        self.arrowBtn.selected = YES;
    }else {
        self.arrowBtn.selected = NO;
    }
}

- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex + 1;
    if (_selectIndex >= 1 && _selectIndex <= 3) {
        [self headerBtnClicked:(UIButton *)[self viewWithTag:_selectIndex]];
    }
}

@end
