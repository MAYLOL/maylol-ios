//
//  PMLPersonalInfoViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/18.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLPersonalInfoViewController.h"
#import "PMLPersonalInfoTableViewCell.h"
#import "CameraHelper.h"
#import "PMLAlertController.h"
#import "MOFSPickerManager.h"

static NSString *const PMLPersonalInfoCellId = @"PMLPersonalInfoCellId";

@interface PMLPersonalInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) PMLBaseTableView *tableView;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, copy) NSArray *typeTextArray;
@property (nonatomic, strong) NSMutableArray <NSString *>*dataArray;
@end

@implementation PMLPersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTitleViewWithText:kInternationalContent(@"个人信息") showLine:NO];
    [self addNavLeftButton:@"login_left_arrow"];
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:kInternationalContent(@"保存") attributes:@{NSFontAttributeName:[UIFont customPingFRegularFontWithSize:15], NSForegroundColorAttributeName:kRGBColor(240, 46, 68)}];
    UIBarButtonItem *rightItem = [self createBarBtnWithContent:attr target:self sel:@selector(saveInfo)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self setupSubViews];
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    self.dataArray = [NSMutableArray arrayWithArray:@[@"",@"",@""]];
    self.typeTextArray = @[kInternationalContent(@"昵称"),kInternationalContent(@"性别"),kInternationalContent(@"年龄/星座"),kInternationalContent(@"所在地"),kInternationalContent(@"职业"),kInternationalContent(@"简介")];
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = [self headerView];
}

- (void)saveInfo {
    
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.typeTextArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMLPersonalInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLPersonalInfoCellId forIndexPath:indexPath];
    cell.typeString = self.typeTextArray[indexPath.row];
    cell.cellIndex = indexPath.row;
    if (indexPath.row > 3) {
        cell.fieldEnableEdit = YES;
    }else {
        cell.fieldEnableEdit = NO;
    }
    if (indexPath.row > 0 && indexPath.row < 4) {
        cell.dataString = self.dataArray[indexPath.row - 1];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 1:
        {
            UIAlertController *alert = [PMLAlertController showSheetAlertControllerWithTitle:nil message:nil firstTitle:kInternationalContent(@"男") firstHandler:^(UIAlertAction *action) {
                [self.dataArray replaceObjectAtIndex:0 withObject:kInternationalContent(@"男")];
                [self.tableView reloadData];
            } secondTitle:kInternationalContent(@"女") secondHandler:^(UIAlertAction *action) {
                [self.dataArray replaceObjectAtIndex:0 withObject:kInternationalContent(@"女")];
                [self.tableView reloadData];
            } cancelHandler:nil];
            [self presentViewController:alert animated:YES completion:nil];
        }
            break;
        case 2:
        {
            [[MOFSPickerManager shareManger] showDatePickerWithTitle:nil cancelTitle:kInternationalContent(@"取消") commitTitle:kInternationalContent(@"确定") firstDate:[NSDate date] minDate:[NSDate distantPast] maxDate:[NSDate date] datePickerMode:UIDatePickerModeDate tag:1 commitBlock:^(NSDate * _Nonnull date) {
                NSString *age = [PMLTools getAgeWith:date];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyy-MM-dd";
                NSString *dateString = [formatter stringFromDate:date];
//                [self.dataArray replaceObjectAtIndex:1 withObject:dateString];
                NSString *star = [PMLTools getAstroWithMonth:[[dateString substringWithRange:NSMakeRange(5, 2)] intValue] day:[[dateString substringWithRange:NSMakeRange(8, 2)] intValue]];
                [self.dataArray replaceObjectAtIndex:1 withObject:[NSString stringWithFormat:@"%@/%@",age,star]];
                [self.tableView reloadData];
            } cancelBlock:nil];
        }
            break;
        case 3:
        {
            
        }
            break;
        default:
            break;
    }
}

- (PMLBaseView *)headerView {
    PMLBaseView *headerView = [[PMLBaseView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth * 150/375)];
    headerView.backgroundColor = kRGBGrayColor(245);
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [iconImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectIconImage)]];
    iconImageView.clipsToBounds = YES;
    iconImageView.layer.cornerRadius = 5;
    iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    iconImageView.userInteractionEnabled = YES;
    [headerView addSubview:iconImageView];
    _iconImageView = iconImageView;
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(headerView);
        make.width.height.mas_equalTo(100);
    }];
    
    UIImageView *tipImageView = [[UIImageView alloc] init];
    tipImageView.image = kImageWithName(@"me_edit_btn_photo");
    [headerView addSubview:tipImageView];
    [tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(iconImageView).offset(8);
        make.bottom.equalTo(iconImageView).offset(2);
        make.width.height.mas_equalTo(35);
    }];
    return headerView;
}

- (PMLBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLPersonalInfoTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLPersonalInfoCellId];
    }
    return _tableView;
}

- (void)selectIconImage {
    UIAlertController *alert = [PMLAlertController showSheetAlertControllerWithTitle:kInternationalContent(@"修改头像") message:nil firstTitle:kInternationalContent(@"相册") firstHandler:^(UIAlertAction *action) {
        [[CameraHelper helper] showPickerViewControllerSourceType:UIImagePickerControllerSourceTypePhotoLibrary onViewController:self completion:^(NSError *error, NSData *data) {
            if (!error) {
                self.iconImageView.image = [UIImage imageWithData:data];
            }
        }];
    } secondTitle:kInternationalContent(@"拍摄") secondHandler:^(UIAlertAction *action) {
        [[CameraHelper helper] showPickerViewControllerSourceType:UIImagePickerControllerSourceTypeCamera onViewController:self completion:^(NSError *error, NSData *data) {
            if (!error) {
                self.iconImageView.image = [UIImage imageWithData:data];
            }
        }];
    } cancelHandler:nil];
    
    [self presentViewController:alert animated:YES completion:nil];}


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
