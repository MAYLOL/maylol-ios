//
//  PMLTextAttachment.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/4.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMLTextAttachment : NSTextAttachment
//富文本中的图片标识
@property(nonatomic, copy) NSString *imageFlag;
@property(nonatomic, assign) CGSize imageSize;
@end
