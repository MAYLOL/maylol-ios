//
//  PMLHotSpotViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLHotSpotViewController.h"
#import "PMLHomeGeneralHeaderView.h"
#import "PMLHomeAttentionTableViewCell.h"

static NSString *const PMLHotSpotCellId = @"PMLHotSpotCellId";

@interface PMLHotSpotViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation PMLHotSpotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:@"home_nav_btn_more"];
    [self setupHeaderView];
    // Do any additional setup after loading the view.
}

- (void)setupHeaderView
{
    PMLHomeGeneralHeaderView *headerView = [[PMLHomeGeneralHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) topString:kInternationalContent(@"热点")];
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
    PMLHomeAttentionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLHotSpotCellId forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 400;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark-sender touch
- (void)searchBtnClicked
{
    
}

#pragma mark-lazy load
- (PMLBaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[PMLHomeAttentionTableViewCell class] forCellReuseIdentifier:PMLHotSpotCellId];
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
