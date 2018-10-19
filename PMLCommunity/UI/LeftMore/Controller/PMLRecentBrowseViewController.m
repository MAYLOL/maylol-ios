//
//  PMLRecentBrowseViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/24.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLRecentBrowseViewController.h"
#import "PMLLeftMoreTopScrollView.h"
#import "PMLMyAttentionUserTableViewCell.h"

static NSString *const PMLRecentBrowseCellId = @"PMLRecentBrowseCellId";

@interface PMLRecentBrowseViewController ()<PMLLeftMoreTopScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) PMLLeftMoreTopScrollView *topScrollView;
@property (nonatomic, strong) PMLBaseScrollView *scrollView;
@property (nonatomic, strong) PMLBaseTableView *browseTableView;
@end

@implementation PMLRecentBrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];
    [self setupSubViews];
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    self.topScrollView = [[PMLLeftMoreTopScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30) dataSource:@[kInternationalContent(@"最近浏览")] delegate:self];
    [self.view addSubview:self.topScrollView];
    
    self.scrollView = [[PMLBaseScrollView alloc] initWithFrame:CGRectMake(0, self.topScrollView.bottom, kScreenWidth, self.view.height - self.topScrollView.bottom - kNavBarHeight)];
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    
    self.browseTableView = [self creatTableView];
    self.browseTableView.frame = CGRectMake(0, 0, kScreenWidth, self.scrollView.height);
    [self.browseTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLMyAttentionUserTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLRecentBrowseCellId];
    [self.scrollView addSubview:self.browseTableView];
    
}


#pragma mark-UITableViewDataSource,UIScrollViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMLMyAttentionUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLRecentBrowseCellId forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
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
