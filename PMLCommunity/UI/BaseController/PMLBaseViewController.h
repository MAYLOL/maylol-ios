//
//  PMLBaseViewController.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface PMLBaseViewController : UIViewController

@property (nonatomic, strong) MBProgressHUD * hud;
@property (nonatomic, assign) NSInteger pageIndex;

/**
 创建title

 @param text 标题内容
 @param showLine 是否显示下划线
 */
- (void)setUpTitleViewWithText:(NSString *)text showLine:(BOOL)showLine;

/**
 是否显示导航栏下划线
 */
- (void)showNavigationBarShadowImage;
/**
 创建左边返回按钮

 @param imageName 图片名称  可以为nil 为nil时是返回按钮
 */
- (void)addNavLeftButton:(NSString *)imageName;
//创建一个barbuttonItem
- (UIBarButtonItem *)createSpaceBtnWithWidth:(CGFloat)width;
- (UIBarButtonItem *)createBarBtnWithContent:(NSObject *)content target:(id)target sel:(SEL)sel;
- (UIBarButtonItem *)createBarBtnWithContent:(NSObject *)content target:(id)target sel:(SEL)sel postion:(NSString *)postion;
- (UIBarButtonItem *)createBarBtnWithContent:(NSObject *)content selectedContent:(NSObject *)selectedContent target:(id)target sel:(SEL)sel postion:(NSString *)postion;
- (UIButton *)createButtonWithTitle:(NSString *)title normalImg:(NSString *)normalImg selectedImg:(NSString *)selectedImg target:(id)target sel:(SEL)sel;
//页面跳转
- (void)pushViewControllerWithClassName:(NSString *)className params:(NSDictionary *)params;
- (void)pushViewControllerWithNibName:(NSString *)nibName params:(NSDictionary *)params;
- (void)presentViewControllerWithClassName:(NSString *)className params:(NSDictionary *)params animated:(BOOL)flag completion:(void (^ __nullable)(void))completion NS_AVAILABLE_IOS(5_0);
//是否登陆
- (BOOL)isLogin;

//返回按钮的点击事件处理
- (void)navLeftButtonClick;
//键盘监听事件
- (void)keyboardWillShow:(NSNotification *)notify;
- (void)keyboardWillHidden:(NSNotification *)notify;
@end

@interface PMLBaseViewController (ShowHUD)
/**
 *  加载提示
 *
 *  @param title 自定义文字
 */
- (void)showHUD:(NSString *)title;

/**
 隐藏hud
 */
- (void)hideHUD;  //直接隐藏

/**
 *  显示纯文字
 *
 *  @param title 自定义文字
 */
- (void)showHUDPureTitle:(NSString *)title;  //隐藏之前显示操作完成的提示
@end
