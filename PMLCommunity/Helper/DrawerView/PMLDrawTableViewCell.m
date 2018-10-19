//
//  PMLDrawTableViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/20.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLDrawTableViewCell.h"
#import "PMLDrawerView.h"

@interface PMLDrawTableViewCell ()
@property (nonatomic, strong) PMLBaseView *leftRedView;
@property (nonatomic, strong) PMLBaseLabel *centerLabel;
@property (nonatomic, strong) PMLBaseView *bottomLineView;//cell contentview底部线
@end

@implementation PMLDrawTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    _leftRedView = [[PMLBaseView alloc] init];
    _leftRedView.backgroundColor = kRGBColor(240, 46, 68);
    
    _centerLabel = [[PMLBaseLabel alloc] init];
    _centerLabel.textColor = kRGBGrayColor(102);
    _centerLabel.font = [UIFont customPingFRegularFontWithSize:12];
    [self.contentView addSubview:_centerLabel];
    [_centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(22);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    _bottomLineView = [[PMLBaseView alloc] init];
    _bottomLineView.backgroundColor = kRGBGrayColor(230);
    [self.contentView addSubview:_bottomLineView];
    
    if (self.reuseIdentifier == DrawLeftTableViewCellId) {
        [self.contentView addSubview:_leftRedView];
        self.backgroundColor = kRGBGrayColor(240);
        [_leftRedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(4);
            make.bottom.equalTo(self.contentView).offset(-4);
            make.width.mas_equalTo(1);
        }];
    }else if (self.reuseIdentifier == DrawCenterTableViewCellId) {
        [self.contentView addSubview:_leftRedView];
        [_leftRedView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(14);
            make.bottom.equalTo(self.contentView).offset(-14);
            make.width.mas_equalTo(1);
        }];
        [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.centerLabel).offset(-10);
            make.right.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(1);
        }];
        
    }else {
        _leftRedView.hidden = YES;
        [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.centerLabel);
            make.bottom.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-15);
            make.height.mas_equalTo(1);
        }];
    }
}

- (void)setDataModel:(PMLDrawerModel *)dataModel {
    _dataModel = dataModel;
    _centerLabel.text = _dataModel.content;
    if (_dataModel.selected) {
        _centerLabel.textColor = kRGBColor(240, 46, 68);
        _leftRedView.hidden = NO;
        self.contentView.backgroundColor = [UIColor whiteColor];
    }else {
        _centerLabel.textColor = kRGBGrayColor(102);
        _leftRedView.hidden = YES;
        if (self.reuseIdentifier == DrawLeftTableViewCellId) {
            self.contentView.backgroundColor = kRGBGrayColor(240);
        }
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    selected = NO;
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
