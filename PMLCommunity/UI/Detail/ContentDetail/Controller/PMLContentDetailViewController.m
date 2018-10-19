//
//  PMLContentDetailViewController.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLContentDetailViewController.h"
#import "PMLContentDetailCollectionCell.h"
#import "PMLContentDetailUserCollectionCell.h"
#import "PMLContentDetailMoreCollectionCell.h"
#import "PMLContentDetailCommentCell.h"
#import "PMLCommentInputView.h"
#import "PMLCommentDetailView.h"
#import "PMLCommentDetailViewController.h"
#import "PMLCommentReplyView.h"

static NSString *const CollectionViewCellID = @"CollectionViewCellID";//默认
static NSString *const ContentHeaderCollectionCellID = @"ContentHeaderCollectionCellID";//header
static NSString *const ContentDetailUserCollectionCellID = @"ContentDetailUserCollectionCellID";//用户
static NSString *const ContentDetailCollectionCellID = @"ContentDetailCollectionCellID";//文章详情
static NSString *const PMLContentDetailMoreCollectionCellID = @"PMLContentDetailMoreCollectionCellID";//更多
static NSString *const PMLContentDetailCommentCellID = @"PMLContentDetailCommentCellID";//评论
static CGFloat constHeight = 10;

@interface PMLContentDetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, PMLCommentDelegate, PMLCommentInputKViewDelegate>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, assign)CGFloat contentHeight;
@property (nonatomic, strong)NSArray<PMLCommentModel *> *commentList;
@property (nonatomic, assign)CGFloat commentHeight;
@property (nonatomic, strong)PMLCommentInputView *inputKView;
@property (nonatomic, strong)PMLCommentReplyView *replyView;
@property (nonatomic, strong)UIView *placeHolderView;
@end

@implementation PMLContentDetailViewController
- (void)dealloc
{
    NSLog(@"%@------%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
    [kNotificationCenter removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [kNotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [kNotificationCenter addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    [self addNavLeftButton:nil];
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = false;

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.inputKView resignFirstResponster];
    [IQKeyboardManager sharedManager].enable = true;
}

- (void)setup{
    [self.view addSubview:self.collectionView];//
    [self.view addSubview:self.inputKView];//输入框
    [self startLoading];
    [self refreshHeight];
    //    [UIView performWithoutAnimation:^{
    //    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]]];
    //    }];

    //    [self.collectionView reloadData];
}

- (void)startLoading {
    [UIView animateWithDuration:0.3 animations:^{
        self.placeHolderView.alpha = 1;
        [self.view addSubview:self.placeHolderView];
        self.placeHolderView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }];
}
- (void)endLoading {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            self.placeHolderView.alpha = 0;
            [self.placeHolderView removeFromSuperview];
        }];
    });
}

- (void)refreshHeight {
    CGFloat totalHeight = 0;
    for (PMLCommentModel *commentModel in self.commentList) {
        totalHeight += commentModel.commentFrame.height;
    }
    self.commentHeight = totalHeight + 50;
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]]];
}

- (void)setTitleName:(NSString *)titleName {
    [self setUpTitleViewWithText:titleName showLine:true];
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
        if (!self.replyView){
            //详情页键盘高度
            self.inputKView.bottom = kScreenHeight - 50 - iPhone_X_Bottom_Safe - height;
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
            self.inputKView.bottom = kScreenHeight - kNavBarHeight - iPhone_X_Bottom_Safe;
        } else {
            //回复页键盘高度
            self.replyView.inputKView.bottom = kScreenHeight - iPhone_X_Bottom_Safe;
        }
    }];
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.row == 3) {//评论
        PMLContentDetailCommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PMLContentDetailCommentCellID forIndexPath:indexPath];
        cell.detailView.commentList = self.commentList;
        cell.detailView.commentDelegate = self;
        return cell;
    }

    if (indexPath.row == 0) {//用户
        PMLContentDetailUserCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ContentDetailUserCollectionCellID forIndexPath:indexPath];
        return cell;
    }
    if (indexPath.row == 1) {//文章
        PMLContentDetailCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ContentDetailCollectionCellID forIndexPath:indexPath];
        //            [cell.contentWebView loadRequest:[NSURLRequest requestWithURL:[self getHtml]]];
        //            [cell.contentWebView loadHTMLString:[self getTxt] baseURL:nil];
        cell.htmlStr = [self getTxt];
        //        cell.htmlUrl = [self getHtml];

        WeakSelf(weakSelf);
        cell.contentDetailHightBlock = ^(CGFloat height) {
            StrongSelf(strongSelf);
            if (strongSelf.contentHeight != height) {
                strongSelf.contentHeight = height;
                [UIView performWithoutAnimation:^{
                    [strongSelf.collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
                [strongSelf endLoading];
            }
        };
        return cell;
    }
    if (indexPath.row == 2) {//更多
        PMLContentDetailMoreCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PMLContentDetailMoreCollectionCellID forIndexPath:indexPath];
        return cell;
    }

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellID forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {//评论
        return CGSizeMake(kScreenWidth, self.commentHeight > 0 ? (self.commentHeight + 60) : 60);
    }
    if (indexPath.row == 0) {//用户
        return CGSizeMake(kScreenWidth, 80);
    }
    if (indexPath.row == 1) {//文章
        return CGSizeMake(kScreenWidth, self.contentHeight);
    }
    if (indexPath.row == 2) {//更多
        return CGSizeMake(kScreenWidth, 78);
    }

    return CGSizeZero;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ContentHeaderCollectionCellID forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor greenColor];
    return headerView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{

    return CGSizeMake(kScreenWidth - 30, 200);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.inputKView resignFirstResponster];
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

#pragma mark- ===============PMLCommentInputKViewDelegate=================
- (void)commentInputKViewSentText:(NSString *)sentText {
    if([PMLTools CheckParam:sentText]){
        return;
    }
    NSArray<PMLCommentModel *> *commentArr = [PMLCommentModel insertCommentWithcontentId:@"10002" commentText:sentText user:[PMLCommentModel getCurrentUser] commentList:self.commentList];
    _commentList = commentArr;
    [self refreshHeight];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:true];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height - kNavBarHeight - 50 - iPhone_X_Bottom_Safe) collectionViewLayout:[UICollectionViewLayout new]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        //        _collectionView.prefetchingEnabled = false;
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ContentHeaderCollectionCellID];

        [_collectionView registerClass:[PMLContentDetailUserCollectionCell class] forCellWithReuseIdentifier:ContentDetailUserCollectionCellID];

        [_collectionView registerClass:[PMLContentDetailCollectionCell class] forCellWithReuseIdentifier:ContentDetailCollectionCellID];

        [_collectionView registerClass:[PMLContentDetailMoreCollectionCell class] forCellWithReuseIdentifier:PMLContentDetailMoreCollectionCellID];

        [_collectionView registerClass:[PMLContentDetailCommentCell class] forCellWithReuseIdentifier:PMLContentDetailCommentCellID];

        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellID];

        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        _collectionView.collectionViewLayout = layout;
        return  _collectionView;
    }
    return _collectionView;
}

- (NSURL *)getHtml {
    // 加载本地html.
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"testVideo6" ofType:@"html"];
    NSURL *url = [NSURL fileURLWithPath:htmlPath];
    return url;
}

- (NSString *)getTxt {
    // 加载本地html.
    NSString *txtPath = [[NSBundle mainBundle]pathForResource:@"testVideo7" ofType:@"txt"];
    NSData *contentData = [NSData dataWithContentsOfFile:txtPath];
    NSString *contentStr = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
    //    NSLog(@"NSData类方法读取的内容是：%@",contentStr);
    return contentStr;
}

- (NSArray<PMLCommentModel *> *)commentList {
    if (!_commentList){
        _commentList = [PMLCommentModel getPMLCommentListModel];
    }
    return _commentList;
}

- (CGFloat)contentHeight {
    return _contentHeight ?: constHeight;
}

//- (void)ka_keyboardShowOrHideAnimationWithHeight:(CGFloat)height animationDuration:(NSTimeInterval)animationDuration animationCurve:(UIViewAnimationCurve)animationCurve {
//
//}

- (UIView *)placeHolderView {
    if (!_placeHolderView){
        _placeHolderView = [UIView new];
        _placeHolderView.backgroundColor = [UIColor whiteColor];
    }
    return _placeHolderView;
}

- (PMLCommentInputView *)inputKView {
    if (!_inputKView){
        _inputKView = [[PMLCommentInputView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - kNavBarHeight - 50 - iPhone_X_Bottom_Safe,  [UIScreen mainScreen].bounds.size.width, 50)];
        _inputKView.inputKDelegate = self;
    }
    return _inputKView;
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
