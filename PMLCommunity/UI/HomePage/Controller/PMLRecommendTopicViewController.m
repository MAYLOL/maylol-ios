//
//  PMLRecommendTopicViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLRecommendTopicViewController.h"
#import "PMLHomeRecommendTopicTableViewCell.h"
#import "PMLTopicDetailViewController.h"
#import "PMLShareUtilty.h"

static NSString *const PMLHomeRecommendTopicCellId = @"PMLHomeRecommendTopicCellId";
@interface PMLRecommendTopicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *tableView;
@end

@implementation PMLRecommendTopicViewController
//推荐话题
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];
    [self setUpTitleViewWithText:kInternationalContent(@"推荐话题") showLine:YES];
    [self setupSubViews];
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMLHomeRecommendTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLHomeRecommendTopicCellId forIndexPath:indexPath];
    WeakSelf(weakSelf);
    cell.recommendTopicBLock = ^(NSInteger index) {
        [[PMLShareUtilty defaultUtility] shareWithUrl:nil title:nil desc:nil icon:nil respVC:weakSelf];
    };
    cell.cellIndex = indexPath.row;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self pushViewControllerWithClassName:NSStringFromClass([PMLTopicDetailViewController class]) params:nil];
}

#pragma mark-lazy load
- (PMLBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 160;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLHomeRecommendTopicTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLHomeRecommendTopicCellId];
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
