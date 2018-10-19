//
//  PMLFillInfoViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/26.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLFillInfoViewController.h"
#import "PMLFillInfoHeaderView.h"
#import "PMLFillInfoTableViewCell.h"
#import "MOFSPickerManager.h"
#import "PMLAddressController.h"
#import "PMLManager.h"

static NSString *const PMLFillInfoCellId = @"PMLFillInfoCellId";

@interface PMLFillInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet PMLBaseTableView *tableView;
@property (nonatomic, strong) PMLFillInfoHeaderView *headerView;
@property (nonatomic, copy) NSArray *dataSource;
@property (nonatomic, strong) NSMutableArray <NSString *>*textArray;
@property (nonatomic, assign) CGFloat sectionFooterHeight;
@property (nonatomic, strong) PMLCommitButton *footerBtn;

@end

@implementation PMLFillInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];
    [self setupSubViews];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)setupSubViews {
    self.dataSource = @[kInternationalContent(@"选择性别"),kInternationalContent(@"选择生日"),kInternationalContent(@"选择地区"),kInternationalContent(@"填写职业")];
    self.textArray = [NSMutableArray arrayWithArray:@[@"",@"",@""]];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLFillInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLFillInfoCellId];
    
    self.headerView = [PMLFillInfoHeaderView loadViewFromNib];
    self.headerView.frame = CGRectMake(0, 0, kScreenWidth, 200);
    self.headerView.controller = self;
    WeakSelf(weakSelf);
    self.headerView.headerBlock = ^{
        [weakSelf complateEdit];
    };
    self.tableView.tableHeaderView = self.headerView;
    
    self.tableView.tableFooterView = [self createFooterView];
}

- (void)loadData {
        if (![PMLTools CheckParam:[PMLManager GetAddress]]) {
            [self.textArray replaceObjectAtIndex:2 withObject:[PMLManager GetAddress]];
        }
    [self.tableView reloadData];
}

- (PMLBaseView *)createFooterView {
    
    self.sectionFooterHeight = [PMLTools sizeForString:kInternationalContent(@"您可以在个人中心->编辑资料中完善自我介绍") font:[UIFont customPingFRegularFontWithSize:10] maxSize:CGSizeMake(kScreenWidth - 70, CGFLOAT_MAX)].height;
    
    PMLBaseView *footerView = [[PMLBaseView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 10 + self.sectionFooterHeight + 60)];
    PMLBaseLabel *footerLabel = [[PMLBaseLabel alloc] initWithFrame:CGRectMake(35, 10, kScreenWidth - 70, self.sectionFooterHeight)];
    footerLabel.text = kInternationalContent(@"您可以在个人中心->编辑资料中完善自我介绍");
    footerLabel.textColor = kRGBGrayColor(153);
    footerLabel.font = [UIFont customPingFRegularFontWithSize:10];
    [footerView addSubview:footerLabel];
    self.footerBtn = [PMLCommitButton buttonWithType:UIButtonTypeCustom];
    [self.footerBtn setTitle:kInternationalContent(@"完成") forState:UIControlStateNormal];
    self.footerBtn.frame = CGRectMake(35, footerLabel.bottom + 20, kScreenWidth - 70, 40);
    [footerView addSubview:self.footerBtn];
    return footerView;
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMLFillInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLFillInfoCellId forIndexPath:indexPath];
    cell.placeholder = self.dataSource[indexPath.row];
    if (indexPath.row == self.dataSource.count - 1) {
        cell.fileEnable = YES;
    }else {
        cell.fileEnable = NO;
        cell.fieldText = self.textArray[indexPath.row];
    }
    WeakSelf(weakSelf);
    cell.inputBlock = ^{
        [weakSelf complateEdit];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WeakSelf(weakSelf);
    switch (indexPath.row) {
        case 0:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:self.dataSource[indexPath.row] message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *manAction = [UIAlertAction actionWithTitle:kInternationalContent(@"男") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.textArray replaceObjectAtIndex:indexPath.row withObject:kInternationalContent(@"男")];
                [weakSelf.tableView reloadData];
                [weakSelf complateEdit];
            }];
            UIAlertAction *womanAction = [UIAlertAction actionWithTitle:kInternationalContent(@"女") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf.textArray replaceObjectAtIndex:indexPath.row withObject:kInternationalContent(@"女")];
                [weakSelf.tableView reloadData];
                [weakSelf complateEdit];
            }];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:kInternationalContent(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alert addAction:manAction];
            [alert addAction:womanAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
            break;
        case 1:
        {
            [[MOFSPickerManager shareManger] showDatePickerWithTitle:nil cancelTitle:kInternationalContent(@"取消") commitTitle:kInternationalContent(@"确定") firstDate:[NSDate date] minDate:[NSDate distantPast] maxDate:[NSDate date] datePickerMode:UIDatePickerModeDate tag:1 commitBlock:^(NSDate * _Nonnull date) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyy-MM-dd";
                NSString *string = [formatter stringFromDate:date];
                [weakSelf.textArray replaceObjectAtIndex:indexPath.row withObject:string];
                [weakSelf.tableView reloadData];
                [weakSelf complateEdit];
            } cancelBlock:nil];
        }
            break;
        case 2:
        {
            PMLAddressController *addressVC = [PMLAddressController new];
            [self.navigationController pushViewController:addressVC animated:true];
//            [self.textArray replaceObjectAtIndex:indexPath.row withObject:@"你好"];
//            [self.tableView reloadData];
        }
            break;
        default:
            break;
    }
}

- (void)complateEdit {
    __block BOOL complate = YES;
    [self.textArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.length <= 0) {
            complate = NO;
            *stop = YES;
        }
    }];
    if (!self.headerView.iconImage) {
        complate = NO;
    }
    
    PMLFillInfoTableViewCell *cell = (PMLFillInfoTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    if (cell.fieldString.length <= 0) {
        complate = NO;
    }
    if (complate) {
        self.footerBtn.enabled = YES;
    }else {
        self.footerBtn.enabled = NO;
    }
}
@end
