//
//  PMLPersonalDiaryListViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLPersonalDiaryListViewController.h"
#import "PMLPersonalDiaryListTableViewCell.h"
#import "PMLPersonalDiaryListHeaderView.h"

static NSString *const PMLPersonalDiaryListCellId = @"PMLPersonalDiaryListCellId";

@interface PMLPersonalDiaryListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *tableView;
@property (nonatomic, strong) PMLPersonalDiaryListHeaderView *headerView;
@end

@implementation PMLPersonalDiaryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];

    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.headerView.frame = CGRectMake(0, 0, kScreenWidth, 155);
    self.tableView.tableHeaderView = self.headerView;
    [self showNavigationBarShadowImage];
    [self setUpTitleViewWithText:kInternationalContent(@"美丽日记") showLine:NO];
    // Do any additional setup after loading the view.
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMLPersonalDiaryListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLPersonalDiaryListCellId forIndexPath:indexPath];
    return cell;
}


#pragma mark-lazy load
- (PMLBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 290;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLPersonalDiaryListTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLPersonalDiaryListCellId];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (PMLPersonalDiaryListHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[PMLPersonalDiaryListHeaderView alloc] init];
    }
    return _headerView;
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
