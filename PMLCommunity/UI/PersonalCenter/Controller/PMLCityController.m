//
//  PMLCityController.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/26.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLCityController.h"
#import "PMLManager.h"
#import "PMLAddressSessionView.h"
#import "PMLAddressCell.h"
#import "UIViewController+PMLViewController.h"
#import "PMLFillInfoViewController.h"

static NSString *const TableViewCellID = @"TableViewCellID";
static NSString *const PMLAddressCellID = @"PMLAddressCellID";

@interface PMLCityController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *tableView;

@end

@implementation PMLCityController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpTitleViewWithText:kInternationalContent(@"地区") showLine:false];
    [self addNavLeftButton:nil];
    [self.view addSubview:self.tableView];
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.isSeSelect ? [PMLManager shared].selectCountryModel.provinces[self.cityRow].cities.count : [PMLManager shared].addressModel.data[self.provinceRow].provinces[self.cityRow].cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PMLCityModel *cityModel = self.isSeSelect ? [PMLManager shared].selectCountryModel.provinces[self.cityRow].cities[indexPath.row] : [PMLManager shared].addressModel.data[self.provinceRow].provinces[self.cityRow].cities[indexPath.row];

    PMLAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLAddressCellID forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.nameLabel.text = cityModel.name;
    cell.textLabel.textColor = [UIColor colorWithHex:@"#1A1A1A"];
    cell.textLabel.font =  [UIFont customPingFRegularFontWithSize:15];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PMLCountryModel *countryModel = self.isSeSelect ? [PMLManager shared].selectCountryModel : [PMLManager shared].addressModel.data[self.provinceRow];

   PMLProvinceModel *provinceModel = self.isSeSelect ? [PMLManager shared].selectCountryModel.provinces[self.cityRow] : [PMLManager shared].addressModel.data[self.provinceRow].provinces[self.cityRow];

    PMLCityModel *cityModel =  self.isSeSelect ? [PMLManager shared].selectCountryModel.provinces[self.cityRow].cities[indexPath.row] : [PMLManager shared].addressModel.data[self.provinceRow].provinces[self.cityRow].cities[indexPath.row];

    [PMLManager shared].selectCountryModel = countryModel;
    [PMLManager shared].selectProvinceModel = provinceModel;
    [PMLManager shared].selectCityModel = cityModel;
    [self popToViewControllerClass:[PMLFillInfoViewController class] animated:true];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerId"];
    if (footerView == nil) {
        footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"footerId"];
        PMLAddressSessionView *backView = [[PMLAddressSessionView alloc] initWithFrame:footerView.bounds];
        backView.nameLabel.text = kInternationalContent(@"全部");
        [footerView addSubview:backView];
    }
    return footerView;
};

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 40;
//}

#pragma mark-lazy load
- (PMLBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height- kNavBarHeight - iPhone_X_Bottom_Safe) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = kRGBColor(236, 236, 236);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableViewCellID];
        [_tableView registerClass:[PMLAddressCell class] forCellReuseIdentifier:PMLAddressCellID];
    }
    return _tableView;
}

@end
