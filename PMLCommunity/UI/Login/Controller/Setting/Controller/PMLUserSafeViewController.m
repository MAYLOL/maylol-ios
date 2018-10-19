//
//  PMLUserSafeViewController.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/9.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLUserSafeViewController.h"
#import "PMLSettingTableViewCell.h"
#import "PMLCancelAccountCell.h"
#import "PMLCancelAccountViewController.h"
#import "PMLChangePWDViewController.h"

static NSString *const PMLSettingTableViewCellId = @"PMLSettingTableViewCellId";
static NSString *const PMLCancelAccountCellId = @"PMLCancelAccountCellId";

@interface PMLUserSafeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *tableView;
@property (nonatomic, copy) NSArray *dataSource;
@end

@implementation PMLUserSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];
    [self setUpTitleViewWithText:kInternationalContent(@"账号与安全") showLine:NO];
    [self setupSubViews];
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    self.dataSource = @[@[kInternationalContent(@"账号"),kInternationalContent(@"修改密码")],@[kInternationalContent(@"注销账号")]];
    self.tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height - kNavBarHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = kRGBGrayColor(236);
    self.tableView.scrollEnabled = false;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 40;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLSettingTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLSettingTableViewCellId];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLCancelAccountCell class]) bundle:nil] forCellReuseIdentifier:PMLCancelAccountCellId];
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

    if (indexPath.section == 0) {
        PMLSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLSettingTableViewCellId forIndexPath:indexPath];
        if (indexPath.row == 0){
            //账号
            cell.centerLabel.hidden = YES;
            cell.leftLabel.hidden = NO;
            cell.rightLabel.hidden = NO;
            cell.bottomLineView.hidden = NO;
            cell.arrowImageView.hidden = YES;
            cell.rightLabel.text = @"15801002807";
        } else {
            //修改密码
            cell.centerLabel.hidden = YES;
            cell.leftLabel.hidden = NO;
            cell.rightLabel.hidden = YES;
            cell.bottomLineView.hidden = YES;
            cell.arrowImageView.hidden = NO;
        }
        cell.leftLabel.text = [[self.dataSource objectAtCheckedIndex:indexPath.section] objectAtCheckedIndex:indexPath.row];
        return  cell;
    }
    //注销账号
    PMLCancelAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLCancelAccountCellId forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0){
            //账号
            return;
        }
        //修改密码
     [self pushViewControllerWithClassName:NSStringFromClass([PMLChangePWDViewController class]) params:nil];
        return;
    }
    //注销账号
    [self pushViewControllerWithClassName:NSStringFromClass([PMLCancelAccountViewController class]) params:nil];
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

/*
 #pragma mark - Navigation

 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
