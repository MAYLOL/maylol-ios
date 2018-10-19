//
//  PMLTabkePartTpoicViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLTabkePartTpoicViewController.h"
#import "PMLHomeParticipateTopicTableViewCell.h"

static NSString *const PMLParticipateTopicCellId = @"PMLParticipateTopicCellId";

@interface PMLTabkePartTpoicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation PMLTabkePartTpoicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];
    [self setUpTitleViewWithText:kInternationalContent(@"参与话题") showLine:YES];
    [self setupSubViews];
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    self.tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height - kNavBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLHomeParticipateTopicTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLParticipateTopicCellId];
    [self.view addSubview:self.tableView];
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMLHomeParticipateTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLParticipateTopicCellId forIndexPath:indexPath];
    return cell;
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
