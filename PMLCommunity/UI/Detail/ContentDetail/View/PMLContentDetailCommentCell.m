//
//  PMLContentDetailCommentCell.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/14.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLContentDetailCommentCell.h"
#import "PMLCommentDetailView.h"

@interface PMLContentDetailCommentCell()

@end

@implementation PMLContentDetailCommentCell
- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.detailView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (PMLCommentDetailView *)detailView {
    if (!_detailView){
        _detailView = [[PMLCommentDetailView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _detailView.isHeader = true;
    }
    return _detailView;
}
@end
