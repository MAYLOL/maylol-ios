//
//  PMLDrawerView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/20.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLDrawerView.h"
#import "PMLDrawTableViewCell.h"

//标记委托对象是否实现了代理方法, 使用结构体优化方法调用次数
struct DelegateFlags {
    int didFinishSelectedItem : 1;
};

@interface PMLDrawerView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *leftTableView;
@property (nonatomic, strong) PMLBaseTableView *centerTableView;
@property (nonatomic, strong) PMLBaseTableView *rightTableView;
@property (nonatomic, weak) UIViewController *controller;
@property (nonatomic, assign) struct DelegateFlags delegateFlags;
@end

@implementation PMLDrawerView

- (instancetype)initWithFrame:(CGRect)frame controller:(UIViewController *)controller {
    if (self = [super initWithFrame:frame]) {
        _controller = controller;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    
    self.leftTableView = [self createTableView];
    self.leftTableView.backgroundColor = kRGBGrayColor(240);
    [self.leftTableView registerClass:[PMLDrawTableViewCell class] forCellReuseIdentifier:DrawLeftTableViewCellId];
    self.leftTableView.frame = CGRectMake(0, 0, kScreenWidth * 115/375, self.height);
    NSArray *leftDataArr = @[@"热门项目",@"玻尿酸",@"肉毒素",@"皮肤美容",@"眼部整形",@"鼻部整形",@"脂肪填充",@"胸部整形",@"美体塑形",@"抗摔抗初老",@"牙齿美容",@"半永久妆",@"私密整形",@"手部整形",@"眼部整形",@"头部整形",@"j腿部整形",@"你想咋整",@"就这么整",@"开整",];
    for (int i = 0; i < leftDataArr.count; i++) {
        PMLDrawerModel *model = [[PMLDrawerModel alloc] init];
        model.content = leftDataArr[i];
        [self.leftDataArray addObject:model];
    }
    
    NSArray *centerDataArr = @[@"热门项目",@"玻尿酸",@"肉毒素",@"皮肤美容",@"眼部整形",@"鼻部整形",@"脂肪填充",@"胸部整形",@"美体塑形",@"抗摔抗初老",@"牙齿美容",@"半永久妆",@"私密整形",@"手部整形",@"眼部整形",@"头部整形",@"j腿部整形",@"你想咋整",@"就这么整",@"开整",];
    for (int i = 0; i < centerDataArr.count; i++) {
        PMLDrawerModel *model = [[PMLDrawerModel alloc] init];
        model.content = centerDataArr[i];
        [self.centerDataArray addObject:model];
    }
    
    NSArray *rightDataArr = @[@"热门项目",@"玻尿酸",@"肉毒素",@"皮肤美容",@"眼部整形",@"鼻部整形",@"脂肪填充",@"胸部整形",@"美体塑形",@"抗摔抗初老",@"牙齿美容",@"半永久妆",@"私密整形",@"手部整形",@"眼部整形",@"头部整形",@"j腿部整形",@"你想咋整",@"就这么整",@"开整",];
    for (int i = 0; i < rightDataArr.count; i++) {
        PMLDrawerModel *model = [[PMLDrawerModel alloc] init];
        model.content = rightDataArr[i];
        [self.rightDataArray addObject:model];
    }
    
    self.centerTableView = [self createTableView];
    [self.centerTableView registerClass:[PMLDrawTableViewCell class] forCellReuseIdentifier:DrawCenterTableViewCellId];
    self.centerTableView.frame = CGRectMake(self.leftTableView.right, 0, kScreenWidth * 112/375, self.height);
    self.centerTableView.alpha = 0;
    
    self.rightTableView = [self createTableView];
    [self.rightTableView registerClass:[PMLDrawTableViewCell class] forCellReuseIdentifier:DrawRightTableViewCellId];
    self.rightTableView.frame = CGRectMake(self.centerTableView.right, 0, kScreenWidth - self.centerTableView.right, self.height);
    self.rightTableView.alpha = 0;
}

- (PMLBaseTableView *)createTableView {
    PMLBaseTableView *tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 40;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [UIView new];
    [self addSubview:tableView];
    return tableView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

//- (void)layoutSubview {
//    
//}

- (void)layout {
    self.leftTableView.frame = CGRectMake(0, 0, kScreenWidth * 115/375, self.height);
    self.centerTableView.frame = CGRectMake(self.leftTableView.right, 0, kScreenWidth * 112/375, self.height);
    self.rightTableView.frame = CGRectMake(self.centerTableView.right, 0, kScreenWidth - self.centerTableView.right, self.height);
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _leftTableView) {
        return self.leftDataArray.count;
    }else if (tableView == _centerTableView) {
        return self.centerDataArray.count;
    }else {
        return self.rightDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMLDrawTableViewCell *cell;
    if (tableView == _leftTableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:DrawLeftTableViewCellId];
        cell.dataModel = self.leftDataArray[indexPath.row];
    }else if (tableView == _centerTableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:DrawCenterTableViewCellId];
        cell.dataModel = self.centerDataArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:DrawRightTableViewCellId];
        cell.dataModel = self.rightDataArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTableView) {
        PMLDrawerModel *model = self.leftDataArray[indexPath.row];
        if (model.selected) {
            return;
        }
        if (self.centerTableView.alpha == 0) {
            [UIView animateWithDuration:KAnimationDuration animations:^{
                self.centerTableView.alpha = 1;
                self.rightTableView.alpha = 0;
            }];
        }
        
        [UIView animateWithDuration:KAnimationDuration animations:^{
            self.rightTableView.alpha = 0;
        }];
        
        [self.leftDataArray enumerateObjectsUsingBlock:^(PMLDrawerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == indexPath.row) {
                obj.selected = YES;
            }else {
                obj.selected = NO;
            }
        }];
    }else if (tableView == self.centerTableView) {
        PMLDrawerModel *model = self.centerDataArray[indexPath.row];
        if (model.selected) {
            return;
        }
        if (self.rightTableView.alpha == 0) {
            [UIView animateWithDuration:KAnimationDuration animations:^{
                self.rightTableView.alpha = 1;
            }];
        }
        [self.centerDataArray enumerateObjectsUsingBlock:^(PMLDrawerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == indexPath.row) {
                obj.selected = YES;
            }else {
                obj.selected = NO;
            }
        }];
    }else {
        PMLDrawerModel *model = self.rightDataArray[indexPath.row];
        if (model.selected) {
            return;
        }
        [self.rightDataArray enumerateObjectsUsingBlock:^(PMLDrawerModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == indexPath.row) {
                obj.selected = YES;
            }else {
                obj.selected = NO;
            }
        }];
        if (_delegateFlags.didFinishSelectedItem) {
            [self.delegate pmlDrawerView:self didFinishSelectedItem:model.content];
        }
    }
    [self.leftTableView reloadData];
    [self.centerTableView reloadData];
    [self.rightTableView reloadData];
}

#pragma mark--getter
- (NSMutableArray<PMLDrawerModel *> *)leftDataArray {
    if (!_leftDataArray) {
        _leftDataArray = [NSMutableArray array];
    }
    return _leftDataArray;
}

- (NSMutableArray<PMLDrawerModel *> *)centerDataArray {
    if (!_centerDataArray) {
        _centerDataArray = [NSMutableArray array];
    }
    return _centerDataArray;
}

- (NSMutableArray<PMLDrawerModel *> *)rightDataArray {
    if (!_rightDataArray) {
        _rightDataArray = [NSMutableArray array];
    }
    return _rightDataArray;
}

- (void)setDelegate:(id<PMLDrawerViewDelegate>)delegate {
    _delegate = delegate;
    
    _delegateFlags.didFinishSelectedItem = [_delegate respondsToSelector:@selector(pmlDrawerView:didFinishSelectedItem:)];
}

@end


@implementation PMLDrawerModel

@end
