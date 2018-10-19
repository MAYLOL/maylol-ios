//
//  PMLCustomeButton.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/16.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLFreeButton.h"

@interface PMLFreeButton ()
@property (nonatomic, assign) PMLFreeBtnAlignment btnAlignment;
@end

@implementation PMLFreeButton

- (void)setUpImageViewSize:(CGSize)imageSize margin:(CGFloat)margin alignment:(PMLFreeBtnAlignment)alignment {
    self.imageSize = imageSize;
    self.margin = margin;
    self.btnAlignment = alignment;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize textSize = [PMLTools sizeForString:self.titleLabel.text font:self.titleLabel.font maxSize:CGSizeMake(100, self.height)];

    switch (self.btnAlignment) {
        case PMLFreeBtnAlignmentHorizontalLeft:
            {
                self.imageView.frame = CGRectMake(0, (self.height - self.imageSize.height)/2, self.imageSize.width, self.imageSize.height);
                self.titleLabel.frame = CGRectMake(self.imageSize.width + self.margin, 0, textSize.width, self.height);
            }
            break;
        case PMLFreeBtnAlignmentHorizontalCenter:
        {
            self.imageView.frame = CGRectMake((self.width - self.margin)/2 - self.imageSize.width, (self.height - self.imageSize.height)/2, self.imageSize.width, self.imageSize.height);
            self.titleLabel.frame = CGRectMake((self.width + self.margin)/2, 0, textSize.width, self.height);
        }
            break;
        case PMLFreeBtnAlignmentHorizontalRight:
        {
            self.imageView.frame = CGRectMake(self.width - self.imageSize.width, (self.height - self.imageSize.height)/2, self.imageSize.width, self.imageSize.height);
            self.titleLabel.frame = CGRectMake(self.imageView.x - self.margin - textSize.width, (self.height - textSize.height)/2, textSize.width, textSize.height);
        }
            break;
        case PMLFreeBtnAlignmentVerticalLeft:
        {
            self.titleLabel.frame = CGRectMake(0, (self.height + self.margin)/2, textSize.width, textSize.height);
            self.imageView.frame = CGRectMake(0, (self.height - self.margin)/2 - self.imageSize.height, self.imageSize.width, self.imageSize.height);
        }
            break;
        case PMLFreeBtnAlignmentVerticalCenter:
        {
            self.titleLabel.frame = CGRectMake((self.width - textSize.width)/2, (self.height + self.margin)/2, textSize.width, textSize.height);
            self.imageView.frame = CGRectMake((self.width - self.imageSize.width)/2, (self.height - self.margin)/2 - self.imageSize.height, self.imageSize.width, self.imageSize.height);
        }
            break;
        case PMLFreeBtnAlignmentVerticalRight:
        {
            self.titleLabel.frame = CGRectMake(self.width - textSize.width, (self.height + self.margin)/2, textSize.width, textSize.height);
            self.imageView.frame = CGRectMake(self.width - self.imageSize.width, (self.height - self.margin)/2 - self.imageSize.height, self.imageSize.width, self.imageSize.height);
        }
            break;
        case PMLFreeBtnAlignmentVerticalFill:
        {
            self.titleLabel.frame = CGRectMake((self.width - textSize.width)/2, self.height - textSize.height, textSize.width, textSize.height);
            self.imageView.frame = CGRectMake((self.width - self.imageSize.width)/2, 0, self.imageSize.width, self.imageSize.height);
        }
            break;
        default:
            break;
    }
    
}

- (void)dealloc {
    NSLog(@"%@------%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
