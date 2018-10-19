//
//  PMLHotTopicListViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLHotTopicListViewController.h"
#import "PMLHotTopicViewController.h"
#import "PMLHotTopicListTableViewCell.h"

static NSString *const PMLHotTopicListCellId = @"PMLHotTopicListCellId";

@interface PMLHotTopicListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *tableView;
@end

@implementation PMLHotTopicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavLeftButton:nil];
    [self setUpTitleViewWithText:kInternationalContent(@"热门话题") showLine:YES];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self showNavigationBarShadowImage];
    // Do any additional setup after loading the view.
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMLHotTopicListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLHotTopicListCellId forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushViewControllerWithClassName:NSStringFromClass([PMLHotTopicViewController class]) params:nil];
}

#pragma mark-lazy load
- (PMLBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 90;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLHotTopicListTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLHotTopicListCellId];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
