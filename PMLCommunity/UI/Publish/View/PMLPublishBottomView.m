//
//  PMLPublishBottomView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/31.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLPublishBottomView.h"
#import "PMLFreeButton.h"
@interface PMLPublishBottomView ()
@property (nonatomic, strong) PMLFreeButton *arrowBtn;
@end

@implementation PMLPublishBottomView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor =kRGBGrayColor(230);
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
    PMLBaseScrollView *baseScrollView = [[PMLBaseScrollView alloc] init];
    baseScrollView.bouncesZoom = YES;
    [self addSubview:baseScrollView];
    [baseScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.right.equalTo(self).offset(-50);
    }];
    
    NSArray *imageArray = @[@"publish_edit_img",@"publish_edit_video",@"publish_edit_set"];
    NSInteger count = imageArray.count;
    CGFloat allButtonWidth = 0;
    for (int i = 0; i < count; i++) {
        PMLBaseButton *button = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
        UIImage *buttonImage = kImageWithName(imageArray[i]);
        [button setImage:buttonImage forState:UIControlStateNormal];
        CGFloat buttonWidth = buttonImage.size.width;
        CGFloat buttonheight= buttonImage.size.height;
        button.frame = CGRectMake(15 + allButtonWidth + 20 * i, (self.height - buttonheight)/2, buttonWidth, buttonheight);
        [button addTarget:self action:@selector(toolItemClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 10 + i;
        [baseScrollView addSubview:button];
        
        if ( count - 1 == i) {
            baseScrollView.contentSize = CGSizeMake(button.right + 15, 0);
        }
        allButtonWidth += buttonWidth;
    }
    
    
    PMLFreeButton *arrowBtn = [PMLFreeButton buttonWithType:UIButtonTypeCustom];
    UIImage *arrowImage = kImageWithName(@"publish_edit_arrow");
    [arrowBtn setImage:arrowImage forState:UIControlStateNormal];
    arrowBtn.frame = CGRectMake(self.width - (30 + arrowImage.size.width), 0, 30 + arrowImage.size.width, self.height);
    [arrowBtn setUpImageViewSize:arrowImage.size margin:0 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    [arrowBtn addTarget:self action:@selector(arrowBtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:arrowBtn];
    self.arrowBtn = arrowBtn;
}

#pragma mark-sender touch
- (void)arrowBtonClicked
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemTouch:)]) {
        [self.delegate itemTouch:3];
    }
}

- (void)toolItemClicked:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemTouch:)]) {
        switch (sender.tag) {
            case 10:
            {
                [self.delegate itemTouch:0];
            }
                break;
            case 11:
            {
                [self.delegate itemTouch:1];
            }
                break;
            case 12:
            {
                [self.delegate itemTouch:2];
            }
                break;
            default:
                break;
        }
    }
    if (self.bottomViewBlock) {
        switch (sender.tag) {
            case 10:
            {
                self.bottomViewBlock(ClickedTypeImage);
            }
                break;
            case 11:
            {
                self.bottomViewBlock(ClickedTypeVideo);
            }
                break;
            case 12:
            {
                self.bottomViewBlock(ClickedTypeSet);
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark-setter
- (void)setArrowHidden:(BOOL)arrowHidden
{
    _arrowHidden = arrowHidden;
    self.arrowBtn.hidden = _arrowHidden;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
