//
//  PMLCommentDetailHeaderView.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLCommentDetailHeaderView.h"
#import "PMLFreeButton.h"
#import "PMLTools.h"

@interface PMLCommentDetailHeaderView()
@property (nonatomic, strong)PMLFreeButton *commentBtn;
@property (nonatomic, strong)UIImageView *dottedLineImageView;
@end

@implementation PMLCommentDetailHeaderView

- (instancetype)init {

    if (self = [super init]){
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.dottedLineImageView];
    [self addSubview:self.commentBtn];

}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.dottedLineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dottedLineImageView.mas_bottom).offset(16);
        make.left.equalTo(self.mas_left).offset(25);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(30);
    }];
}

- (void)setCommentCount:(NSInteger)commentCount {
    _commentCount = commentCount;
    NSString *commentC = [NSString stringWithFormat:@"%@%ld%@",kInternationalContent(@"评论"), commentCount, kInternationalContent(@"条")];
    CGFloat width = [PMLTools sizeForString:commentC font:[UIFont systemFontOfSize:11] maxSize:CGSizeMake(kScreenWidth - 50, 30)].width;
    [self.commentBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width + 50);
    }];
    //获取文字宽高
    [self.commentBtn setTitle:commentC forState:UIControlStateNormal];
}

- (void)commentClicked:(UIButton *)sender {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(gotoCommentListPage)]){
        [self.delegate gotoCommentListPage];
    }
}

- (PMLFreeButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [PMLFreeButton buttonWithType:UIButtonTypeCustom];
        UIImage *praiseImage = kImageWithName(@"home_follow_icon_coment");
        [_commentBtn setImage:praiseImage forState:UIControlStateNormal];
        [_commentBtn setTitleColor:[UIColor colorWithHex:@"#000000"] forState:UIControlStateNormal];
        _commentBtn.tag = 10001;
        _commentBtn.titleLabel.font = [UIFont customPingFMediumFontWithSize:10];
        [_commentBtn setUpImageViewSize:praiseImage.size margin:2 alignment:PMLFreeBtnAlignmentHorizontalLeft];
        [_commentBtn addTarget:self action:@selector(commentClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}

- (UIImageView *)dottedLineImageView {
    if (!_dottedLineImageView){
        _dottedLineImageView = [[UIImageView alloc] initWithImage:kImageWithName(@"dotted_line")];
    }
    return _dottedLineImageView;
}
@end
