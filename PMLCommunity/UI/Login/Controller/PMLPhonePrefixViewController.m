//
//  PMLPhonePrefixViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/8.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLPhonePrefixViewController.h"
#import "PMLPhonePrefixResultViewController.h"
#import "PMLPhonePrefixCell.h"

#define kCountryZoneCellIdentifier @"CountryZoneCellIdentifier"

@interface PMLPhonePrefixViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *zonesList;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, copy) ResultHanler result;
@property (nonatomic, strong) NSDictionary *localList;
@property (nonatomic, strong) NSDictionary *dataSources;
@property (nonatomic, strong) NSArray *indexArr;

//搜索控制器
@property (nonatomic, strong) UISearchController *searchController;
@end

@implementation PMLPhonePrefixViewController

- (instancetype)initWithResult:(ResultHanler)result
{
    if (self = [super init])
    {
        _result = result;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:@"login_left_arrow"];
    _localList = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"country" ofType:@"plist"]];
    _dataSources = _localList;
    _indexArr = [_dataSources.allKeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    [self configUI];
    // Do any additional setup after loading the view.
}

- (void)configUI
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = kInternationalContent(@"选择国家或地区");
    
    __weak typeof(self) weakSelf = self;

    self.searchController =
    ({
        PMLPhonePrefixResultViewController *resultVC = [PMLPhonePrefixResultViewController new];

        [resultVC setItemSeletectedBlock:^(NSString *countryName, NSString *zone) {


            if (weakSelf.result)
            {
                weakSelf.result(NO,zone,countryName);
            }
            weakSelf.searchController = nil;
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];

        UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:resultVC];
        searchController.searchResultsUpdater = resultVC;
        [searchController.searchBar sizeToFit];

        searchController.hidesNavigationBarDuringPresentation = YES;
        searchController.dimsBackgroundDuringPresentation = YES;
        self.definesPresentationContext = YES;

        resultVC.searchBar = searchController.searchBar;

        searchController;
    });

    self.zonesList =
    ({
        UITableView *zonesList = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.bounds.size.height - kNavBarHeight) style:UITableViewStylePlain];
        
        [self.view addSubview:zonesList];
        zonesList.dataSource = self;
        zonesList.delegate = self;
        zonesList.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        zonesList.sectionIndexColor = kRGBGrayColor(0);
        zonesList.sectionIndexBackgroundColor = [UIColor clearColor];
        zonesList.tableHeaderView = self.searchController.searchBar;
        zonesList.sectionIndexBackgroundColor = [UIColor clearColor];
        
        zonesList ;
    });
    
    PMLPhonePrefixResultViewController *resultVC = (PMLPhonePrefixResultViewController *)self.searchController.searchResultsController;
    
    [resultVC setLocalList:_localList];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.indexArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 31.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *title = _indexArr[section];
    
    return [self.dataSources[title] count];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSString *title = _indexArr[section];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 31)];
    bgView.backgroundColor = [UIColor colorWithHex:@"#EFEFF3"];
    
    UILabel *sectionNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width - 30, 31)];
    sectionNameLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    sectionNameLabel.backgroundColor=[UIColor clearColor];
    sectionNameLabel.text = title;
    [bgView addSubview:sectionNameLabel];
    
    return bgView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *index = _indexArr[indexPath.section];
    
    NSString *zoneInfo = self.dataSources[index][indexPath.row];
    
    NSInteger location = [zoneInfo rangeOfString:@"+"].location;
    
    NSString *countryName = [zoneInfo substringToIndex:location];
    NSString *zone = [zoneInfo substringFromIndex:location];
    
    PMLPhonePrefixCell *cell = [tableView dequeueReusableCellWithIdentifier:kCountryZoneCellIdentifier];
    
    if (!cell)
    {
        cell = [[PMLPhonePrefixCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCountryZoneCellIdentifier];
    }
    
    cell.nameLabel.text = countryName;
    cell.zoneCodeLabel.text = zone;
    
    return cell;
}


- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    NSMutableArray *array = _indexArr.mutableCopy;
    
//    [array insertObject:UITableViewIndexSearch atIndex:0];
    
    return array;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PMLPhonePrefixCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    WeakSelf(weakSelf);
    if (self.result)
    {
        weakSelf.result(NO,cell.zoneCodeLabel.text,cell.nameLabel.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_searchBar.isFirstResponder)
    {
        [_searchBar resignFirstResponder];
    }
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
