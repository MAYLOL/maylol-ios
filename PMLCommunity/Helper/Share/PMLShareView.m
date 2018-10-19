//
//  PMLShareView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/28.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLShareView.h"
#import "PMLFreeButton.h"
#import "PMLSharePlatform.h"
#import "PMLMaskView.h"

static CGFloat const itemHeight = 70;
static CGFloat const itemLeftEdg = 20;
@interface PMLShareView ()
@property (nonatomic, strong) PMLMaskView *maskView;
@property (nonatomic, strong) PMLBaseLabel *titleLabel;
@property (nonatomic, copy) NSArray *imageArray;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, strong) PMLBaseButton *cancelBtn;
@property (nonatomic, strong) PMLBaseScrollView *scrollView;
@end

@implementation PMLShareView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _titleArray = @[@"微信",@"朋友圈",@"QQ",@"QQ空间",@"新浪",@"Facebook",@"Twitter",@"Instagram",@"LINE",@"KakaoTalk"];
        _imageArray = @[@"share_wechat",@"share_friend",@"share_qq",@"share_zone",@"share_sina",@"share_facebook",@"share_twitter",@"share_ins",@"share_line",@"share_kakao"];
    }
    return self;
}

- (void)show
{
    if (_titleLabel) {
        return;
    }
    
    
    self.maskView = [[PMLMaskView alloc] initMaskViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) target:self select:@selector(hidden)];
    self.maskView.alpha = 0.f;
    CGRect frame = self.frame;
    frame.origin.y = kScreenHeight;
    self.frame = frame;
    [kKeyWindow addSubview:self.maskView];
    [kKeyWindow addSubview:self];
    [UIView animateWithDuration:0.5f animations:^{
        CGRect frame = self.frame;
        frame.origin.y = kScreenHeight - self.frame.size.height;
        self.frame = frame;
        self.maskView.alpha = kMaskAlpha;
    } completion:^(BOOL finished) {
        [self setupSubViews];
    }];
    
    
}

- (void)setupSubViews
{
    _scrollView = [[PMLBaseScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - 46)];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.alwaysBounceHorizontal = YES;
    [self addSubview:_scrollView];
    
    _titleLabel = [[PMLBaseLabel alloc] init];
    _titleLabel.text = @"分享至";
    _titleLabel.font = [UIFont customPingFRegularFontWithSize:15];
    _titleLabel.textColor = [UIColor colorWithHex:@"#1a1a1a"];
    [_titleLabel sizeToFit];
    _titleLabel.centerX = self.centerX;
    _titleLabel.y = 20;
    [self addSubview:_titleLabel];
    
    NSInteger count = _titleArray.count;
    CGFloat buttonWidth;
    for (int i = 0; i < count; i++) {
        PMLFreeButton *button = [PMLFreeButton buttonWithType: UIButtonTypeCustom];
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        UIImage *buttonImage = kImageWithName(_imageArray[i]);
        [button setImage:buttonImage forState:UIControlStateNormal];
        [button setImage:buttonImage forState:UIControlStateHighlighted];
        button.titleLabel.font = [UIFont customPingFRegularFontWithSize:11];
        [button setTitleColor:[UIColor colorWithHex:@"#000000"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        CGSize size = [PMLTools sizeForString:[self.titleArray stringAtCheckedIndex:i] font:[UIFont customPingFRegularFontWithSize:11] maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
        
        buttonWidth = (kScreenWidth - itemLeftEdg*6)/5;
        if (buttonWidth < size.width) {
            buttonWidth = size.width;
        }
        button.tag = 20 + i;
        button.frame = CGRectMake(itemLeftEdg + i*(buttonWidth + itemLeftEdg), self.height, buttonWidth, itemHeight);
        
        [button setUpImageViewSize:buttonImage.size margin:7 alignment:PMLFreeBtnAlignmentVerticalFill];
        [_scrollView addSubview:button];
        if (i == count - 1) {
            _scrollView.contentSize = CGSizeMake(button.right + itemLeftEdg, itemHeight);
        }
        
        POPSpringAnimation * anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(button.x, self.height, buttonWidth, itemHeight)];
        anim.toValue =   [NSValue valueWithCGRect:CGRectMake(button.x, self.titleLabel.bottom + 20, buttonWidth, itemHeight)];
        anim.springBounciness = 3; //springBounciness为弹簧弹力 取值范围为【0，20】， 默认为4
        anim.springSpeed = 3; //springSpeed为弹簧速度 速度越快 动画时间越短 取值范围[0,20], 默认为12 和springBounciness一起决定弹簧动画效果
        anim.beginTime = CACurrentMediaTime() + 0.1 * i;  // 开始时间添加延迟
        [button pop_addAnimation:anim forKey:nil];
        [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
            //            self.scrollView.frame = CGRectMake(0, self.titleLabel.bottom + 20, self.width, itemHeight);
        }];
    }
    
    _cancelBtn = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor colorWithHex:@"#000000"] forState:UIControlStateNormal];
    _cancelBtn.titleLabel.font = [UIFont customPingFMediumFontWithSize:15];
    [_cancelBtn addTarget:self action:@selector(cancenShare) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelBtn];
    _cancelBtn.frame = CGRectMake(0, self.height - 45, self.width, 45);
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _cancelBtn.y + 1, self.width, 1)];
    lineView.backgroundColor = kRGBGrayColor(240);
    [self addSubview:lineView];
}

- (void)hidden
{
    [UIView animateWithDuration:0.5f animations:^{
        CGRect frame = self.frame;
        frame.origin.y = kScreenHeight;
        self.frame = frame;
        self.maskView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.maskView removeFromSuperview];
//        self.maskView = nil;
    }];
}

#pragma mark-取消按钮
- (void)cancenShare
{
    [self hidden];
}

#pragma mark-分享按钮
- (void)shareBtnClicked:(PMLFreeButton *)sender
{
    NSInteger tag = sender.tag;
    switch (tag) {
        case 20:
        {
            [self startShare:WXSession];
        }
            break;
        case 21:
        {
            [self startShare:WXTimeLine];
        }
            break;
        case 22:
        {
            [self startShare:QQ];
        }
            break;
        case 23:
        {
            [self startShare:QQZone];
        }
            break;
        case 24:
        {
            [self startShare:Sina];
        }
            break;
        case 25:
        {
            [self startShare:Facebook];
        }
            break;
        case 26:
        {
            [self startShare:Twitter];
        }
            break;
        case 27:
        {
            [self startShare:Instagram];
        }
            break;
        case 28:
        {
            [self startShare:LINE];
        }
            break;
        case 29:
        {
            [self startShare:KaokaoTalk];
        }
            break;
            
            
        default:
            break;
    }
}

- (void)startShare:(NSInteger)platform
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareViewPlatformBtnClickWithPlatform:shareTitle:shareUrl:shareDesc:shareImage:respondVC:)]) {
        [self.delegate shareViewPlatformBtnClickWithPlatform:platform shareTitle:self.shareTitle shareUrl:self.shareUrl shareDesc:self.shareDesc shareImage:self.shareImage respondVC:self.respVC];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
