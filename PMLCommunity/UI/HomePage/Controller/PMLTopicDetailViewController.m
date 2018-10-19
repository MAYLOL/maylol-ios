//
//  PMLTopicDetailViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/19.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLTopicDetailViewController.h"
#import "PMLTopicDetailHeaderView.h"
#import "PMLBaseWebView.h"
#import "PMLCommentView.h"
#import <WebKit/WebKit.h>

@interface PMLTopicDetailViewController ()
@property (nonatomic, strong) PMLTopicDetailHeaderView *headerView;
@property (nonatomic, strong) PMLBaseWebView *webView;
@property (nonatomic, strong) PMLCommentView *commentView;

@end

@implementation PMLTopicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];
    [self showNavigationBarShadowImage];
    [self setupSubViews];
    
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    _commentView = [[PMLCommentView alloc] initWithFrame:CGRectMake(0, kScreenHeight - iPhone_X_Bottom_Safe - 45 - kNavBarHeight, kScreenWidth, 45)];
    [self.view addSubview:_commentView];
    _webView = [[PMLBaseWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, _commentView.y)];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    [self.view addSubview:_webView];
    
    _headerView = [PMLTopicDetailHeaderView loadViewFromNib];
    _headerView.frame = CGRectMake(0, -100, kScreenWidth, 100);
    _webView.scrollView.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    [_webView.scrollView addSubview:_headerView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    IQKeyboardManager.sharedManager.enable = NO;
    //注册键盘通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    IQKeyboardManager.sharedManager.enable = YES;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark-键盘出现监听
- (void)keyboardWillShow:(NSNotification *)notify {
    //键盘高度
    CGFloat height = [[[notify userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //取得键盘的动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.commentView.bottom = kScreenHeight - height - kNavBarHeight;
    }];
}

#pragma mark-键盘隐藏监听
- (void)keyboardWillHidden:(NSNotification *)notify {
    // 键盘动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.commentView.bottom = kScreenHeight - iPhone_X_Bottom_Safe - kNavBarHeight;
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
