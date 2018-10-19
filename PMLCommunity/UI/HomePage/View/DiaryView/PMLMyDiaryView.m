//
//  PMLMyDiaryView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/14.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLMyDiaryView.h"
#import "PMLMyDiaryTableViewCell.h"
#import "PMLBaseViewController.h"
#import "PMLPublishBeautyDiaryViewController.h"

static NSString *const PMLMyDiaryCellId = @"PMLMyDiaryCellId";
@interface PMLMyDiaryView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *tableView;
@property (nonatomic, weak) PMLBaseViewController *viewController;
@end

@implementation PMLMyDiaryView

- (instancetype)initWithFrame:(CGRect)frame controller:(PMLBaseViewController *)controller {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
        _viewController = controller;
    }
    return self;
}

- (void)setupSubViews {
    [self addSubview:[self createHeaderView]];
    [self addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, 90, self.width, self.height - 90);
}


#pragma mark-UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMLMyDiaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLMyDiaryCellId forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark-lazy load
- (PMLBaseView *)createHeaderView {
    PMLBaseView *headerView = [[PMLBaseView alloc] init];
    
    [headerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(writeDiary)]];
    headerView.frame = CGRectMake(15, 16, kScreenWidth - 30, 65);
    UIImageView *addImageView = [[UIImageView alloc] init];
    addImageView.image = kImageWithName(@"beautiful_icon_newtext");
    [headerView addSubview:addImageView];
    [addImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.right.equalTo(headerView.mas_centerX).offset(-20);
        make.width.height.mas_equalTo(30);
    }];
    PMLBaseLabel *addLabel = [[PMLBaseLabel alloc] init];
    addLabel.text = kInternationalContent(@"新建日记");
    addLabel.font = [UIFont customPingFSemiboldFontWithSize:18];
    [headerView addSubview:addLabel];
    [addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addImageView.mas_right).offset(13);
        make.centerY.equalTo(headerView);
        make.right.equalTo(headerView).offset(-10);
    }];
    
    headerView.layer.cornerRadius = 10;
    headerView.layer.shadowColor = kRGBAColor(128, 128, 128, 0.15).CGColor;
    headerView.layer.shadowOffset = CGSizeMake(1, 1);
    headerView.layer.shadowRadius = 5;
    headerView.layer.shadowOpacity = 1.0;
    return headerView;
}

- (PMLBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 150;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[PMLMyDiaryTableViewCell class] forCellReuseIdentifier:PMLMyDiaryCellId];
    }
    return _tableView;
}

#pragma mark-sender touch
- (void)writeDiary {
    PMLPublishBeautyDiaryViewController *vc = [[PMLPublishBeautyDiaryViewController alloc] initWithNibName:NSStringFromClass([PMLPublishBeautyDiaryViewController class]) bundle:nil];
    [_viewController.navigationController pushViewController:vc animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
