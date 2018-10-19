//
//  PMLChangePWDViewController.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/9.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLChangePWDViewController.h"
#import "PMLSettingTableViewCell.h"
#import "PMLCancelAccountCell.h"
#import "PMLCancelAccountViewController.h"
#import "PMLAddressSessionView.h"
#import "PMLSettingNewPWDViewController.h"
#import "PMLVerifyMobileViewController.h"

static NSString *const PMLSettingTableViewCellId = @"PMLSettingTableViewCellId";

@interface PMLChangePWDViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *tableView;
@property (nonatomic, copy) NSArray *dataSource;

@end

@implementation PMLChangePWDViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];
    [self setUpTitleViewWithText:kInternationalContent(@"身份验证") showLine:NO];
    [self setupSubViews];
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    self.dataSource = @[kInternationalContent(@"手机验证"),kInternationalContent(@"密码验证")];
    self.tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height - kNavBarHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = kRGBGrayColor(236);
    self.tableView.scrollEnabled = false;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 40;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLSettingTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLSettingTableViewCellId];
    [self.view addSubview:self.tableView];
}

#pragma mark-UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    PMLSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLSettingTableViewCellId forIndexPath:indexPath];
    //修改密码
    cell.centerLabel.hidden = YES;
    cell.leftLabel.hidden = NO;
    cell.rightLabel.hidden = YES;
    cell.bottomLineView.hidden = true;
    if (indexPath.row == 0){
        cell.bottomLineView.hidden = false;
    }
    cell.arrowImageView.hidden = NO;
    cell.leftLabel.text = [self.dataSource objectAtCheckedIndex:indexPath.row];
    return  cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0){
        //手机
        [self pushViewControllerWithClassName:NSStringFromClass([PMLVerifyMobileViewController class]) params:nil];
        return;
    }
    //密码
    [self pushViewControllerWithClassName:NSStringFromClass([PMLSettingNewPWDViewController class]) params:nil];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(25, 5, 300, 24)];
    view.backgroundColor = [UIColor clearColor];
   PMLBaseLabel *nameLabel = [[PMLBaseLabel alloc] initWithFrame:CGRectMake(25, 5, 300, 24)];
    nameLabel.textColor = [UIColor colorWithHex:@"#1A1A1A"];
    nameLabel.text = kInternationalContent(@"请先进行身份验证");
    nameLabel.font = [UIFont customPingFRegularFontWithSize:9];
    [nameLabel sizeToFit];
    [view addSubview:nameLabel];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 24;
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
