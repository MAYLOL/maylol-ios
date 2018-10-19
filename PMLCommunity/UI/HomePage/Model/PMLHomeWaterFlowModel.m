//
//  PMLHomeWaterFlowModel.m
//  PMLCommunity
//
//  Created by panchuang on 2018/10/17.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLHomeWaterFlowModel.h"

@implementation PMLHomeWaterFlowModel
- (float)cellHeight {
    if (_cellHeight <= 0) {
        CGFloat itemW = (kScreenWidth - 40)/2;
        CGSize titleSize = [PMLTools sizeForString:self.articleTitle font:[UIFont customPingFRegularFontWithSize:11] maxSize:CGSizeMake(itemW - 16, 25)];
        CGFloat imageHeight = itemW / self.coverWH;
        //UIEdgeInsetsMake.top + 图片高度 + 图片和文章距离 + 文字高度 + 文字和头像距离 + 头像高度 + 头像和金额距离 + 金额高度 + 金额距底部距离
        _cellHeight = 10 + imageHeight + 10 + titleSize.height + 5 + 15 + 5 + 10 + 15;
    }
    return _cellHeight;
}
@end
