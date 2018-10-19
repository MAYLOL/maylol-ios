//
//  PMLCommentDetailModel.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLCommentDetailModel.h"

#define     WIDTH_MOMENT_CONTENT        ([UIScreen mainScreen].bounds.size.width - 70.0f)

@implementation PMLCommentDetailFrameModel

@end

@implementation PMLCommentDetailModel

- (CGFloat)heightText
{
    if (self.text.length > 0) {
        CGFloat textHeight = [self.text boundingRectWithSize:CGSizeMake(WIDTH_MOMENT_CONTENT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:15.0f]} context:nil].size.height;
        //???: 浮点数会导致部分cell顶部多出来一条线，莫名其妙！！！
        return textHeight + 1.0;
    }
    return 0.0f;
}

- (CGFloat)heightText2
{
    if (self.text.length > 0) {
        NSString *str = [NSString stringWithFormat:@"heightText2heightText2%@",self.text];
        CGFloat textHeight = [str boundingRectWithSize:CGSizeMake(WIDTH_MOMENT_CONTENT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : [UIFont systemFontOfSize:11]} context:nil].size.height;
        //???: 浮点数会导致部分cell顶部多出来一条线，莫名其妙！！！
        return textHeight + 1.0;
    }
    return 0.0f;
}

- (CGFloat)heightImages
{
    return 0;
}

#pragma mark - # Getter
- (PMLCommentDetailFrameModel *)detailFrame
{
    if (_detailFrame == nil) {
        _detailFrame = [[PMLCommentDetailFrameModel alloc] init];
        _detailFrame.height = 0.0f;
        _detailFrame.height += _detailFrame.heightText = [self heightText];
        _detailFrame.height2 += _detailFrame.heightText2 = [self heightText2];
    }
    return _detailFrame;
}

- (instancetype)initWithCommentText:(NSString *)commentText {

    if (self = [super init]){
        _text = commentText;
    }
    return self;
}

+ (instancetype)initWithCommentText:(NSString *)commentText {
    PMLCommentDetailModel *detailModel = [[PMLCommentDetailModel alloc] initWithCommentText:commentText];
    return detailModel;
}

@end

