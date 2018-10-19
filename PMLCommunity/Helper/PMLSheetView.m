//
//  PMLSheetView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/18.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLSheetView.h"
#import "PMLMaskView.h"

#define TableViewTopMargin  25

static NSString *const SheerViewCellId = @"SheerViewCellId";

@interface PMLSheetView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) SheetViewBlock sheetViewBlock;
@property (nonatomic, strong) PMLBaseTableView *tableView;
@property (nonatomic, strong) PMLMaskView *maskView;
@property (nonatomic, copy) NSArray <NSString *> *dataSource;
@end

@implementation PMLSheetView

- (instancetype)initWithDatasource:(NSArray<NSString *> *)datasource complate:(SheetViewBlock)complate{
    
    if (self = [super initWithFrame:CGRectZero]) {
        _dataSource = datasource;
        _sheetViewBlock = complate;
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    _tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 56;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(TableViewTopMargin, 0, iPhone_X_Bottom_Safe, 0));
    }];
//    _tableView regis
}

#pragma mark-UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SheerViewCellId];
    PMLBaseLabel *titleLabel;
    PMLBaseView *lineView;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SheerViewCellId];
        titleLabel = [[PMLBaseLabel alloc] init];
        titleLabel.font = [UIFont customPingFMediumFontWithSize:15];
        [titleLabel sizeToFit];
        [cell.contentView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(cell.contentView);
        }];
        
        lineView = [[PMLBaseView alloc] init];
        lineView.backgroundColor = kRGBGrayColor(242);
        [cell.contentView addSubview:lineView];
        NSLog(@"%@",NSStringFromCGRect(cell.frame));
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.contentView).offset(25);
            make.right.equalTo(cell.contentView).offset(-25);
            make.bottom.equalTo(cell.mas_bottom);
            make.height.mas_equalTo(1);
        }];
    }
    if (indexPath.row == 0) {
        titleLabel.textColor = kRGBColor(240, 46, 68);
    }else {
        titleLabel.textColor = kRGBGrayColor(26);
    }
    
    if (indexPath.row == self.dataSource.count) {
        lineView.hidden = YES;
        titleLabel.text = kInternationalContent(@"取消");
    }else {
        lineView.hidden = NO;
        titleLabel.text = self.dataSource[indexPath.row];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == self.dataSource.count) {
        [self cancel];
    }else {
        if (self.sheetViewBlock) {
            self.sheetViewBlock(indexPath.row);
            [self cancel];
        }
    }
}

- (void)show {
    self.maskView = [[PMLMaskView alloc] initMaskViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) target:self select:@selector(cancel)];
    self.maskView.alpha = 0;
    [kApplication.keyWindow addSubview:self.maskView];
    self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 56 * (self.dataSource.count + 1) + TableViewTopMargin + iPhone_X_Bottom_Safe);
    [kApplication.keyWindow addSubview:self];
    [self setCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    [UIView animateWithDuration:KAnimationDuration animations:^{
        self.y = kScreenHeight - self.height;
        self.maskView.alpha = kMaskAlpha;
    }];
}

- (void)cancel {
    [UIView animateWithDuration:KAnimationDuration animations:^{
        self.maskView.alpha = 0;
        self.y = kScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.maskView removeFromSuperview];
    }];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
