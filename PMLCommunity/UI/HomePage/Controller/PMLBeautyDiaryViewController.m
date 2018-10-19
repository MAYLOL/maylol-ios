//
//  PMLBeautyDiaryViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBeautyDiaryViewController.h"
#import "PMLBeautyDiaryTableViewCell.h"
#import "PMLBeautyDiaryListHeaderView.h"
#import "PMLPersonalDiaryListViewController.h"
#import "PMLMyDiaryView.h"

static NSString *const PMLBeautyDiaryCellId = @"PMLBeautyDiaryCellId";

@interface PMLBeautyDiaryViewController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic, strong) PMLBeautyDiaryListHeaderView *headerView;
@property (nonatomic, strong) PMLBaseScrollView *baseScrollView;
@property (nonatomic, strong) PMLBaseTableView *diaryTypeTableView;
@property (nonatomic, strong) PMLBaseTableView *latestDiaryTableView;
@end

@implementation PMLBeautyDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];
    [self setUpTitleViewWithText:kInternationalContent(@"美丽日记") showLine:YES];
    [self setupSubViews];
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    PMLBeautyDiaryListHeaderView *headerView = [[PMLBeautyDiaryListHeaderView alloc] init];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 30);
    WeakSelf(weakSelf);
    headerView.diaryHeaderBlock = ^(NSInteger index) {
        switch (index) {
            case MyDiary:
            {
                weakSelf.baseScrollView.contentOffset = CGPointMake(0, 0);
            }
                break;
            case ChangeDiary:
            {
                weakSelf.baseScrollView.contentOffset = CGPointMake(kScreenWidth, 0);
            }
                break;
            case LatestDiary:
            {
                weakSelf.baseScrollView.contentOffset = CGPointMake(kScreenWidth * 2, 0);
            }
                break;
            default:
                break;
        }
    };
    [self.view addSubview:headerView];
    _headerView = headerView;
    _headerView.selectIndex = 0;
    self.baseScrollView = [[PMLBaseScrollView alloc] init];
    self.baseScrollView.frame = CGRectMake(0, 30, kScreenWidth, self.view.height - 30 - kNavBarHeight);
    self.baseScrollView.contentSize = CGSizeMake(kScreenWidth * 3, 0);
    self.baseScrollView.pagingEnabled = YES;
    self.baseScrollView.delegate = self;
    [self.view addSubview:self.baseScrollView];

    [self.baseScrollView addSubview:self.latestDiaryTableView];
    self.latestDiaryTableView.frame = CGRectMake(2 * kScreenWidth, 0, kScreenWidth, self.baseScrollView.height);
    [self.baseScrollView addSubview:self.diaryTypeTableView];
    self.diaryTypeTableView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, self.baseScrollView.height);
    
    PMLMyDiaryView *myDiaryView = [[PMLMyDiaryView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.baseScrollView.height) controller:self];
    [self.baseScrollView addSubview:myDiaryView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat index = scrollView.contentOffset.x/kScreenWidth;
    if (index + 1 != _headerView.selectIndex) {
        [_headerView setselectBtn:index + 1];
    }
    
}

#pragma mark-UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMLBeautyDiaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLBeautyDiaryCellId forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushViewControllerWithClassName:NSStringFromClass([PMLPersonalDiaryListViewController class]) params:nil];
}

- (PMLBaseTableView *)diaryTypeTableView {
    if (!_diaryTypeTableView) {
        _diaryTypeTableView = [[PMLBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _diaryTypeTableView.delegate = self;
        _diaryTypeTableView.dataSource = self;
        _diaryTypeTableView.rowHeight = 280;
        _diaryTypeTableView.showsVerticalScrollIndicator = NO;
        [_diaryTypeTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLBeautyDiaryTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLBeautyDiaryCellId];
        _diaryTypeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _diaryTypeTableView;
}

- (PMLBaseTableView *)latestDiaryTableView {
    if (!_latestDiaryTableView) {
        _latestDiaryTableView = [[PMLBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _latestDiaryTableView.delegate = self;
        _latestDiaryTableView.dataSource = self;
        _latestDiaryTableView.rowHeight = 280;
        _latestDiaryTableView.showsVerticalScrollIndicator = NO;
        [_latestDiaryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLBeautyDiaryTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLBeautyDiaryCellId];
        _latestDiaryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _latestDiaryTableView;
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
