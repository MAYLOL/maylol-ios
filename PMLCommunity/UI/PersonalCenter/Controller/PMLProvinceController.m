//
//  PMLProvinceController.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/26.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLProvinceController.h"
#import "PMLCityController.h"
#import "PMLManager.h"
#import "PMLAddressSessionView.h"
#import "PMLAddressCell.h"
#import "UIViewController+PMLViewController.h"
#import "PMLFillInfoViewController.h"
#import "PMLManager.h"

static NSString *const TableViewCellID = @"TableViewCellID";
static NSString *const PMLAddressCellID = @"PMLAddressCellID";

@interface PMLProvinceController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *tableView;
@end

@implementation PMLProvinceController

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

    return self.isSeSelect ? [PMLManager shared].selectCountryModel.provinces.count : [PMLManager shared].addressModel.data[self.provinceRow].provinces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   PMLProvinceModel *provinceModel = self.isSeSelect ? [PMLManager shared].selectCountryModel.provinces[indexPath.row] : [PMLManager shared].addressModel.data[self.provinceRow].provinces[indexPath.row];

    PMLAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLAddressCellID forIndexPath:indexPath];
    cell.nameLabel.text = provinceModel.name;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (provinceModel.cities.count == 0){
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PMLProvinceModel *provinceModel = self.isSeSelect ? [PMLManager shared].selectCountryModel.provinces[indexPath.row] : [PMLManager shared].addressModel.data[self.provinceRow].provinces[indexPath.row];

    if (provinceModel.cities.count == 0){
        PMLCountryModel *countryModel = self.isSeSelect ? [PMLManager shared].selectCountryModel : [PMLManager shared].addressModel.data[self.provinceRow];
        
        [PMLManager shared].selectCountryModel = countryModel;
        [PMLManager shared].selectProvinceModel = provinceModel;
        [PMLManager shared].selectCityModel = nil;
        [self popToViewControllerClass:[PMLFillInfoViewController class] animated:true];
        return;
    }
    PMLCityController *cityVC = [PMLCityController new];
    cityVC.provinceRow = self.provinceRow;
    cityVC.cityRow = indexPath.row;
    cityVC.isSeSelect = self.isSeSelect;
    [self.navigationController pushViewController:cityVC animated:true];
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
