//
//  PMLSysSettingViewController.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/9.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLSysSettingViewController.h"
#import "PMLSettingViewController.h"
#import "UIViewController+PMLViewController.h"
#import "PMLNotificationCell.h"
#import "PMLManager.h"

static NSString *const PMLNotificationCellId = @"PMLNotificationCellId";

@interface PMLSysSettingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *tableView;
@property (nonatomic, strong)NSString *PWDStr;
@property (nonatomic, copy) NSArray *dataSource;

@end

@implementation PMLSysSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];

    [self setUpTitleViewWithText:kInternationalContent(@"消息设置") showLine:NO];
    [self setupSubViews];
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    self.dataSource = @[@[kInternationalContent(@"新消息通知")], @[kInternationalContent(@"评论通知"),kInternationalContent(@"关注通知")]];

    self.tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height - kNavBarHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = kRGBGrayColor(236);
    self.tableView.scrollEnabled = false;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 40;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLNotificationCell class]) bundle:nil] forCellReuseIdentifier:PMLNotificationCellId];

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

    PMLNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLNotificationCellId forIndexPath:indexPath];
    cell.bottomLine.hidden = indexPath.section != 0 && indexPath.row == 0 ? false : true;
    cell.leftLabel.text = [[self.dataSource objectAtCheckedIndex:indexPath.section] objectAtCheckedIndex:indexPath.row];

    if (indexPath.section == 0){
        //新消息通知
        cell.switchControl.on = [PMLManager getNewsNotifi];
    } else {
        if (indexPath.row == 0){
            //评论通知
            cell.switchControl.on = [PMLManager getCommentNotifi];
        }else {
            //关注通知
            cell.switchControl.on = [PMLManager getAttentionNotifi];
        }
    }

    cell.swtichBlock = ^(BOOL isOn) {
        if (indexPath.section == 0){
            //新消息通知
            [PMLManager setNewsNotifi:isOn];
        } else {
            if (indexPath.row == 0){
                //评论通知
                [PMLManager setCommentNotifi:isOn];
            }else {
                //关注通知
                [PMLManager setAttentionNotifi:isOn];
            }
        }
    };
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
    headerView.backgroundColor = kRGBGrayColor(236);
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
@end
