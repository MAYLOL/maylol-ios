//
//  PMLSettingViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/25.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLSettingViewController.h"
#import "PMLSettingTableViewCell.h"
#import "PMLUserSafeViewController.h"
#import "PMLCurrencyViewController.h"
#import "PMLSysSettingViewController.h"

static NSString *const PMLSettingCellId = @"PMLSettingCellId";

@interface PMLSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *tableView;
@property (nonatomic, copy) NSArray *dataSource;
@end

@implementation PMLSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];
    [self setUpTitleViewWithText:kInternationalContent(@"设置") showLine:NO];
    [self setupSubViews];
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    self.dataSource = @[@[kInternationalContent(@"账号与安全")],@[kInternationalContent(@"消息设置"),kInternationalContent(@"通用"),kInternationalContent(@"隐私")],@[kInternationalContent(@"帮助"),kInternationalContent(@"关于Maylol")],@[kInternationalContent(@"退出账号")]];
    self.tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height - kNavBarHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = kRGBGrayColor(236);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 40;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLSettingTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLSettingCellId];
    [self.view addSubview:self.tableView];
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [(NSArray *)self.dataSource[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMLSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLSettingCellId forIndexPath:indexPath];
    if (indexPath.section < self.dataSource.count - 1) {
        cell.centerLabel.hidden = YES;
        cell.leftLabel.hidden = NO;
        cell.rightLabel.hidden = YES;
        cell.bottomLineView.hidden = YES;
        if (indexPath.section == 2 && indexPath.row == 1) {
            cell.arrowImageView.hidden = YES;
            cell.rightLabel.hidden = NO;
        }else {
            cell.arrowImageView.hidden = NO;
            cell.rightLabel.hidden = YES;
        }
        if (indexPath.section == 1 && (indexPath.row == 0 || indexPath.row == 1)) {
            cell.bottomLineView.hidden = NO;
        }
        
        if (indexPath.section == 2 && indexPath.row == 0) {
            cell.bottomLineView.hidden = NO;
        }
        cell.leftLabel.text = [[self.dataSource objectAtCheckedIndex:indexPath.section] objectAtCheckedIndex:indexPath.row];
    }else {
        cell.centerLabel.text = [[self.dataSource objectAtCheckedIndex:indexPath.section] objectAtCheckedIndex:indexPath.row];
        cell.centerLabel.hidden = NO;
        cell.leftLabel.hidden = YES;
        cell.rightLabel.hidden = YES;
        cell.arrowImageView.hidden = YES;
        cell.bottomLineView.hidden = YES;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    headerView.backgroundColor = kRGBGrayColor(236);
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        //账号安全
        [self pushViewControllerWithClassName:NSStringFromClass([PMLUserSafeViewController class]) params:nil];
        return;
    }

    if (indexPath.section == 1 && indexPath.row == 0){
        //消息通知
        [self pushViewControllerWithClassName:NSStringFromClass([PMLSysSettingViewController class]) params:nil];
        return;
    }
    if (indexPath.section == 1 && indexPath.row == 1){
        //通用
        [self pushViewControllerWithClassName:NSStringFromClass([PMLCurrencyViewController class]) params:nil];
        return;
    }
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
