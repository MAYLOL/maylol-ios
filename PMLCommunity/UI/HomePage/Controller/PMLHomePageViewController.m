//
//  PMLHomePageViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLHomePageViewController.h"
#import "PMLHomeCommunityViewController.h"
#import "PMLHomeAttentionViewController.h"
#import "PMLHomeTopicViewController.h"
#import "PMLSearchViewController.h"
#import "PMLLeftColumnView.h"
#import "PMLAutoScrollView.h"
#import "PMLBaseNavigationViewController.h"


#import "PMLPublishArticleViewController.h"
#import "PMLCommunity-Swift.h"
#import "PMLLoginViewController.h"
#import "PMLFillInfoViewController.h"


static CGFloat const animationDelay = 0.01;

@interface PMLHomePageViewController ()<PMLAutoScrollViewDelegate,UIScrollViewDelegate>
//社区控制器
@property (nonatomic, strong) PMLHomeCommunityViewController *communityVC;
//关注控制器
@property (nonatomic, strong) PMLHomeAttentionViewController *attentionVC;
//话题控制器
@property (nonatomic, strong) PMLHomeTopicViewController *topicVC;
//当前展示的控制器
@property (nonatomic, strong) UIViewController *currentVC;
//nav Title
@property (nonatomic, strong) PMLAutoScrollView *titleScrollView;
//基础的ScrollView
@property (nonatomic, strong) UIScrollView *baseScrollView;
//悬浮按钮
@property (nonatomic, strong) UIButton *suspensionBtn;
//遮罩视图
@property (nonatomic, strong) PMLMaskView *maskView;
//左边栏
@property (nonatomic, strong) PMLLeftColumnView *leftColumnView;
@property (nonatomic, strong) UIButton *test1Btn;
@property (nonatomic, strong) UIButton *test2Btn;
@property (nonatomic, strong) UIButton *test3Btn;
@property (nonatomic, strong) UIButton *test4Btn;
@end

@implementation PMLHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNavtionalBar];
    [self setUpBaseScrollView];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.suspensionBtn.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.suspensionBtn.hidden = YES;
}

- (void)setUpNavtionalBar
{
    CGSize itemSize = [PMLTools sizeForString:kInternationalContent(@"关注") font:kDefauleFont(15) maxSize:CGSizeMake(100, 100)];
    CGFloat itemMargin = kScreenWidth * 60/750;
    self.titleScrollView = [[PMLAutoScrollView alloc] initWithFrame:CGRectMake(0, 0,itemSize.width * 3 + 2 * itemMargin, itemSize.height) delegate:self dataSource:@[kInternationalContent(@"关注"),kInternationalContent(@"社区"),kInternationalContent(@"话题")] defaultSelectIndex:1];
//    self.titleScrollView.labelFont = 15;
    self.titleScrollView.selectColor = kRGBColor(26, 26, 26);
    self.titleScrollView.normalColor = kRGBColor(102, 102, 102);
    self.titleScrollView.normalFont = [UIFont customPingFMediumFontWithSize:15];
    self.titleScrollView.selectFont = [UIFont customPingFSemiboldFontWithSize:15];
    self.titleScrollView.itemMargin = itemMargin;
    self.navigationItem.titleView = self.titleScrollView;
    [self addNavLeftButton:@"home_nav_btn_more"];
    
    UIBarButtonItem *searchItem = [self createBarBtnWithContent:kImageWithName(@"home_nav_icon_search") target:self sel:@selector(searchBtnClicked)];
    UIBarButtonItem *sortingItem = [self createBarBtnWithContent:kImageWithName(@"home_nav_icon_rank") target:self sel:@selector(sortingBtnClicked)];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = kScreenWidth * 50/750;
    self.navigationItem.rightBarButtonItems = @[searchItem,spaceItem,sortingItem];
}

- (void)setUpBaseScrollView
{
    self.baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height - kTabBar - kNavBarHeight)];
    self.baseScrollView.delegate = self;
    self.baseScrollView.bounces = NO;
    self.baseScrollView.pagingEnabled = YES;
    self.baseScrollView.showsHorizontalScrollIndicator = NO;
    self.baseScrollView.showsVerticalScrollIndicator = NO;
    self.baseScrollView.contentSize = CGSizeMake(kScreenWidth * 3, 0);
    self.baseScrollView.contentOffset = CGPointMake(kScreenWidth, 0);
    [self.view addSubview:self.baseScrollView];
    
    self.attentionVC = [[PMLHomeAttentionViewController alloc] init];
    self.attentionVC.view.frame = CGRectMake(0, 0, kScreenWidth, self.view.height - kTabBar - kNavBarHeight);
    [self addChildViewController:self.attentionVC];
    [self.baseScrollView addSubview:self.attentionVC.view];
    
    self.communityVC = [[PMLHomeCommunityViewController alloc] init];
    self.communityVC.view.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, self.view.height - kTabBar - kNavBarHeight);
    [self addChildViewController:self.communityVC];
    [self.baseScrollView addSubview:self.communityVC.view];
    
    self.topicVC = [[PMLHomeTopicViewController alloc] init];
    self.topicVC.view.frame = CGRectMake(2 * kScreenWidth, 0, kScreenWidth, self.view.height - kTabBar - kNavBarHeight);
    [self addChildViewController:self.topicVC];
    [self.baseScrollView addSubview:self.topicVC.view];
    //初始化时设置当前控制器为社区控制器
    self.currentVC = self.communityVC;
    
    self.suspensionBtn = [self createButtonWithTitle:nil normalImg:@"home_suspension_icon" selectedImg:@"home_suspension_icon" target:self sel:@selector(suspensionBtnClicked:)];
    UIImage *susImage = kImageWithName(@"home_suspension_icon");
    self.suspensionBtn.frame = CGRectMake(kScreenWidth - susImage.size.width - 10, kScreenHeight * 416/667, susImage.size.width, susImage.size.height);
    [kApplication.keyWindow addSubview:self.suspensionBtn];
}

#pragma mark-UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGFloat offSet = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offSet = scrollView.contentOffset.x;
    self.titleScrollView.selectIndex = offSet/kScreenWidth;
}

#pragma mark-PMLAutoScrollViewDelegate
- (void)autoScrollView:(PMLAutoScrollView *)autoScrollView didSelectAtIndex:(NSInteger)index
{
    if (autoScrollView == self.titleScrollView) {
        [UIView animateWithDuration:0.2f animations:^{
            self.baseScrollView.contentOffset = CGPointMake(kScreenWidth * index, 0);
        }];
    }
}

#pragma mark-sender touch

- (void)navLeftButtonClick
{
    self.leftColumnView = [[PMLLeftColumnView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    WeakSelf(weakSelf);
    weakSelf.leftColumnView.touchBlock = ^{
        [weakSelf.leftColumnView removeFromSuperview];
        weakSelf.leftColumnView = nil;
    };
    [self.leftColumnView show];
    [kKeyWindow addSubview:self.leftColumnView];
}

//搜索按钮点击事件
- (void)searchBtnClicked
{
    if ([self isLogin]) {
        [self pushViewControllerWithClassName:NSStringFromClass([PMLSearchViewController class]) params:nil];
    }
    
}

//排序按钮点击事件
- (void)sortingBtnClicked
{
//    PMLBaseNavigationViewController *nav = [[PMLBaseNavigationViewController alloc] initWithRootViewController:[[PMLLoginViewController alloc] init]];
//    [self presentViewController:nav animated:YES completion:nil];
//    [self presentViewControllerWithClassName:NSStringFromClass([PMLPublishArticleViewController class]) params:nil animated:YES completion:nil];
//    IQKeyboardManager.shared().isEnabled = false
    
    [self pushViewControllerWithNibName:NSStringFromClass([PMLFillInfoViewController class]) params:nil];
    
//
//    [self presentViewController:viewcontroller animated:YES completion:nil];
//    [self pushViewControllerWithClassName:NSStringFromClass([PMLPublishArticleViewController class]) params:nil];

}
//悬浮框的点击事件
- (void)suspensionBtnClicked:(UIButton *)sender
{
    sender.selected = !sender.selected;
    sender.enabled = NO;
    if (sender.selected) {
        self.maskView = [[PMLMaskView alloc] initMaskViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) target:self select:@selector(maskViewTouch)];
        [kApplication.keyWindow addSubview:self.maskView];
        [kApplication.keyWindow bringSubviewToFront:self.suspensionBtn];
        for (int i = 1; i < 6; i++) {
            UIButton *testBtn = [self createAnimationButtonWithTag:i];
            POPSpringAnimation *anima = [self popAnimationWithfromValue:[NSValue valueWithCGPoint:self.suspensionBtn.center] toValue:[NSValue valueWithCGPoint:[PMLTools calcCircleCoordinateWithCenter:self.suspensionBtn.center andWithAngle:90+180*(i-1)/4 andWithRadius:self.suspensionBtn.centerX/4]] beginTime:CACurrentMediaTime() + animationDelay * i];
            [testBtn pop_addAnimation:anima forKey:nil];

            switch (i) {
                case 0:
                {
                    self.test1Btn = testBtn;
                }
                    break;
                case 1:
                {
                    self.test2Btn = testBtn;
                }
                    break;
                case 2:
                {
                    self.test3Btn = testBtn;
                }
                    break;
                case 3:
                {
                    self.test4Btn = testBtn;
                }
                    break;
                    
                default:
                    break;
            }
        }
        [self.view bringSubviewToFront:self.suspensionBtn];
    }else {
        for (int i = 1; i < 6; i++) {
            UIButton *button = [kApplication.keyWindow viewWithTag:100+i];

            [self.maskView removeFromSuperview];
            [button removeFromSuperview];
            button = nil;
            sender.enabled = YES;
        }
    }
}

- (POPSpringAnimation *)popAnimationWithfromValue:(NSValue *)fromValue toValue:(NSValue *)toValue beginTime:(double)beginTime{
    POPSpringAnimation *anima = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anima.fromValue = fromValue;
    anima.toValue = toValue;
    anima.springSpeed = 10;
    anima.springBounciness = 10;
    anima.beginTime = beginTime;
    return anima;
}

- (void)maskViewTouch
{
    [self suspensionBtnClicked:self.suspensionBtn];
}

- (UIButton *)createAnimationButtonWithTag:(NSInteger)tag {
    NSString *imageStr;
    if (tag == 1) {
        imageStr = @"home_publish_article";
    }else if (tag == 2) {
        imageStr = @"home_publish_topic";
    }else if (tag == 3) {
        imageStr = @"home_beauty_diary";
    }else if (tag == 4) {
        imageStr = @"home_share";
    }else {
        imageStr = @"home_community_intr";
    }
    UIButton *item = [self createButtonWithTitle:nil normalImg:imageStr selectedImg:imageStr target:self sel:@selector(functionItemClicked:)];
    item.tag = 100 + tag;
    item.frame = CGRectMake(0, 0, 44, 44);
    item.center = self.suspensionBtn.center;
    [kApplication.keyWindow addSubview:item];
    return item;
}

- (void)functionItemClicked:(UIButton *)sender {
    [self maskViewTouch];
//    if (sender.tag < 104) {
//        if (![self isLogin]) {
//            return;
//        }
//    }
    switch (sender.tag) {
        case 101:
        {
            //发文字
            [IQKeyboardManager sharedManager].enable = NO;
            PMLPublishViewController *viewcontroller= [[PMLPublishViewController alloc] initWithSampleHTML:nil wordPressMode:false source:0];
            [self.navigationController pushViewController:viewcontroller animated:YES];
        }
            break;
        case 102:
        {
            //发话题
            if ([self isLogin]) {
                
            }
        }
            break;
        case 103:
        {
            //发美丽日记
        }
            break;
        case 104:
        {
            //分享
        }
            break;
        case 105:
        {
            //社区内容
        }
            break;
            
        default:
            break;
    }
}
#pragma mark-lazy load

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
