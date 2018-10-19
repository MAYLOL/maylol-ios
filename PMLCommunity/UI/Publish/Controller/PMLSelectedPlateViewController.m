//
//  PMLSelectedPlateViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/21.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLSelectedPlateViewController.h"
#import "PMLSelectedItemView.h"
#import "PMLBaseTableViewCell.h"
#import "PMLSelectedPlateHeaderView.h"
#import "PMLSelectedPlateTableViewCell.h"

@interface PMLSelectedPlateViewController ()<UITableViewDelegate,UITableViewDataSource,PMLSelectedItemViewDelegate,PMLSelectedPlateHeaderViewDelegate>
@property (nonatomic, strong) PMLBaseTableView *tableView;
@property (nonatomic, strong) PMLSelectedItemView *itemView;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, copy) NSArray *contentArray;
@property (nonatomic, strong) NSMutableArray <NSNumber *>*selectedArray;
@end

@implementation PMLSelectedPlateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];
    [self setUpTitleViewWithText:kInternationalContent(@"选择板块") showLine:NO];
    [self setupSubViews];
    // Do any additional setup after loading the view.
}

- (void)navLeftButtonClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedPlate:)]) {
        NSMutableArray *items = [self.itemView allItemsContent];
        NSInteger count = items.count;
        NSString *plate = @"";
        for (NSInteger i = 0; i < count; i++) {
            if (i == count-1) {
                plate = [plate stringByAppendingString:items[i]];
            }else {
                plate = [plate stringByAppendingString:[NSString stringWithFormat:@"%@-",items[i]]];
            }
        }
        
        [self.delegate selectedPlate:plate];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupSubViews {
    self.itemView = [[PMLSelectedItemView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    self.itemView.delegate = self;
    self.itemView.showTitle = NO;
    [self.view addSubview:self.itemView];
    
    self.titleArray = @[kInternationalContent(@"医美"),kInternationalContent(@"彩妆"),kInternationalContent(@"护肤"),kInternationalContent(@"时尚"),kInternationalContent(@"大健康"),kInternationalContent(@"母婴"),kInternationalContent(@"随机")];
    for (int i = 0; i < self.titleArray.count; i++) {
        [self.selectedArray addObject:@0];
    }
    self.contentArray = @[kInternationalContent(@"面部填充"),kInternationalContent(@"形体雕塑"),kInternationalContent(@"玻尿酸"),kInternationalContent(@"脂肪填充失败修复")];
    
    self.tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectMake(0, self.itemView.bottom, kScreenWidth, self.view.height - self.itemView.bottom - kNavBarHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 45;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[PMLSelectedPlateHeaderView class] forHeaderFooterViewReuseIdentifier:@"header"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLSelectedPlateTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
}

- (void)refreshLayout:(CGFloat)itemViewHeight {
    [UIView animateWithDuration:KAnimationDuration animations:^{
        self.itemView.height = itemViewHeight;
        self.tableView.y = self.itemView.bottom;
        self.tableView.height = self.view.height - self.itemView.bottom;
    }];
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.selectedArray[section] intValue] == 0) {
        return 0;
    }else {
        return self.contentArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMLSelectedPlateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row < self.contentArray.count - 1) {
        cell.showLine = NO;
    }else {
        cell.showLine = YES;
    }
    cell.content = self.contentArray[indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PMLSelectedPlateHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    headerView.delegate = self;
    headerView.section = section;
    headerView.content = self.titleArray[section];
    headerView.selected = [self.selectedArray[section] boolValue];
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WeakSelf(weakSelf);
    if (self.selectedIndexPath == indexPath) {
        return;
    }
    self.selectedIndexPath = indexPath;
    [self.itemView deleteAllItems];
    [self.itemView refreshItemViewWithContent:@[self.titleArray[indexPath.section],self.contentArray[indexPath.row]] complete:^(CGFloat itemViewHeight) {
        [weakSelf refreshLayout:itemViewHeight];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

#pragma mark-PMLSelectedPlateHeaderViewDelegate
- (void)headerView:(PMLSelectedPlateHeaderView *)headerView didSelectHeaderAtSection:(NSInteger)section selectedState:(BOOL)selectState{
    if (selectState) {
        [self.selectedArray replaceObjectAtIndex:section withObject:@1];
    }else {
        [self.selectedArray replaceObjectAtIndex:section withObject:@0];
    }
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:section];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark-PMLSelectedItemViewDelegate
- (void)deleteItemComplete:(CGFloat)itemViewHeight {
    [self refreshLayout:itemViewHeight];
}


#pragma mark-getter
- (NSMutableArray *)selectedArray {
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}
@end
