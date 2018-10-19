//
//  PMLSettingNewPWDViewController.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/9.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLSettingNewPWDViewController.h"
#import "PMLSettingTableViewCell.h"
#import "PMLCancelAccountCell.h"
#import "PMLVerifyLoginCell.h"
#import "PMLSettingViewController.h"
#import "UIViewController+PMLViewController.h"

static NSString *const PMLSettingTableViewCellId = @"PMLSettingTableViewCellId";
static NSString *const PMLVerifyLoginCellId = @"PMLVerifyLoginCellId";

@interface PMLSettingNewPWDViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *tableView;
@property (nonatomic, strong)NSString *PWDStr;
@property (nonatomic, copy) NSArray *dataSource;
@property (nonatomic, strong)UIButton *finishBtn;

@end

@implementation PMLSettingNewPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.finishBtn];
    [self setUpTitleViewWithText:kInternationalContent(@"设置新密码") showLine:NO];
    [self setupSubViews];
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    self.dataSource = @[@[kInternationalContent(@"输入原密码")],@[kInternationalContent(@"输入新的密码"), kInternationalContent(@"再次输入密码")]];
    self.tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height - kNavBarHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = kRGBGrayColor(236);
    self.tableView.scrollEnabled = false;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 40;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLSettingTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLSettingTableViewCellId];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLVerifyLoginCell class]) bundle:nil] forCellReuseIdentifier:PMLVerifyLoginCellId];

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
        
        PMLVerifyLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLVerifyLoginCellId forIndexPath:indexPath];
        cell.placeholder = [[self.dataSource objectAtCheckedIndex:indexPath.section] objectAtCheckedIndex:indexPath.row];
        cell.fileEnable = YES;
        cell.arrowImageView.hidden = indexPath.section == 0 ? false : true;
        cell.bottonLine.hidden = indexPath.row == 0 && indexPath.section != 0 ? false : true;
        WeakSelf(weakSelf);
        cell.inputBlock = ^{
            [weakSelf complateEdit];
        };

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(25, 5, 300, 24)];
    view.backgroundColor = [UIColor clearColor];
    PMLBaseLabel *nameLabel = [[PMLBaseLabel alloc] initWithFrame:CGRectMake(25, 5, 300, 24)];
    nameLabel.textColor = [UIColor colorWithHex:@"#1A1A1A"];
    if (section == 0) {
        nameLabel.text = kInternationalContent(@"原密码");
    } else {
        nameLabel.text = kInternationalContent(@"新密码");
    }
    nameLabel.font = [UIFont customPingFRegularFontWithSize:9];
    [nameLabel sizeToFit];
    [view addSubview:nameLabel];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 24;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(25, 5, 300, 24)];
        view.backgroundColor = [UIColor clearColor];
        PMLBaseLabel *nameLabel = [[PMLBaseLabel alloc] initWithFrame:CGRectMake(25, 5, 300, 24)];
        nameLabel.textColor = [UIColor colorWithHex:@"#1A1A1A"];
        nameLabel.text = kInternationalContent(@"6-16位密码、数字或字母（字母开头）");
        nameLabel.font = [UIFont customPingFRegularFontWithSize:9];
        [nameLabel sizeToFit];
        [view addSubview:nameLabel];
        return view;
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 24;
    }
    return 0.01;

}
- (void)complateEdit {
    PMLVerifyLoginCell *cell = (PMLVerifyLoginCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    if (cell.fieldString.length <= 0) {
        self.PWDStr = cell.fieldString;
    }
}

- (void)finfishClicked:(UIButton *)sender {
[self popToViewControllerClass:[PMLSettingViewController class] animated:true];
}

- (UIButton *)finishBtn {
    if (!_finishBtn){
        UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
        [button setTitle:@"完成" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont customPingFMediumFontWithSize:15];
        [button setTitleColor:[UIColor colorWithHex:@"#F02E44"] forState:UIControlStateNormal];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button setBackgroundColor:[UIColor clearColor]];
        [button addTarget:self action:@selector(finfishClicked:) forControlEvents:UIControlEventTouchUpInside];
        _finishBtn = button;
    }
    return _finishBtn;
}
@end
