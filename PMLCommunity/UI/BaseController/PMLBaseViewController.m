//
//  PMLBaseViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseViewController.h"
#import "PMLLoginViewController.h"
#import "PMLBaseNavigationViewController.h"
#import "PMLLeftColumnView.h"

@interface PMLBaseViewController ()
//左边栏
@property (nonatomic, strong) PMLLeftColumnView *leftColumnView;
@property (nonatomic, copy) NSString *navLeftImageName;
@end

@implementation PMLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageIndex = 1;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //由于自定义的返回按钮会屏蔽该手势，所以需要重新给代理如下操作
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:[UIColor whiteColor] size:CGSizeMake(kScreenWidth, kNavBarHeight)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageFromColor:[UIColor colorWithHex:@"#FFFFFF"] size:CGSizeMake(self.view.frame.size.width, 0.5)]];
    //注册键盘通知
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}

- (void)showNavigationBarShadowImage {
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = kRGBGrayColor(240);
    [self.view addSubview:lineView];
    [self.view bringSubviewToFront:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(1);
    }];
    
}

-(void)addNavLeftButton:(NSString *)imageName
{
    //设置导航栏左侧返回按钮
    self.navLeftImageName = imageName;
    if (imageName == nil) {
        imageName = @"left_arrow";
    }
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIBarButtonItem * leftItem = [self createBarBtnWithContent:image target:self sel:@selector(navLeftButtonClick) postion:@"left"];
    self.navigationItem.leftBarButtonItem = leftItem;
}

//返回按钮的点击事件处理
-(void)navLeftButtonClick
{
    if (!self.navLeftImageName || [self.navLeftImageName isEqualToString:@"login_left_arrow"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        self.leftColumnView = [[PMLLeftColumnView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        WeakSelf(weakSelf);
        weakSelf.leftColumnView.touchBlock = ^{
            [weakSelf.leftColumnView removeFromSuperview];
            weakSelf.leftColumnView = nil;
        };
        [self.leftColumnView show];
        [kKeyWindow addSubview:self.leftColumnView];
    }
}

//是否登陆
- (BOOL)isLogin {
    if ([PMLUserUtility userModel]) {
        return YES;
    }else {
        PMLBaseNavigationViewController *nav = [[PMLBaseNavigationViewController alloc] initWithRootViewController:[[PMLLoginViewController alloc] init]];
        [self presentViewController:nav animated:YES completion:nil];
        return NO;
    }
}
/**
 创建title
 
 @param text 标题内容
 @param showLine 是否显示下划线
 */
- (void)setUpTitleViewWithText:(NSString *)text showLine:(BOOL)showLine
{
    PMLBaseLabel *titleLabel = [[PMLBaseLabel alloc] init];
    titleLabel.font = [UIFont customPingFSemiboldFontWithSize:15];
    titleLabel.textColor = kRGBColor(26, 26, 26);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel sizeToFit];
    titleLabel.text = text;
    
    if (showLine) {
        CGSize textSize = [PMLTools sizeForString:text font:[UIFont customPingFSemiboldFontWithSize:15] maxSize:CGSizeMake(300, 300)];
        PMLBaseView *titleView = [[PMLBaseView alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height + 7)];
        titleLabel.x = 0;
        titleLabel.y = 0;
        titleLabel.size = textSize;
        [titleView addSubview:titleLabel];
        
        PMLBaseView *lineView = [[PMLBaseView alloc] initWithFrame:CGRectMake(0, titleLabel.bottom + 5, textSize.width, 2)];
        lineView.backgroundColor = kRedColor;
        [titleView addSubview:lineView];
        self.navigationItem.titleView = titleView;
        
    }else {
        self.navigationItem.titleView = titleLabel;
    }
//    self.navigationItem.titleView = titleLabel;
}

- (void)setTitleStr:(NSString *)titleStr
{
    PMLBaseLabel *titleLabel = [[PMLBaseLabel alloc] init];
    titleLabel.font = [UIFont customPingFSemiboldFontWithSize:15];
    titleLabel.textColor = kRGBColor(26, 26, 26);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel sizeToFit];
    titleLabel.text = titleStr;
    self.navigationItem.titleView = titleLabel;
}

#pragma mark-页面跳转
-(void)pushViewControllerWithClassName:(NSString *)className params:(NSDictionary *)params
{
    if (className) {
        Class class = NSClassFromString(className);
        if (class) {
            PMLBaseViewController *vc = [[class alloc] init];
            if (params) {
                [vc setValuesForKeysWithDictionary:params];
            }
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)pushViewControllerWithNibName:(NSString *)nibName params:(NSDictionary *)params {
    if (nibName) {
        Class class = NSClassFromString(nibName);
        if (class) {
             PMLBaseViewController *vc = [[class alloc] initWithNibName:nibName bundle:nil];
            if (params) {
                [vc setValuesForKeysWithDictionary:params];
            }
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)presentViewControllerWithClassName:(NSString *)className params:(NSDictionary *)params animated:(BOOL)flag completion:(void (^ __nullable)(void))completion NS_AVAILABLE_IOS(5_0)
{
    if (className) {
        Class class = NSClassFromString(className);
        if (class) {
            PMLBaseViewController *vc = [[class alloc] init];
            if (params) {
                [vc setValuesForKeysWithDictionary:params];
            }
            [self presentViewController:vc animated:flag completion:completion];
        }
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"key = %@, value = %@", key, value);
}

#pragma mark-创建按钮
-(UIBarButtonItem *)createSpaceBtnWithWidth:(CGFloat)width
{
    return [self createBarBtnWithContent:[UIImage imageFromColor:[UIColor clearColor] size:CGSizeMake(width, 1)] target:nil sel:nil];
}

-(UIBarButtonItem *)createBarBtnWithContent:(NSObject *)content target:(id)target sel:(SEL)sel
{
    return [self createBarBtnWithContent:content target:target sel:sel postion:@""];
}

-(UIBarButtonItem *)createBarBtnWithContent:(NSObject *)content target:(id)target sel:(SEL)sel postion:(NSString *)postion
{
    return [self createBarBtnWithContent:content selectedContent:nil target:target sel:sel postion:postion];
}

-(UIBarButtonItem *)createBarBtnWithContent:(NSObject *)content selectedContent:(NSObject *)selectedContent target:(id)target sel:(SEL)sel postion:(NSString *)postion
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([content isKindOfClass:[UIImage class]]) {
        [button setImage:(UIImage *)content forState:UIControlStateNormal];
        [button setImage:(UIImage *)content forState:UIControlStateHighlighted];
        if (selectedContent && [selectedContent isKindOfClass:[UIImage class]]) {
            [button setImage:(UIImage *)selectedContent forState:UIControlStateSelected];
        }
    }else if ([content isKindOfClass:[NSString class]]){
        [button setTitle:(NSString *)content forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHex:@"#1a1a1a"] forState:UIControlStateNormal];
        if (selectedContent && [selectedContent isKindOfClass:[NSString class]]) {
            [button setTitle:(NSString *)selectedContent forState:UIControlStateSelected];
        }
    }else if ([content isKindOfClass:[NSAttributedString class]]){
        [button setAttributedTitle:(NSAttributedString *)content forState:UIControlStateNormal];
        if (selectedContent && [selectedContent isKindOfClass:[NSAttributedString class]]) {
            [button setAttributedTitle:(NSAttributedString *)selectedContent forState:UIControlStateSelected];
        }
    }else{
        return nil;
    }
    button.titleLabel.font = [UIFont customPingFRegularFontWithSize:12];;
    CGSize size = [button sizeThatFits:CGSizeMake(100, 100)];
     button.frame = CGRectMake(0, 0, size.width, 44);
    if ([postion isEqualToString:@"left"]) {
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        button.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    }else if ([postion isEqualToString:@"right"]){
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//        button.contentEdgeInsets = UIEdgeInsetsMake(0, +5, 0, 0);
    }
    if (sel && target) {
        [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (UIButton *)createButtonWithTitle:(NSString *)title normalImg:(NSString *)normalImg selectedImg:(NSString *)selectedImg target:(id)target sel:(SEL)sel
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    [button setImage:[UIImage imageNamed:normalImg] forState:UIControlStateNormal];
    if (selectedImg) {
        [button setImage:[UIImage imageNamed:selectedImg] forState:UIControlStateSelected];
    }
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return button;
}

#pragma mark-键盘出现监听
- (void)keyboardWillShow:(NSNotification *)notify {
    
    //键盘高度
//    CGFloat height = [[[notify userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
//    //取得键盘的动画时间
//    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
}

#pragma mark-键盘隐藏监听
- (void)keyboardWillHidden:(NSNotification *)notify {
    // 键盘动画时间
//    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
}

- (void)dealloc
{
    NSLog(@"%@------%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

#pragma mark - ShowHUD 分类
@implementation PMLBaseViewController (ShowHUD)

///显示提示  自定义显示内容
- (void)showHUD:(NSString *)title
{
    self.hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    self.hud.label.text = title;
}

///隐藏提示
- (void)hideHUD
{
    [self.hud hideAnimated:YES];
}

///操作完成的提示  自定义文字
- (void)showHUDPureTitle:(NSString *)title  //隐藏之前显示操作完成的提示
{
    [self showHUDWithTitle:title detailText:nil delay:2.0f];
}

- (void)showHUDWithTitle:(NSString *)title detailText:(NSString *)detailText delay:(float)delayTime {
//    self.hud = [[MBProgressHUD alloc] initWithView:self.view];
//    //显示模式为自定义视图模式
//    self.hud.mode = MBProgressHUDModeText;
//    self.hud.bezelView.backgroundColor = [UIColor blackColor];
//    self.hud.label.text = title;
//    self.hud.detailsLabel.text = detailText;
//    self.hud.detailsLabel.font = [UIFont systemFontOfSize:15];
//    self.hud.square = NO;
//    self.hud.animationType = MBProgressHUDAnimationZoom;
//    [self.view addSubview:self.hud];
//    [self.view bringSubviewToFront:self.hud];
//    [self.hud showAnimated:YES];
//    //延迟隐藏
//    [self.hud hideAnimated:YES afterDelay:delayTime];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = title;
    hud.label.textColor = [UIColor whiteColor];
    hud.margin = 10.f;
    hud.bezelView.color = [UIColor blackColor];
    hud.removeFromSuperViewOnHide = YES;
    //hud.yOffset += (int)(view.frame.size.height/2) - 40;
    [hud hideAnimated:YES afterDelay:delayTime];
}
@end
