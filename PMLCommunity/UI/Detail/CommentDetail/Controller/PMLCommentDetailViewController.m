//
//  PMLCommentDetailViewController.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLCommentDetailViewController.h"
#import "PMLCommentDetailView.h"
#import <MJRefresh/MJRefresh.h>
#import "PMLCommentReplyView.h"
#import "UIView+PMLViewFrom.h"

@interface PMLCommentDetailViewController ()<PMLCommentDelegate>
@property (nonatomic, strong)PMLCommentReplyView *replyView;
@end

@implementation PMLCommentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [kNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [kNotificationCenter addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    [self addNavLeftButton:nil];
//    UIBarButtonItem *rightItem = [self createBarBtnWithContent:kImageWithName(@"hot_btn_more") target:self sel:@selector(sortClicked) postion:@"right"];
//    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = false;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = true;

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

}

- (void)setCommentList:(NSArray<PMLCommentModel *> *)commentList {
    _commentList = commentList;

    NSString *commentC = [NSString stringWithFormat:@"%@%ld%@%@",kInternationalContent(@"全部"), commentList.count,kInternationalContent(@"条") ,kInternationalContent(@"评论")];
    [self setUpTitleViewWithText:commentC showLine:false];
    [self detailView];
    self.detailView.commentList = commentList;
}

- (void)sortClicked {

}

- (void)loadNewData {
    NSLog(@"下拉刷新");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.detailView.mj_header endRefreshing];
    });
}

- (void)loadMoreData {
    NSLog(@"上拉加载");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.detailView.mj_footer endRefreshingWithNoMoreData];
    });
}
#pragma mark-keyboardAnimation
- (void)keyboardWillShow:(NSNotification *)notify
{
    //键盘高度
    CGFloat height = [[[notify userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //取得键盘的动画时间
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        //        self.inputView.bottom = kScreenHeight - kNavBarHeight - 50 - iPhone_X_Bottom_Safe - height;

        if (!self.replyView){
            //详情页键盘高度
        } else {
            //回复页键盘高度
            self.replyView.inputKView.bottom = kScreenHeight - height;
        }

    }];
}

- (void)keyboardWillHidden:(NSNotification *)notify
{
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        if (!self.replyView){
            //详情页键盘高度
        } else {
            //回复页键盘高度
            self.replyView.inputKView.bottom = kScreenHeight - iPhone_X_Bottom_Safe;
        }
    }];
}
#pragma mark- =====================PMLCommentDelegate=====================
- (void)gotoCommentListPage {
    PMLCommentDetailViewController *commentVC = [PMLCommentDetailViewController new];
    commentVC.commentList = [self commentList];
    [self.navigationController pushViewController:commentVC animated:true];
}

//评论回复页面
- (void)gotoReplyListPageWithCommentModel:(PMLCommentModel *)commentModel {
    PMLCommentReplyView *replyView = [[PMLCommentReplyView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    replyView.commentModel = commentModel;
    WeakSelf(weakSelf);
    replyView.touchBlock = ^{
        StrongSelf(strongSelf);
        [strongSelf.replyView removeFromSuperview];
        strongSelf.replyView = nil;
    };
    [kKeyWindow addSubview:replyView];
    _replyView = replyView;

}

- (PMLCommentDetailView *)detailView {
    if (!_detailView){
       PMLCommentDetailView *detailView = [[PMLCommentDetailView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        detailView.isHeader = false;
        detailView.commentDelegate = self;
        [self.view addSubview:detailView];
        [detailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
        }];
        detailView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        MJRefreshAutoStateFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
        [footer setTitle:@"～到底了~" forState:MJRefreshStateNoMoreData];
        detailView.mj_footer = footer;
        _detailView = detailView;
    }
    return _detailView;
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
