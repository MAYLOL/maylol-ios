//
//  PMLPersonalCenterViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLPersonalCenterViewController.h"
#import "PMLPersonalCenterHeaderView.h"
#import "PMLPersonalCenterTableViewCell.h"
#import "PMLPersonalCenterVideoCellTableViewCell.h"
#import "PMLPersonalCenterSectionHeaderView.h"
#import "PMLPersonalInfoViewController.h"
#import "PMLSheetView.h"
#import "PMLAttentionCircleViewController.h"

static NSString *const PMLPersonalCenterCellId = @"PMLPersonalCenterCellId";
static NSString *const PMLPersonalCenterVideoCellId = @"PMLPersonalCenterVideoCellId";
static NSString *const PMLPersonalCenterSectionHeaderViewId = @"PMLPersonalCenterSectionHeaderViewId";

@interface PMLPersonalCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *tableView;
@property (nonatomic, strong) PMLPersonalCenterHeaderView *headerView;
@property (nonatomic, copy) NSArray *jumpTitleArray;
@property (nonatomic, copy) NSArray *jumpImageArray;

@end

@implementation PMLPersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.jumpTitleArray = @[kInternationalContent(@"我的钱包"),kInternationalContent(@"关注圈"),kInternationalContent(@"系统通知")];
    self.jumpImageArray = @[@"me_icon_wallet",@"me_icon_like",@"me_icon_notice"];
    [self addNavLeftButton:@"home_nav_btn_more"];
    UIBarButtonItem *rightItem = [self createBarBtnWithContent:kImageWithName(@"hot_btn_more") target:self sel:@selector(moreBtnClicked) postion:@"right"];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self setUpTableView];
    // Do any additional setup after loading the view.
}

- (void)setUpTableView
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-kTabBar);
    }];
    
    self.headerView = [PMLPersonalCenterHeaderView loadViewFromNib];
    WeakSelf(weakSelf)
    weakSelf.headerView.headerViewTouchBlock = ^(HeaderViewTouchType type) {

        
        switch (type) {
            case HeaderViewTouchWallet:
            {
                
            }
                break;
            case HeaderViewTouchFocus:
            {
                //关注圈
//                 [self pushViewControllerWithClassName:NSStringFromClass([PMLAttentionCircleViewController class]) params:nil];
                [self.navigationController pushViewController:[PMLAttentionCircleViewController new] animated:true];
            }
                break;
            case HeaderViewTouchFans:
            {
                
            }
                break;
            case HeaderViewTouchEditInfo:
            {
                
            }
                break;
            default:
                break;
        }
    };
    self.tableView.tableHeaderView = self.headerView;
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.tableView);
        make.height.mas_equalTo(392);
        make.width.equalTo(self.tableView);
    }];
    
    self.headerView.imageArray = self.jumpImageArray;
    self.headerView.titleArray = self.jumpTitleArray;
}
#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 20;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PMLPersonalCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLPersonalCenterCellId forIndexPath:indexPath];
    cell.cellIndex = indexPath.row;
    return cell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    PMLPersonalCenterSectionHeaderView *sectionHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:PMLPersonalCenterSectionHeaderViewId];
//    if (sectionHeader == nil) {
//        sectionHeader = [[PMLPersonalCenterSectionHeaderView alloc] initWithReuseIdentifier:PMLPersonalCenterSectionHeaderViewId];
//    }
//    sectionHeader.sectionIndex = section;
//    return sectionHeader;
//}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerId"];
    if (footerView == nil) {
        footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"footerId"];
        PMLBaseView *backView = [[PMLBaseView alloc] initWithFrame:footerView.bounds];
        backView.backgroundColor = [UIColor whiteColor];
        [footerView addSubview:backView];
    }
    return footerView;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 0.001;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 220;
}

#pragma mark-sender touch
- (void)moreBtnClicked
{
    PMLSheetView *sheet = [[PMLSheetView alloc] initWithDatasource:@[kInternationalContent(@"退出当前账号"),kInternationalContent(@"设置")] complate:^(NSInteger index) {
        switch (index) {
            case 0:
            {
                //退出账号
                [PMLUserUtility removeUserModel];
                [PMLTools removeObjectForkey:PMLAccessToken];
                [PMLTools removeObjectForkey:PMLRefreshToken];
            }
                break;
            case 1:
            {
                //设置
                [self pushViewControllerWithClassName:NSStringFromClass([PMLPersonalInfoViewController class]) params:nil];
            }
                break;
            default:
                break;
        }
    }];
    [sheet show];
}

#pragma mark-lazy load
- (PMLBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLPersonalCenterTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLPersonalCenterCellId];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLPersonalCenterVideoCellTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLPersonalCenterVideoCellId];
    }
    return _tableView;
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
