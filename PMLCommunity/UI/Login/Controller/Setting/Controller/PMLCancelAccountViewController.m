//
//  PMLCancelAccountViewController.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/9.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLCancelAccountViewController.h"
#import "PMLSettingTableViewCell.h"
#import "PMLCancelAccountCell.h"
#import "PMLVerifyLoginCell.h"
#import "PMLCancelAccountFinishViewController.h"
#import "UIViewController+PMLViewController.h"
#import "PMLForgetViewController.h"

static NSString *const PMLSettingTableViewCellId = @"PMLSettingTableViewCellId";
static NSString *const PMLVerifyLoginCellId = @"PMLVerifyLoginCellId";

@interface PMLCancelAccountViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *tableView;
@property (nonatomic, strong)NSString *PWDStr;
@property (nonatomic, strong)UIButton *cancelBtn;
@property (nonatomic, strong)UIButton *forgetBtn;
@property (nonatomic, strong)UIView *footerView;

@end

@implementation PMLCancelAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];
    [self setUpTitleViewWithText:kInternationalContent(@"注销账号") showLine:NO];
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
    self.tableView.estimatedSectionFooterHeight = 17;
    self.tableView.tableFooterView = self.footerView;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLSettingTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLSettingTableViewCellId];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLVerifyLoginCell class]) bundle:nil] forCellReuseIdentifier:PMLVerifyLoginCellId];

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
        cell.rightLabel.hidden = NO;
        cell.bottomLineView.hidden = NO;
        cell.arrowImageView.hidden = YES;
        cell.rightLabel.text = @"15801002807";
        return  cell;
    }
    //验证密码
    PMLVerifyLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLVerifyLoginCellId forIndexPath:indexPath];
    cell.placeholder = kInternationalContent(@"验证登录密码");
    cell.fileEnable = YES;
    WeakSelf(weakSelf);
    cell.inputBlock = ^{
        [weakSelf complateEdit];
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (void)complateEdit {
    PMLVerifyLoginCell *cell = (PMLVerifyLoginCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    if (cell.fieldString.length <= 0) {
        self.PWDStr = cell.fieldString;
    }
}

- (void)cancelClicked:(UIButton *)sender{
    NSString *titleA = kInternationalContent(@"重要提示");
    NSString *messageA = kInternationalContent(@"继续操作，你的账号将被注销 其他人也无法找到你的信息");
//    NSMutableParagraphStyle *paragraphTitleStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphTitleStyle.paragraphSpacing = -15;
//    paragraphTitleStyle.alignment = NSTextAlignmentCenter;
//    NSMutableAttributedString *titleAtt = [[NSMutableAttributedString alloc] initWithString:titleA attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:11                                                                     ],
//                                                                                                                NSForegroundColorAttributeName:[UIColor colorWithHex:@"#000000"],
//                                                                                                               NSParagraphStyleAttributeName:paragraphTitleStyle
//
//                                                                                                                }];
////    //改变message的大小和颜色
//    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
//    paragraph.alignment =NSTextAlignmentCenter;//设置对齐方式
//    paragraph.paragraphSpacing = 41;
//
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.paragraphSpacingBefore = 6;
//
//    NSMutableAttributedString *messageAtt = [[NSMutableAttributedString alloc] initWithString:messageA attributes:@{
//                                                                                                                                                                                                                                      NSFontAttributeName:[UIFont systemFontOfSize:9]                                                                                                                   ,
//                                                                                                                   NSParagraphStyleAttributeName:paragraph
//
//                                                                                                                   }];
//
//
//    [messageAtt addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHex:@"#1A1A1A"] range:NSMakeRange(0, messageA.length)];

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleA message:messageA preferredStyle:UIAlertControllerStyleAlert];
    typeof(self) __weak weakSelf = self;

    UIAlertAction *action = [UIAlertAction actionWithTitle:kInternationalContent(@"确认注销") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        typeof(weakSelf) __strong strongSelf = weakSelf;
        [strongSelf pushViewControllerWithClassName:NSStringFromClass([PMLCancelAccountFinishViewController class]) params:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:kInternationalContent(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {

    }];
//    [alert setValue:titleAtt forKey:@"attributedTitle"];
//    [alert setValue:messageAtt forKey:@"attributedMessage"];
    [alert addAction:action];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)forgetClicked:(UIButton *)sender{

    PMLForgetViewController *forgetVC = [PMLForgetViewController new];
    forgetVC.isSetting = true;
    [self.navigationController pushViewController:forgetVC animated:true];
}

- (UIView *)footerView {
    if (!_footerView){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
        view.backgroundColor = [UIColor clearColor];
        [view addSubview:self.cancelBtn];
        [view addSubview:self.forgetBtn];
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top).offset(17);
            make.left.equalTo(view.mas_left).offset(17);
            make.right.equalTo(view.mas_right).offset(-17);
            make.height.mas_equalTo(40);
        }];
        [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.cancelBtn.mas_bottom).offset(0);
            make.left.equalTo(view.mas_left).offset(17);
            make.right.equalTo(view.mas_right).offset(-17);
            make.height.mas_equalTo(40);
        }];
        _footerView = view;

    }
    return _footerView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn){
        UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
        [button setTitle:@"申请注销" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont customPingFMediumFontWithSize:11];
        [button setTitleColor:[UIColor colorWithHex:@"#ECECEC"] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor colorWithHex:@"#CCCCCC"]];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button addTarget:self action:@selector(cancelClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.cornerRadius = 3;
        button.layer.masksToBounds = true;
        _cancelBtn = button;
    }
    return _cancelBtn;
}
- (UIButton *)forgetBtn {
    if (!_forgetBtn){
        UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
        [button setTitle:@"忘记密码？" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont customPingFMediumFontWithSize:8];
        [button setTitleColor:[UIColor colorWithHex:@"#F02E44"] forState:UIControlStateNormal];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button setBackgroundColor:[UIColor clearColor]];
        [button addTarget:self action:@selector(forgetClicked:) forControlEvents:UIControlEventTouchUpInside];
        _forgetBtn = button;
    }
    return _forgetBtn;
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
