//
//  PMLMyDraftViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/24.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLMyDraftViewController.h"
#import "PMLLeftMoreTopScrollView.h"
#import "PMLHomeAttentionTableViewCell.h"
#import "PMLRecommendTopicGeneralTableViewCell.h"
#import "PMLBeautyDiaryTableViewCell.h"

static NSString *const PMLArticleCellId = @"PMLArticleCellId";
static NSString *const PMLTopicCellId = @"PMLTopicCellId";
static NSString *const PMLBeautyDiaryCellId = @"PMLBeautyDiaryCellId";

@interface PMLMyDraftViewController ()<PMLLeftMoreTopScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) PMLLeftMoreTopScrollView *topScrollView;
@property (nonatomic, strong) PMLBaseScrollView *scrollView;
@property (nonatomic, strong) PMLBaseTableView *articleTableView;
@property (nonatomic, strong) PMLBaseTableView *topicTableView;
@property (nonatomic, strong) PMLBaseTableView *beautyDiaryTableView;
@end

@implementation PMLMyDraftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];
    [self setUpTitleViewWithText:kInternationalContent(@"我的草稿") showLine:NO];
    [self setupSubViews];
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    self.topScrollView = [[PMLLeftMoreTopScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30) dataSource:@[kInternationalContent(@"文章"),kInternationalContent(@"话题"),kInternationalContent(@"美丽日记")] delegate:self];
    self.topScrollView.lineWidth = 20;
    [self.view addSubview:self.topScrollView];
    
    self.scrollView = [[PMLBaseScrollView alloc] initWithFrame:CGRectMake(0, self.topScrollView.bottom, kScreenWidth, self.view.height - self.topScrollView.bottom - kNavBarHeight)];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * 3, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    self.articleTableView = [self creatTableView];
    self.articleTableView.frame = CGRectMake(0, 0, kScreenWidth, self.scrollView.height);
    [self.articleTableView registerClass:[PMLHomeAttentionTableViewCell class] forCellReuseIdentifier:PMLArticleCellId];
    [self.scrollView addSubview:self.articleTableView];
    
    self.topicTableView = [self creatTableView];
    self.topicTableView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, self.scrollView.height);
    [self.topicTableView registerClass:[PMLRecommendTopicGeneralTableViewCell class] forCellReuseIdentifier:PMLTopicCellId];
    [self.scrollView addSubview:self.topicTableView];
    
    self.beautyDiaryTableView = [self creatTableView];
    self.beautyDiaryTableView.frame = CGRectMake(kScreenWidth * 2, 0, kScreenWidth, self.scrollView.height);
    [self.beautyDiaryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLBeautyDiaryTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLBeautyDiaryCellId];
    [self.scrollView addSubview:self.beautyDiaryTableView];
    
}


#pragma mark-UITableViewDataSource,UIScrollViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.articleTableView) {
        PMLHomeAttentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLArticleCellId forIndexPath:indexPath];
        return cell;
    }else if (tableView == self.topicTableView) {
        PMLRecommendTopicGeneralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLTopicCellId forIndexPath:indexPath];
        return cell;
    }else {
        PMLBeautyDiaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLBeautyDiaryCellId forIndexPath:indexPath];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.articleTableView) {
        return 400;
    }else if (tableView == self.topicTableView) {
        return 107;
    }else {
        return 280;
    }
}

#pragma mark-UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        CGFloat index = scrollView.contentOffset.x/kScreenWidth;
        [self.topScrollView setSelectItemWIthIndex:index];
    }
}

#pragma mark-PMLLeftMoreTopScrollViewDelegate
- (void)leftMoreTopScrollView:(PMLLeftMoreTopScrollView *)scrollView didSelectItemWithIndex:(NSInteger)index {
    [self.scrollView setContentOffset:CGPointMake((10 - index) * kScreenWidth, 0) animated:YES];
}

- (PMLBaseTableView *)creatTableView  {
    PMLBaseTableView *tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor whiteColor];
    return tableView;
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
