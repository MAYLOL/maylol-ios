//
//  PMLTopicSectionHeaderView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/12.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLTopicSectionHeaderView.h"

@interface PMLTopicSectionHeaderView ()
@property (nonatomic, strong) PMLBaseLabel *topicTypeLabel;
@property (nonatomic, strong) PMLBaseLabel *checkAllLabel;

@end

@implementation PMLTopicSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewTouch)]];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    _topicTypeLabel = [[PMLBaseLabel alloc] init];
    _topicTypeLabel.textColor = kRGBGrayColor(26);
    _topicTypeLabel.font = [UIFont customPingFSemiboldFontWithSize:16];
    [self addSubview:_topicTypeLabel];
    
    _checkAllLabel = [[PMLBaseLabel alloc] init];
    _checkAllLabel.textColor = kRGBGrayColor(26);
    _checkAllLabel.font = [UIFont customPingFRegularFontWithSize:11];
    _checkAllLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_checkAllLabel];
    _checkAllLabel.text = kInternationalContent(@"查看全部");
}

- (void)headerViewTouch {
    if (self.headerViewBlock) {
        self.headerViewBlock(self.headerIndex);
    }
}

- (void)setTypeString:(NSString *)typeString {
    _typeString = typeString;
    self.topicTypeLabel.text = _typeString;
}

- (void)setHeaderIndex:(NSInteger)headerIndex {
    _headerIndex = headerIndex;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _topicTypeLabel.frame = CGRectMake(15, self.height - 18 - 5, 100, 18);
    _checkAllLabel.frame = CGRectMake(self.width - 15 - 50, self.height - 12 - 5, 50, 12);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
