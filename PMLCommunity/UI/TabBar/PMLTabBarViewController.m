//
//  PMLTabBarViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLTabBarViewController.h"
#import "PMLBaseNavigationViewController.h"
#import "PMLPersonalCenterViewController.h"
#import "PMLActivityViewController.h"
#import "PMLHotSpotViewController.h"
#import "PMLHomePageViewController.h"
#import "PMLGamesViewController.h"

@interface PMLTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation PMLTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpSubViewControllers];
    self.tabBar.shadowImage = [UIImage new];
    self.tabBar.backgroundImage = [UIImage new];
    // Do any additional setup after loading the view.
}

- (void)setUpSubViewControllers
{
    [self addSubViewControllerWithViewController:[PMLHomePageViewController new] title:kInternationalContent(@"首页") normalImageName:@"home_tab_home_normal" selectImageName:@"home_tab_home_press"];
    [self addSubViewControllerWithViewController:[PMLHotSpotViewController new] title:kInternationalContent(@"热点") normalImageName:@"home_tab_hot_mormal" selectImageName:@"home_tab_hot_press"];
    [self addSubViewControllerWithViewController:[PMLGamesViewController new] title:nil normalImageName:@"home_tab_play_normal" selectImageName:@"home_tab_play_normal"];
    [self addSubViewControllerWithViewController:[PMLActivityViewController new] title:kInternationalContent(@"活动") normalImageName:@"home_tab_activity_normal" selectImageName:@"home_tab_activity_press"];
    [self addSubViewControllerWithViewController:[PMLPersonalCenterViewController new] title:kInternationalContent(@"个人中心") normalImageName:@"home_tab_me_normal" selectImageName:@"home_tab_me_press"];
}

- (void)addSubViewControllerWithViewController:(UIViewController *)viewController title:(NSString *)title normalImageName:(NSString *)normalImageName selectImageName:(NSString *)selectImageName
{
    PMLBaseNavigationViewController *naVC = [[PMLBaseNavigationViewController alloc] initWithRootViewController:viewController];
    naVC.tabBarItem.image = [kImageWithName(normalImageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    naVC.tabBarItem.selectedImage = [kImageWithName(selectImageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    if (![viewController isKindOfClass:[PMLGamesViewController class]]) {
        naVC.tabBarItem.title = title;
        [naVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHex:@"#666666"],NSFontAttributeName:kDefauleFont(10)} forState:UIControlStateNormal];
        [naVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:kRedColor,NSFontAttributeName:kDefauleFont(10)} forState:UIControlStateSelected];
        naVC.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -5);
    }else {
        naVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }
    
    [self addChildViewController:naVC];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    // 统计tabbar中按钮点击
    NSMutableDictionary *attr = [NSMutableDictionary new];
    attr[@"tabbar_title"] = viewController.tabBarItem.title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
