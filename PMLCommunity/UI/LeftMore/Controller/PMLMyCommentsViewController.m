//
//  PMLMyCommentsViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/24.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLMyCommentsViewController.h"
#import "PMLMyCommentsTableViewCell.h"

static NSString *const PMLMyCommentsCellId = @"PMLMyCommentsCellId";

@interface PMLMyCommentsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *tableView;
@end

@implementation PMLMyCommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];
    [self setUpTitleViewWithText:kInternationalContent(@"我的评论") showLine:NO];
    [self setupSubViews];
    [self showNavigationBarShadowImage];
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    self.tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height - kNavBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLMyCommentsTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLMyCommentsCellId];
    [self.view addSubview:self.tableView];
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMLMyCommentsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLMyCommentsCellId forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 206;
}

@end
