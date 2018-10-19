//
//  PMLTextAttachment.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/4.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLTextAttachment.h"

@implementation PMLTextAttachment
- (CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex
{
    //调整图片大小
    return CGRectMake(kScreenWidth/2-_imageSize.width/2, 0, _imageSize.width, _imageSize.height);
}
@end
