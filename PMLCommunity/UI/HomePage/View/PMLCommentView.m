//
//  PMLCommentView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/18.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLCommentView.h"
#import "UITextView+WZB.h"
#import "PMLBaseTextView.h"

@interface PMLCommentView ()
@property (nonatomic, strong) PMLBaseView *fieldSuperView;

@property (nonatomic, strong) UITextView *commentTextView;
@end

@implementation PMLCommentView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    PMLBaseView *lineView = [[PMLBaseView alloc] init];
    lineView.backgroundColor = kRGBGrayColor(240);
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    _fieldSuperView = [[PMLBaseView alloc] init];
    _fieldSuperView.backgroundColor = kRGBGrayColor(240);
    [self addSubview:_fieldSuperView];
    [_fieldSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(500.0/750);
        make.height.mas_equalTo(33);
    }];
    
    _commentTextView = [[UITextView alloc] init];
    _commentTextView.wzb_placeholder = kInternationalContent(@"添加评论...");
    _commentTextView.wzb_placeholderColor = kRGBGrayColor(100);
    _commentTextView.returnKeyType = UIReturnKeySend;
    [_commentTextView sizeToFit];
    _commentTextView.font = [UIFont customPingFRegularFontWithSize:11];
    _commentTextView.backgroundColor = [UIColor clearColor];
    [_fieldSuperView addSubview:_commentTextView];
    [_commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fieldSuperView).offset(13);
        make.right.equalTo(self.fieldSuperView).offset(-13);
        make.top.bottom.equalTo(self.fieldSuperView);
    }];
    
    PMLFreeButton *commentBtn = [PMLFreeButton buttonWithType:UIButtonTypeCustom];
    [commentBtn setTitle:kInternationalContent(@"评论") forState:UIControlStateNormal];
    [commentBtn setTitleColor:kRGBGrayColor(100) forState:UIControlStateNormal];
    commentBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:8];
    UIImage *commentImage = kImageWithName(@"topic_comment");
    [commentBtn setImage:commentImage forState:UIControlStateNormal];
    [commentBtn sizeToFit];
    [self addSubview:commentBtn];
    [commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fieldSuperView.mas_right).offset(20);
        make.centerY.equalTo(self).multipliedBy(1.1);
    }];
    [commentBtn setUpImageViewSize:commentImage.size margin:3 alignment:PMLFreeBtnAlignmentVerticalCenter];
    
    PMLFreeButton *likeBtn = [PMLFreeButton buttonWithType:UIButtonTypeCustom];
    [likeBtn setTitle:kInternationalContent(@"喜欢") forState:UIControlStateNormal];
    [likeBtn setTitleColor:kRGBGrayColor(100) forState:UIControlStateNormal];
    likeBtn.titleLabel.font = [UIFont customPingFRegularFontWithSize:8];
    UIImage *likeImage = kImageWithName(@"topic_like");
    [likeBtn setImage:likeImage forState:UIControlStateNormal];
    [likeBtn sizeToFit];
    [self addSubview:likeBtn];
    [likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(commentBtn.mas_right).offset(20);
        make.centerY.equalTo(self).multipliedBy(1.1);
    }];
    [likeBtn setUpImageViewSize:likeImage.size margin:3 alignment:PMLFreeBtnAlignmentVerticalCenter];
    [self layoutIfNeeded];
    [_fieldSuperView setCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(15, 15)];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
