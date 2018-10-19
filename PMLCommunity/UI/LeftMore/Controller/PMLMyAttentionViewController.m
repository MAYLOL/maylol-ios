//
//  PMLMyAttentionViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/24.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLMyAttentionViewController.h"
#import "PMLLeftMoreTopScrollView.h"
#import "PMLMyAttentionUserTableViewCell.h"
#import "PMLBeautyDiaryTableViewCell.h"

static NSString *const PMLMyAttentionUserCellId = @"PMLMyAttentionUserCellId";
static NSString *const PMLBeautyDiaryCellId = @"PMLBeautyDiaryCellId";

@interface PMLMyAttentionViewController ()<PMLLeftMoreTopScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) PMLLeftMoreTopScrollView *topScrollView;
@property (nonatomic, strong) PMLBaseScrollView *scrollView;
@property (nonatomic, strong) PMLBaseTableView *userTableView;
@property (nonatomic, strong) PMLBaseTableView *diaryTableView;
@end

@implementation PMLMyAttentionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];
    [self setUpTitleViewWithText:kInternationalContent(@"我的关注") showLine:NO];
    [self setupSubViews];
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    self.topScrollView = [[PMLLeftMoreTopScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30) dataSource:@[kInternationalContent(@"用户"),kInternationalContent(@"美丽日记")] delegate:self];
    [self.view addSubview:self.topScrollView];
    
    self.scrollView = [[PMLBaseScrollView alloc] initWithFrame:CGRectMake(0, self.topScrollView.bottom, kScreenWidth, self.view.height - self.topScrollView.bottom - kNavBarHeight)];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth * 2, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    self.userTableView = [self creatTableView];
    self.userTableView.frame = CGRectMake(0, 0, kScreenWidth, self.scrollView.height);
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLMyAttentionUserTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLMyAttentionUserCellId];
    self.userTableView.tableFooterView = [self createUserTableFooterView];
    [self.scrollView addSubview:self.userTableView];
//
    self.diaryTableView = [self creatTableView];
    self.diaryTableView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, self.scrollView.height);
    [self.diaryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLBeautyDiaryTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLBeautyDiaryCellId];
    [self.scrollView addSubview:self.diaryTableView];
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.userTableView) {
        PMLMyAttentionUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLMyAttentionUserCellId forIndexPath:indexPath];
        return cell;
    }else {
        PMLBeautyDiaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLBeautyDiaryCellId forIndexPath:indexPath];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.userTableView) {
        return 66;
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

- (PMLBaseView *)createUserTableFooterView {
    PMLBaseView *footerView = [[PMLBaseView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 13)];
    PMLBaseView *lineView = [[PMLBaseView alloc] initWithFrame:CGRectMake(15, 12, kScreenWidth - 30, 1)];
    lineView.backgroundColor = kRGBGrayColor(230);
    [footerView addSubview:lineView];
    return footerView;
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
