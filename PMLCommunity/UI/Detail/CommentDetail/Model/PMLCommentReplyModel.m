//
//  PMLCommentReplyModel.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLCommentReplyModel.h"

@implementation PMLCommentReplyFrameModel

@end

#define     HEIGHT_MOMENT_DEFAULT       99.0f
@implementation PMLCommentReplyModel

- (PMLCommentReplyFrameModel *)replyFrame
{
    if (_replyFrame == nil) {
        _replyFrame = [[PMLCommentReplyFrameModel alloc] init];
        _replyFrame.height = [PMLCommentReplyModel calculateAttHeightWithReplyDetail:self.content];
        _replyFrame.extHeight = HEIGHT_MOMENT_DEFAULT;
        _replyFrame.extHeight += _replyFrame.height;
    }
    return _replyFrame;
}

//计算回复内容高度
+ (CGFloat)calculateAttHeightWithReplyDetail:(NSString *)replyDetail {

    NSMutableString *detail = [[NSMutableString alloc] initWithString:replyDetail];
    NSMutableParagraphStyle *paragraphTitleStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphTitleStyle.alignment = NSTextAlignmentLeft;
    paragraphTitleStyle.lineSpacing = 0.5;

    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:detail];
    [attString setAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13]} range:NSMakeRange(0, attString.length)];
    [attString addAttribute:NSParagraphStyleAttributeName value:paragraphTitleStyle range:NSMakeRange(0, attString.length)];
    CGRect frame = [attString boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 70 - 16, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return frame.size.height + 4;
}

+ (CGFloat)calculateAttHeightWithTitle:(NSString *)title User:(PMLCommentUserModel *)user toUser:(PMLCommentUserModel *)toUser {
    //title
    NSMutableString *str = [[NSMutableString alloc] init];
    if (user) {
        [str appendString:user.username ?: @""];
        if (toUser) {
            [str appendFormat:@"回复%@: ", toUser.username];
        }
        else {
            [str appendString:@": "];
        }
    }
    [str appendString:title];
    NSMutableParagraphStyle *paragraphTitleStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphTitleStyle.alignment = NSTextAlignmentLeft;
    paragraphTitleStyle.lineSpacing = 0.5;

    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:str];
    [attString setAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13]} range:NSMakeRange(0, attString.length)];
    [attString setAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13]} range:[str rangeOfString:user.username]];

    if (toUser.username.length) {
        [attString setAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:13]} range:NSMakeRange(user.username.length+2, toUser.username.length)];
    }
    [attString setAttributes:@{NSFontAttributeName :[UIFont systemFontOfSize:14]} range:[str rangeOfString:title]];

    [attString addAttribute:NSParagraphStyleAttributeName value:paragraphTitleStyle range:NSMakeRange(0, attString.length)];
    CGRect frame1 = [attString boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 70 - 16, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return frame1.size.height + 4;
}

- (instancetype)initWithFromUser:(PMLCommentUserModel *)fromUser
                          toUser:(PMLCommentUserModel *)toUser
                         content:(NSString *)content
                     praiseCount:(NSString *)praiseCount
                      createTime:(long long)createTime{
    if (self = [super init]) {
        _user = fromUser;
        _toUser = toUser;
        _content = content;
        _praiseCount = praiseCount;
        _createTime = createTime;
    }
    return self;
}
+ (instancetype)initWithFromUser:(PMLCommentUserModel *)fromUser
                          toUser:(PMLCommentUserModel *)toUser
                         content:(NSString *)content
                     praiseCount:(NSString *)praiseCount
                      createTime:(long long)createTime{
    PMLCommentReplyModel *replyModel = [[PMLCommentReplyModel alloc] initWithFromUser:fromUser toUser:toUser content:content praiseCount:praiseCount createTime:createTime];
    return replyModel;
}
@end
