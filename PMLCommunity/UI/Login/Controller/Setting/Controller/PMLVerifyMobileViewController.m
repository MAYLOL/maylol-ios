//
//  PMLVerifyMobileViewController.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/9.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLVerifyMobileViewController.h"
#import "PMLSettingTableViewCell.h"
#import "PMLCancelAccountCell.h"
#import "PMLGetCodeCell.h"
#import "PMLGetCodeButton.h"
#import "PMLSettingNewPWD1ViewController.h"

static NSString *const PMLSettingTableViewCellId = @"PMLSettingTableViewCellId";
static NSString *const PMLGetCodeCellId = @"PMLGetCodeCellId";

@interface PMLVerifyMobileViewController ()
<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *tableView;
@property (nonatomic, strong)NSString *PWDStr;
@property (nonatomic, strong)UIButton *finishBtn;
@end

@implementation PMLVerifyMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.finishBtn];

    [self setUpTitleViewWithText:kInternationalContent(@"验证手机号") showLine:NO];
    [self setupSubViews];
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    self.tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height - kNavBarHeight) style:UITableViewStylePlain];
    self.tableView.backgroundColor = kRGBGrayColor(236);
    self.tableView.scrollEnabled = false;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 40;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLSettingTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLSettingTableViewCellId];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLGetCodeCell class]) bundle:nil] forCellReuseIdentifier:PMLGetCodeCellId];

    [self.view addSubview:self.tableView];
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0){
        //账号
        PMLSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLSettingTableViewCellId forIndexPath:indexPath];
        cell.centerLabel.hidden = YES;
        cell.leftLabel.hidden = NO;
        cell.rightLabel.hidden = YES;
        cell.bottomLineView.hidden = NO;
        cell.arrowImageView.hidden = YES;
        cell.leftLabel.text = @"+86 15801002807";
        return  cell;
    }
    //验证密码
    PMLGetCodeCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLGetCodeCellId forIndexPath:indexPath];
    cell.placeholder = kInternationalContent(@"输入验证码");
    cell.fileEnable = YES;
    WeakSelf(weakSelf);
    cell.inputBlock = ^{
        [weakSelf complateEdit];
    };
    cell.clickBlock = ^{
        NSLog(@"点击验证码");
    };
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(25, 5, 300, 24)];
    view.backgroundColor = [UIColor clearColor];
    PMLBaseLabel *nameLabel = [[PMLBaseLabel alloc] initWithFrame:CGRectMake(25, 5, 300, 24)];
    nameLabel.textColor = [UIColor colorWithHex:@"#1A1A1A"];
    nameLabel.text = kInternationalContent(@"短信验证码已发送，请输入验证码");
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
- (void)complateEdit {
    PMLGetCodeCell *cell = (PMLGetCodeCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    if (cell.fieldString.length <= 0) {
        self.PWDStr = cell.fieldString;
    }
}

- (void)finfishClicked:(UIButton *)sender {

    [self pushViewControllerWithClassName:NSStringFromClass([PMLSettingNewPWD1ViewController class]) params:nil];

}


- (UIButton *)finishBtn {
    if (!_finishBtn){
        UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
        [button setTitle:@"下一步" forState:UIControlStateNormal];
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
