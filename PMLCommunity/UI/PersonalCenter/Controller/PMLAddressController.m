//
//  PMLAddressController.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/26.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLAddressController.h"
#import "PMLAddressModel.h"
#import "PMLProvinceController.h"
#import "PMLCityController.h"
#import "PMLAddressSessionView.h"
#import "PMLAddressLocationCell.h"
#import "PMLAddressCell.h"
#import "PMLManager.h"
#import "PMLFillInfoViewController.h"
#import "UIViewController+PMLViewController.h"

static NSString *const TableViewCellID = @"TableViewCellID";
static NSString *const PMLAddressCellID = @"PMLAddressCellID";
static NSString *const PMLAddressLocationCellID = @"PMLAddressLocationCellID";

static NSString *const kPMLLocationKey = @"kPMLLocationKey";


@interface PMLAddressController ()<UITableViewDelegate, UITableViewDataSource, PMLAddressLocationCellDelegate>
//@property (nonatomic, strong)PMLAddressModel *addressModel;
@property (nonatomic, strong) PMLBaseTableView *tableView;
@property (nonatomic, strong) NSString *currentCountry;
@end

@implementation PMLAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpTitleViewWithText:kInternationalContent(@"地区") showLine:false];
    [self addNavLeftButton:nil];
    [self.view addSubview:self.tableView];
    [self getLocation];
}

#pragma mark- =====================PMLAddressLocationCellDelegate=====================
- (void)loactionCountry:(NSString *)country {
    NSString *location = [PMLTools readProfileString:kPMLLocationKey];
    if ([PMLTools CheckParam:location]){
        //当前无定位
        [PMLTools writeProfileString:country forKey:kPMLLocationKey];
        self.currentCountry = country;
    }

    if (![location isEqualToString:country]) {
        [PMLTools writeProfileString:country forKey:kPMLLocationKey];
        self.currentCountry = country;
    }
}

- (void)setCurrentCountry:(NSString *)currentCountry {
    _currentCountry = currentCountry;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)getLocation{
    NSString *location = [PMLTools readProfileString:kPMLLocationKey];
    if ([PMLTools CheckParam:location]){
        //当前无定位
    } else {
        //当前定位
        self.currentCountry = location;
    }
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [PMLManager isSelectAddress] ? 3 : 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0){
        return 1;
    }
    if ([PMLManager isSelectAddress] && section == 1){
        return 1;
    }
    return [PMLManager shared].addressModel.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        PMLAddressLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLAddressLocationCellID forIndexPath:indexPath];
        cell.delegate = self;
        
        return cell;
    }
    if ([PMLManager isSelectAddress] && indexPath.section == 1){
        PMLAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLAddressCellID forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.nameLabel.text = [PMLManager shared].selectCountryModel.countryName;
        if ([PMLManager shared].selectCountryModel.provinces.count == 0) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.isSelectAddress = true;
        return cell;
    }

    PMLAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLAddressCellID forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.nameLabel.text = [PMLManager shared].addressModel.data[indexPath.row].countryName;
    if ([PMLManager shared].addressModel.data[indexPath.row].provinces.count == 0) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
        cell.isSelectAddress = false;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 0) {
        return;
    }
    if (indexPath.section == 1 && [PMLManager isSelectAddress]) {
        PMLCountryModel *countryModel = [PMLManager isSelectAddress] ? [PMLManager shared].selectCountryModel : [PMLManager shared].addressModel.data[indexPath.row];
        if (countryModel.provinces.count == 0) {
            [PMLManager shared].selectCountryModel = countryModel;
            [PMLManager shared].selectCityModel = nil;
            [PMLManager shared].selectProvinceModel = nil;
            [self popToViewControllerClass:[PMLFillInfoViewController class] animated:true];
            return;
        }
        PMLProvinceController *privinceVC = [PMLProvinceController new];
        privinceVC.isSeSelect = true;
        [self.navigationController pushViewController:privinceVC animated:true];
        return;
    }

    if ([PMLManager shared].addressModel.data[indexPath.row].provinces.count == 0) {
        [PMLManager shared].selectCountryModel = [PMLManager shared].addressModel.data[indexPath.row];
        [PMLManager shared].selectCityModel = nil;
        [PMLManager shared].selectProvinceModel = nil;
        [self popToViewControllerClass:[PMLFillInfoViewController class] animated:true];
        return;
    }
    PMLProvinceController *privinceVC = [PMLProvinceController new];
    privinceVC.provinceRow = indexPath.row;
    privinceVC.isSeSelect = false;
    [self.navigationController pushViewController:privinceVC animated:true];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerId"];
        if (footerView == nil) {
            footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"footerId"];
            for (UIView *view in footerView.subviews) {
                [view removeFromSuperview];
            }
            PMLAddressSessionView *backView = [[PMLAddressSessionView alloc] initWithFrame:footerView.bounds];
            backView.nameLabel.text = kInternationalContent(@"定位到的位置");
            [footerView addSubview:backView];

        }
        return footerView;
    }
    if (section == 1){
        UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerId"];
        if (footerView == nil) {
            footerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"footerId"];
            for (UIView *view in footerView.subviews) {
                [view removeFromSuperview];
            }
            PMLAddressSessionView *backView = [[PMLAddressSessionView alloc] initWithFrame:footerView.bounds];
            backView.nameLabel.text = kInternationalContent(@"全部");
            [footerView addSubview:backView];
        }
        return footerView;
    }
    return [UIView new];
};

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1){
        return 35;
    }
    return 0.001;
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
        _tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - kNavBarHeight - iPhone_X_Bottom_Safe) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = kRGBColor(236, 236, 236);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TableViewCellID];
        [_tableView registerClass:[PMLAddressCell class] forCellReuseIdentifier:PMLAddressCellID];
        [_tableView registerClass:[PMLAddressLocationCell class] forCellReuseIdentifier:PMLAddressLocationCellID];
    }
    return _tableView;
}

@end
