//
//  PMLTopicViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/15.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLHomeTopicViewController.h"
#import "PMLBeautyDiaryViewController.h"
#import "PMLRecommendTopicViewController.h"
#import "PMLTabkePartTpoicViewController.h"
#import "PMLRecommendTopicGeneralTableViewCell.h"
#import "PMLHomeRecommendTopicTableViewCell.h"
#import "PMLHotTopicListViewController.h"
#import "PMLHomeHotTopicTableViewCell.h"
#import "PMLBeautyDiaryTableViewCell.h"
#import "PMLTopicSectionHeaderView.h"
#import "PMLFreeButton.h"

static NSString *const PMLRecommendTopicGeneralCellId = @"PMLRecommendTopicGeneralCellId";
static NSString *const PMLHomeHotTopicCellId = @"PMLHomeHotTopicCellId";
static NSString *const PMLBeautyDiaryCellId = @"PMLBeautyDiaryCellId";
static NSString *const PMLTopicSectionHeaderViewId = @"PMLTopicSectionHeaderViewId";


@interface PMLHomeTopicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) PMLBaseView *headerView;
@property (nonatomic, strong) PMLBaseTableView *tableView;
@end

@implementation PMLHomeTopicViewController
//热门话题
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    [self showNavigationBarShadowImage];
    // Do any additional setup after loading the view.
}

- (void)setupSubviews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    self.tableView.tableHeaderView = self.headerView;
    NSArray *imageArray = @[@"topic_btn_beautiful",@"topic_btn_hot",@"topic_btn_recommend",@"topic_btn_partake"];
    NSArray *titleArray = @[kInternationalContent(@"美丽日记"),kInternationalContent(@"热门话题"),kInternationalContent(@"推荐话题"),kInternationalContent(@"参与话题")];
    CGFloat buttonWidth = (kScreenWidth - 50 * 3 - 27 * 2)/4;
    CGFloat buttonHeight = 62;
    for (int i = 0; i < 4; i++) {
        PMLFreeButton *button = [PMLFreeButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageFromColor:kRandomColor size:CGSizeMake(40, 40)] forState:UIControlStateNormal];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        UIImage *image = kImageWithName(imageArray[i]);
        [button setImage:image forState:UIControlStateNormal];
        [button setTitleColor:kRGBGrayColor(102) forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont customPingFRegularFontWithSize:12];
        [button setUpImageViewSize:CGSizeMake(40, 40) margin:10 alignment:PMLFreeBtnAlignmentVerticalFill];
        button.tag = 10 + i;
        [self.headerView addSubview:button];
        [button addTarget:self action:@selector(classifyClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(27 + i * (buttonWidth + 50), self.headerView.height - 62, buttonWidth, buttonHeight);
    }
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
        {
            return 2;
        }
            break;
        case 1:
        {
            return 2;
        }
        case 2:
        {
            return 2;
        }
        default:
            break;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            //推荐话题
            PMLRecommendTopicGeneralTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLRecommendTopicGeneralCellId forIndexPath:indexPath];
            return cell;
        }
            break;
        case 1:
        {
            //热门话题
            PMLHomeHotTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLHomeHotTopicCellId forIndexPath:indexPath];
            return cell;
        }
            break;
        case 2:
        {
            //美丽日记
            PMLBeautyDiaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLBeautyDiaryCellId forIndexPath:indexPath];
            return cell;
        }
            break;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PMLTopicSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:PMLTopicSectionHeaderViewId];
    headerView.typeString = kInternationalContent(@"美丽日记");
    headerView.headerIndex = section;
    WeakSelf(weakSelf);
    headerView.headerViewBlock = ^(NSInteger index) {
        [weakSelf classifyClicked:(UIButton *)[weakSelf.headerView viewWithTag:12 - section]];
    };
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            return 107;
        }
            break;
        case 1:
        {
            return 80;
        }
            break;
        case 2:
        {
            return 280;
        }
        case 3:
        {
            return 90;
        }
            break;
        default:
        {
            return 1;
        }
            break;
    }
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 46;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark-sender touch
- (void)classifyClicked:(UIButton *)sender {
    switch (sender.tag) {
        case 10:
        {
            //美丽日记
            [self pushViewControllerWithClassName:NSStringFromClass([PMLBeautyDiaryViewController class]) params:nil];
        }
            break;
        case 11:
        {
            //热门话题
            [self pushViewControllerWithClassName:NSStringFromClass([PMLHotTopicListViewController class]) params:nil];
        }
            break;
        case 12:
        {
            //推荐话题
            [self pushViewControllerWithClassName:NSStringFromClass([PMLRecommendTopicViewController class]) params:nil];
        }
            break;
        case 13:
        {
            //参与话题
            [self pushViewControllerWithClassName:NSStringFromClass([PMLTabkePartTpoicViewController class]) params:nil];
        }
            break;
        default:
            break;
    }
}

#pragma mark-lazy load
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLHomeHotTopicTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLHomeHotTopicCellId];
        //推荐话题
        [_tableView registerClass:[PMLRecommendTopicGeneralTableViewCell class] forCellReuseIdentifier:PMLRecommendTopicGeneralCellId];
        //美丽日记
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLBeautyDiaryTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLBeautyDiaryCellId];
        
        [_tableView registerClass:[PMLTopicSectionHeaderView class] forHeaderFooterViewReuseIdentifier:PMLTopicSectionHeaderViewId];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (PMLBaseView *)headerView {
    if (!_headerView) {
        _headerView = [[PMLBaseView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    }
    return _headerView;
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
