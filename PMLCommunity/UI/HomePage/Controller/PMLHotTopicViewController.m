//
//  PMLSpecificHotTopicViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/21.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLHotTopicViewController.h"
#import "PMLSpecificHotTopicTableViewCell.h"
#import "PMLHotTopicHeaderView.h"

static NSString *const PMLSpecificHotTopicCellId = @"PMLSpecificHotTopicCellId";

@interface PMLHotTopicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *tableView;
@property (nonatomic, strong) PMLHotTopicHeaderView *headerView;
@end

@implementation PMLHotTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];
        [self setUpTitleViewWithText:kInternationalContent(@"热门话题") showLine:YES];
    [self setUpSubViews];
    // Do any additional setup after loading the view.
}

- (void)setUpSubViews {
    UIBarButtonItem *rightItem = [self createBarBtnWithContent:kImageWithName(@"topic_icon_share") target:self sel:@selector(shareBtnClicked) postion:@"right"];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-kTabBar);
    }];
    self.tableView.tableHeaderView = self.headerView;
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.tableView);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(162);
    }];
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMLSpecificHotTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLSpecificHotTopicCellId forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark-sender touch
- (void)shareBtnClicked
{
    
}

#pragma mark-lazy load
- (PMLBaseTableView *)tableView
{
    if (!_tableView) {
        _tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLSpecificHotTopicTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLSpecificHotTopicCellId];
    }
    return _tableView;
}

- (PMLHotTopicHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [PMLHotTopicHeaderView loadViewFromNib];
    }
    return _headerView;
}
- (void)didReceiveMemoryWarning
{
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
