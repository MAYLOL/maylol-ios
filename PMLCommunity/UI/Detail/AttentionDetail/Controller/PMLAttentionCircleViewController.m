//
//  PMLAttentionCircleViewController.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/8.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLAttentionCircleViewController.h"
#import "PMLHomeAttentionTableViewCell.h"
#import "PMLAutoScrollView.h"
#import "JPVideoPlayerKit.h"
#import "PMLAttentionVideoView.h"
#import "PMLContentDetailViewController.h"
#import "PMLBaseNavigationViewController.h"
#import "MLVideoModel.h"
#import "MLVideoWriteManager.h"
#import <MJRefresh/MJRefresh.h>
#import "PMLCommentInputView.h"
#import "PMLBeautyDiaryTableViewCell.h"
#import "PMLAttentionCircleHeaderView.h"

static NSString *const PMLHomeAttentionTableCellId = @"PMLHomeAttentionTableCellId";
static NSString *const PMLBeautyDiaryCellId = @"PMLBeautyDiaryCellId";

typedef BOOL(^RunloopBlock)(void);

@interface PMLAttentionCircleViewController ()<PMLAutoScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,JPTableViewPlayVideoDelegate,MLVideoWriteDelegate, PMLCommentInputKViewDelegate>{
    int _currentPage;
}
@property (nonatomic, strong) PMLAutoScrollView *topItemScrollView;
@property (nonatomic, strong) PMLAttentionCircleHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong, nonnull)NSMutableArray<MLVideoModel *> *dataSource;
@property (nonatomic, strong) PMLAttentionVideoView *videoView;
@property (nonatomic, strong) PMLHomeAttentionTableViewCell *playerCell;

@property (nonatomic, strong)NSArray<PMLCommentModel *> *commentList;
@property (nonatomic, strong)NSArray *commentArr;
@property (nonatomic, assign)CGFloat commentHeight;

@property (nonatomic, strong)PMLCommentInputView *inputKView;
@property (nonatomic, strong)NSIndexPath *commentIndexP;
#pragma mark- =====================test method=====================
@property (nonatomic, strong, nonnull)NSMutableArray<RunloopBlock> *tasks;
@property (nonatomic, strong, nonnull)MLVideoModel *videoModel;
/** 时钟事件  */
@property(nonatomic,strong)NSTimer * timer;
/** 最大任务s */
@property(assign,nonatomic)NSUInteger maxQueueLength;

@end

@implementation PMLAttentionCircleViewController
- (void)dealloc
{
    NSLog(@"%@------%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    [kNotificationCenter removeObserver:self];
}
-(void)timerMethod{
    //任何事情都不做!!!
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //    [self setUpTopTitleView];
    //    [self.tableView reloadData];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(timerMethod) userInfo:nil repeats:YES];
    [kNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [kNotificationCenter addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self addNavLeftButton:@"login_left_arrow"];
    //关注
    [super viewDidLoad];
    [self.view addSubview:self.headerView];

    [self.tableView reloadData];
    [self.view addSubview:self.inputKView];//输入框
//    [self showNavigationBarShadowImage];
    // Do any additional setup after loading the view.
    [self setup];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    [self.tableView jp_handleCellUnreachableTypeInVisibleCellsAfterReloadData];
    [self.tableView jp_playVideoInVisibleCellsIfNeed];
    // 用来防止选中 cell push 到下个控制器时, tableView 再次调用 scrollViewDidScroll 方法, 造成 playingVideoCell 被置空.
    self.tableView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [IQKeyboardManager sharedManager].enable = false;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 用来防止选中 cell push 到下个控制器时, tableView 再次调用 scrollViewDidScroll 方法, 造成 playingVideoCell 被置空.
    [IQKeyboardManager sharedManager].enable = true;
    [self.inputKView resignFirstResponster];
    self.tableView.delegate = nil;
    if (self.tableView.jp_playingVideoCell) {
        [self.tableView.jp_playingVideoCell.jp_videoPlayView jp_stopPlay];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    CGRect tableViewFrame = self.tableView.frame;
    tableViewFrame.size.height -= self.tabBarController.tabBar.bounds.size.height;
    self.tableView.jp_tableViewVisibleFrame = tableViewFrame;
}
#pragma mark - Setup

- (void)setup {
    //添加RunLoop的监听
    [self addRunloopObserver];
    _maxQueueLength = 16;
    _tasks = [NSMutableArray array];
    self.tableView.jp_delegate = self;
    self.tableView.jp_scrollPlayStrategyType = JPScrollPlayStrategyTypeBestCell;

    [self getCommentData];
    [self refreshHeight];
    [self loadData];
}

//这里面都是c语言的代码
-(void)addRunloopObserver{
    //获取当前RunLoop
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    //定义一个上下文
    CFRunLoopObserverContext context = {
        0,
        (__bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL,
    };
    //定义一个观察者
    static CFRunLoopObserverRef defaultModeObserver;
    //创建观察者
    defaultModeObserver = CFRunLoopObserverCreate(NULL, kCFRunLoopBeforeWaiting, YES, 0, &Callback, &context);
    //添加当前RunLoop的观察者
    CFRunLoopAddObserver(runloop, defaultModeObserver, kCFRunLoopDefaultMode);
    //C语言里面有Creat\new\copy 就需要 释放 ARC 管不了!!
    CFRelease(defaultModeObserver);

}

//回调函数
static void Callback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    //从数组里面取代码!! info 哥么就是 self
    PMLAttentionCircleViewController * vc = (__bridge PMLAttentionCircleViewController *)info;
    if (vc.tasks.count == 0) {
        return;
    }
    BOOL result = NO;
    while (result == NO && vc.tasks.count) {
        //取出任务
        RunloopBlock unit = vc.tasks.firstObject;
        //执行任务
        result = unit();
        //干掉第一个任务
        [vc.tasks removeObjectAtIndex:0];
    }
}

#pragma mark - <关于RunLoop的方法>
//添加新的任务的方法!
-(void)addTask:(RunloopBlock)unit {
    [self.tasks addObject:unit];
    //判断一下 保证没有来得及显示的cell不会绘制图片!!
    if (self.tasks.count > self.maxQueueLength) {
        [self.tasks removeObjectAtIndex:0];
    }
}

- (void)getCommentData {
    NSMutableArray *commentArr = [[NSMutableArray alloc] initWithCapacity:20];
    for (int i = 0; i < self.dataSource.count; i ++) {
        [commentArr addObject:self.commentList];
    }
    _commentArr = commentArr;
    [self.tableView reloadData];
}

- (void)loadData {
    _currentPage = 0;
    // 模拟网络数据
    NSArray *testData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"testData.plist" ofType:nil]];
    [MLVideoWriteManager manager].delegate = self;
    NSMutableArray<MLVideoModel *> *dataSource = [MLVideoModel mj_objectArrayWithKeyValuesArray:testData];
    _dataSource = dataSource;
    [self.tableView reloadData];
    //    for (MLVideoModel *vModel in dataSource) {
    //        [[MLVideoWriteManager manager] writeFileAsyncWithModel:vModel completeHandle:nil];
    //    }
}

- (void)loadNewData {
    _currentPage = 0;
    NSLog(@"下拉刷新");
    [self loadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

- (void)loadMoreData {
    _currentPage ++;
    NSLog(@"上拉加载");
    for (int i = (_currentPage * 16) + 1; i <= (_currentPage + 1) * 16; i++) {
        MLVideoModel *model = self.dataSource[0];
        model.vid = [NSString stringWithFormat:@"%d",i];
        [self.dataSource addObject:model];
        if (i == (_currentPage + 1) * 16){
            [self.tableView reloadData];
        }
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_footer endRefreshing];
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
        //        self.inputKView.bottom = kScreenHeight - kNavBarHeight - 50 - iPhone_X_Bottom_Safe - height;
        //详情页键盘高度
        self.inputKView.bottom = kScreenHeight - 50 - iPhone_X_Bottom_Safe - height - kStatusBar;
    }];
}

- (void)keyboardWillHidden:(NSNotification *)notify
{
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        //详情页键盘高度
        self.inputKView.bottom = kScreenHeight;
    }];
}
#pragma mark- ===============PMLCommentInputKViewDelegate=================
- (void)commentInputKViewSentText:(NSString *)sentText {
    if([PMLTools CheckParam:sentText]){
        return;
    }
    NSArray<PMLCommentModel *> *commentArr = [PMLCommentModel insertCommentWithcontentId:@"10002" commentText:sentText user:[PMLCommentModel getCurrentUser] commentList:self.commentList];
    _commentList = commentArr;
    [self refreshHeight];
    [self.tableView reloadRowsAtIndexPaths:@[self.commentIndexP] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView scrollToRowAtIndexPath:self.commentIndexP atScrollPosition:UITableViewScrollPositionBottom animated:true];
}

#pragma mark-MLVideoWriteDelegate
- (void)writeFinishWithModel:(MLVideoModel *)model error:(NSError *)error {
    [self.dataSource enumerateObjectsUsingBlock:^(MLVideoModel *vModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([vModel.vid isEqualToString:model.vid]) {
            // 更新数据源
            self.dataSource[idx] = model;
            // 主线程更新cell进度
            dispatch_async(dispatch_get_main_queue(), ^{
                if (idx < self.dataSource.count){
                    //                    [self tableView:self.tableView willPlayVideoOnCell:self.playerCell];
                    //                    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                }
            });
            *stop = YES;
        }
    }];
}

+ (void)addContentWithtableView:(UITableView *)tableView Cell:(PMLHomeAttentionTableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath model:(MLVideoModel *)model {
    MLVideoModel *vModel = model;
    [[MLVideoWriteManager manager] writeFileAsyncWithModel:model completeHandle:^(MLVideoModel *videoModel, NSError *error) {
        if (videoModel.writeState == MLWriteStateFinish){
            dispatch_async(dispatch_get_main_queue(), ^{
                [cell.contentImageView setImage:videoModel.preViewImage];
                cell.isVideo = true;
                cell.jp_videoURL = videoModel.localUrl;
                cell.jp_videoPlayView = cell.contentImageView;
                [tableView jp_handleCellUnreachableTypeForCell:cell
                                                   atIndexPath:indexPath];
            });
        }
    }];
    cell.isVideo = true;
    if (vModel.writeState == MLWriteStateFinish){
        [cell.contentImageView setImage:vModel.preViewImage];
        cell.jp_videoURL = vModel.localUrl;
        cell.jp_videoPlayView = cell.contentImageView;
        [tableView jp_handleCellUnreachableTypeForCell:cell
                                           atIndexPath:indexPath];
    }
    if (cell.jp_videoPlayView.subviews) {
        for (UIView *subview in cell.jp_videoPlayView.subviews) {
            if ([subview isKindOfClass:[UIButton class]]){
                [subview removeFromSuperview];
            }
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    if (indexPath.row >= self.dataSource.count) {
        PMLBeautyDiaryTableViewCell *beautyCell = [tableView dequeueReusableCellWithIdentifier:PMLBeautyDiaryCellId forIndexPath:indexPath];
        return beautyCell;
    }
    PMLHomeAttentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLHomeAttentionTableCellId forIndexPath:indexPath];
    MLVideoModel *model = self.dataSource[indexPath.row];
    cell.commentView.commentList = self.commentList;
    cell.commentHeight = self.commentHeight;

    typeof(self) __weak weakSelf = self;
    cell.clickAction = ^{
        typeof(weakSelf) __strong strongSelf = weakSelf;
        strongSelf.commentIndexP = indexPath;
        [strongSelf.inputKView becomeFirstResponster];
    };
    [self addTask:^BOOL{
        [PMLAttentionCircleViewController addContentWithtableView:tableView Cell:cell withIndexPath:indexPath model:model];
        return true;
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > self.dataSource.count) {
        //美丽日记
        return;
    }
    PMLContentDetailViewController *contentDetailVC = [PMLContentDetailViewController new];
    contentDetailVC.titleName = kInternationalContent(@"关注详情");
    [self.navigationController pushViewController:contentDetailVC animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > self.dataSource.count) {
        return 280;
    }
    return 420 + self.commentHeight;
}

#pragma mark-PMLAutoScrollViewDelegate
- (void)autoScrollView:(PMLAutoScrollView *)autoScrollView didSelectAtIndex:(NSInteger)index
{

}

/**
 * Called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
 * 松手时已经静止, 只会调用scrollViewDidEndDragging
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.tableView jp_scrollViewDidEndDraggingWillDecelerate:decelerate];
}

/**
 * Called on tableView is static after finger up if the user dragged and tableView is scrolling.
 * 松手时还在运动, 先调用scrollViewDidEndDragging, 再调用scrollViewDidEndDecelerating
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self.tableView jp_scrollViewDidEndDecelerating];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView jp_scrollViewDidScroll];
    [self.inputKView resignFirstResponster];
}
#pragma mark - JPTableViewPlayVideoDelegate

- (void)tableView:(UITableView *)tableView willPlayVideoOnCell:(UITableViewCell *)cell {
    //    while (((PMLHomeAttentionTableViewCell *)cell).jp_playerStatus == JPVideoPlayerStatusUnknown && ) {
    if (((PMLHomeAttentionTableViewCell *)cell).isVideo){
        [cell.jp_videoPlayView jp_resumeMutePlayWithURL:cell.jp_videoURL
                                     bufferingIndicator:nil
                                           progressView:nil
                                          configuration:nil];
        self.playerCell = (PMLHomeAttentionTableViewCell *)cell;
        [self addAction:cell.jp_videoPlayView];
    }
}

#pragma mark-lazy load
- (PMLAttentionCircleHeaderView *)headerView {
    if (!_headerView){
        PMLAttentionCircleHeaderView *headerView = [[PMLAttentionCircleHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) topString:kInternationalContent(@"关注圈")];
        _headerView = headerView;
    }
    return _headerView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[PMLHomeAttentionTableViewCell class] forCellReuseIdentifier:PMLHomeAttentionTableCellId];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLBeautyDiaryTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLBeautyDiaryCellId];

        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        MJRefreshAutoStateFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        [footer setTitle:@"～到底了~" forState:MJRefreshStateNoMoreData];
        _tableView.mj_footer = footer;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.view).offset(40);
        }];
    }
    return _tableView;
}

- (void)addAction:(UIView *)view {
    if (view.subviews) {
        for (UIView *subview in view.subviews) {
            if ([subview isKindOfClass:[UIButton class]]){
                [subview removeFromSuperview];
            }
        }
    }
    PMLBaseButton *publishBtn = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    [publishBtn addTarget:self action:@selector(showVideoView) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:publishBtn];
    [publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view.mas_centerX).offset(0);
        make.centerY.equalTo(view.mas_centerY).offset(0);
        make.width.mas_equalTo(view.width);
        make.height.mas_equalTo(view.height);
    }];
}

- (void)addAction2:(UIView *)view {
    PMLBaseButton *publishBtn = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    [publishBtn addTarget:self action:@selector(hideVideoView) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:publishBtn];
    [publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view.mas_centerX).offset(0);
        make.centerY.equalTo(view.mas_centerY).offset(0);
        make.width.mas_equalTo(view.width);
        make.height.mas_equalTo(view.height);
    }];
}

- (void)showVideoView {
    [[kAppDelegate window] addSubview:self.videoView];
    self.videoView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.videoView jp_resumeMutePlayWithURL:self.playerCell.jp_videoURL bufferingIndicator:nil progressView:nil configuration:^(UIView * _Nonnull view, JPVideoPlayerModel * _Nonnull playerModel) {
        playerModel.muted = false;
    }];
    [self addAction2:self.videoView.jp_videoPlayerView];
}

- (void)hideVideoView {
    [self.videoView removeFromSuperview];
    self.videoView = nil;
    [self.playerCell.jp_videoPlayView jp_resumeMutePlayWithURL:self.playerCell.jp_videoURL
                                            bufferingIndicator:nil
                                                  progressView:nil
                                                 configuration:nil];
}
- (PMLAttentionVideoView *)videoView {
    if (!_videoView) {
        _videoView = [PMLAttentionVideoView new];
        return _videoView;
    }
    return _videoView;
}

- (PMLCommentInputView *)inputKView {
    if (!_inputKView){
        _inputKView = [[PMLCommentInputView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height,  [UIScreen mainScreen].bounds.size.width, 50)];
        _inputKView.inputKDelegate = self;
    }
    return _inputKView;
}

- (NSArray<PMLCommentModel *> *)commentList {
    if (!_commentList){
        _commentList = [PMLCommentModel getPMLContentCommentListModel];
    }
    return _commentList;
}
- (void)refreshHeight {
    CGFloat totalHeight = 0;
    for (PMLCommentModel *commentModel in self.commentList) {
        totalHeight += commentModel.commentFrame.height2 + 5;
    }
    self.commentHeight = totalHeight;
    //    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]]];
}
@end

