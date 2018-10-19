//
//  PMLDiaryMenuView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/14.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLDiaryMenuView.h"
#import "PMLDiaryMenuTableViewCell.h"

static NSString *const LeftCellId = @"LeftCellId";
static NSString *const CenterCellId = @"CenterCellId";
static NSString *const RightCellId = @"RightCellId";

@interface PMLDiaryMenuView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *leftTableView;
@property (nonatomic, strong) PMLBaseTableView *centerTableView;
@property (nonatomic, strong) PMLBaseTableView *rightTableView;
@end

@implementation PMLDiaryMenuView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    self.leftTableView = [self createtableViewWithIdentifier:LeftCellId];
    self.centerTableView = [self createtableViewWithIdentifier:CenterCellId];
    self.rightTableView = [self createtableViewWithIdentifier:RightCellId];
}

- (PMLBaseTableView *)createtableViewWithIdentifier:(NSString *)identifier {
    PMLBaseTableView *tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 40;
    [tableView registerClass:[PMLDiaryMenuTableViewCell class] forCellReuseIdentifier:identifier];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    return tableView;
}
#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.leftTableView) {
        PMLDiaryMenuTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:LeftCellId forIndexPath:indexPath];
        cell.type = Left;
        return cell;
    }else if (tableView == self.centerTableView) {
        PMLDiaryMenuTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:CenterCellId forIndexPath:indexPath];
        cell.type = Center;
        return cell;
    }else {
        PMLDiaryMenuTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:RightCellId forIndexPath:indexPath];
        cell.type = Right;
        return cell;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
