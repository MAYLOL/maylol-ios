//
//  PMLDiaryMenuTableViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/14.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLDiaryMenuTableViewCell.h"

@interface PMLDiaryMenuTableViewCell ()
@property (nonatomic, strong) PMLBaseLabel *contentLabel;
@property (nonatomic, strong) PMLBaseView *redLineView;
@property (nonatomic, strong) PMLBaseView *bottomLineView;
@end

@implementation PMLDiaryMenuTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
//    _contentLabel
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
