//
//  PMLActivityViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLActivityViewController.h"
#import "PMLHomeGeneralHeaderView.h"
#import "PMLActivityTableViewCell.h"

static NSString *const PMLActivityCellId = @"PMLActivityCellId";

@interface PMLActivityViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *tableView;
@end

@implementation PMLActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:@"home_nav_btn_more"];
    [self setUpSubViews];
    // Do any additional setup after loading the view.
}

- (void)setUpSubViews
{
    PMLHomeGeneralHeaderView *headerView = [[PMLHomeGeneralHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) topString:kInternationalContent(@"活动资讯")];
    headerView.searchBlock = ^{
        
    };
    [self.view addSubview:headerView];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(headerView.mas_bottom);
        make.bottom.equalTo(self.view).offset(-kTabBar);
    }];
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PMLActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLActivityCellId forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 320;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark-lazy load
- (PMLBaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLActivityTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLActivityCellId];
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
