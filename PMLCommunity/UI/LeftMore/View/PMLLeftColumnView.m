//
//  PMLLeftColumnView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/20.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLLeftColumnView.h"
#import "PMLMaskView.h"
#import "PMLFreeButton.h"
#import "PMLLeftColumnTableViewCell.h"
#import "PMLMyAttentionViewController.h"
#import "PMLMyCommentsViewController.h"
#import "PMLIPraisedViewController.h"
#import "PMLMyDraftViewController.h"
#import "PMLRecentBrowseViewController.h"
#import "PMLSettingViewController.h"
#import "PMLTabkePartTpoicViewController.h"

static NSString *const PMLLeftColumnCellId = @"PMLLeftColumnCellId";
static NSString *const PMLLEftColumnSectionFooterId = @"PMLLEftColumnSectionFooterId";

@interface PMLLeftColumnView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) PMLMaskView *maskView;
@property (nonatomic, strong) PMLBaseLabel *headerLabel;
@property (nonatomic, strong) PMLBaseTableView *tableView;
@property (nonatomic, strong) PMLFreeButton *setBtn;
@property (nonatomic, copy) NSArray *textArray;
@property (nonatomic, copy) NSArray *imageArray;
@end

@implementation PMLLeftColumnView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews {
    
    _textArray = @[@[kInternationalContent(@"地区")],@[kInternationalContent(@"我的关注"),kInternationalContent(@"我赞过的"),kInternationalContent(@"我的草稿")],@[kInternationalContent(@"最近浏览"),kInternationalContent(@"参与话题"),kInternationalContent(@"我的评论")]];
    _imageArray = @[@[@"more_icon_region"],@[@"more_icon_like",@"more_icon_collection",@"more_icon_draft"],@[@"more_icon_see",@"more_icon_topic",@"more_icon_comment"]];
    _maskView = [[PMLMaskView alloc] initMaskViewWithFrame:self.bounds target:self select:@selector(maskViewTouch)];
    _maskView.alpha = 0;
    [self addSubview:_maskView];
    
    _leftView = [[UIView alloc] initWithFrame:CGRectMake(-(self.bounds.size.width * 450/750), 0, self.bounds.size.width * 450/750, self.bounds.size.height)];
    _leftView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_leftView];
    
    _headerLabel = [[PMLBaseLabel alloc] init];
    _headerLabel.font = [UIFont customPingFSemiboldFontWithSize:24];
    _headerLabel.text = kInternationalContent(@"更多");
    _headerLabel.textColor = [UIColor colorWithHex:@"#262626"];
    [_leftView addSubview:_headerLabel];
    [_headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftView).offset(25);
        make.top.equalTo(self.leftView).offset(kScreenHeight * 145/1334);
    }];
    
    UIView *redLineView = [[UIView alloc] init];
    redLineView.backgroundColor = kRedColor;
    redLineView.layer.cornerRadius = 3.0/2;
    [_leftView addSubview:redLineView];
    [redLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerLabel);
        make.top.equalTo(self.headerLabel.mas_bottom).offset(10);
        make.width.mas_equalTo([PMLTools sizeForString:self.headerLabel.text font:[UIFont customPingFSemiboldFontWithSize:24] maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width);
        make.height.mas_equalTo(3);
    }];
    
    _setBtn = [PMLFreeButton buttonWithType:UIButtonTypeCustom];
    [_setBtn setTitle:kInternationalContent(@"设置") forState:UIControlStateNormal];
    [_setBtn setTitleColor:[UIColor colorWithHex:@"#262626"] forState:UIControlStateNormal];
    [_setBtn setImage:kImageWithName(@"more_icon_setup") forState:UIControlStateNormal];
    _setBtn.titleLabel.font = [UIFont customPingFMediumFontWithSize:18];
    [_setBtn setUpImageViewSize:CGSizeMake(25, 25) margin:6 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    [_setBtn addTarget:self action:@selector(goSetting) forControlEvents:UIControlEventTouchUpInside];
    [_setBtn sizeToFit];
    [_leftView addSubview:_setBtn];
    [_setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.leftView).offset(-25);
        make.bottom.equalTo(self.leftView).offset(-45);
        make.width.mas_equalTo(25 + 6 + [PMLTools sizeForString:self.setBtn.titleLabel.text font:self.setBtn.titleLabel.font maxSize:CGSizeMake(100, 100)].width);
    }];
    
    _tableView = [[PMLBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 45;
    _tableView.sectionFooterHeight = 20;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLLeftColumnTableViewCell class]) bundle:nil] forCellReuseIdentifier:PMLLeftColumnCellId];
    [_tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:PMLLEftColumnSectionFooterId];
    [_leftView addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.leftView);
        make.top.equalTo(redLineView.mas_bottom).offset(35);
        make.bottom.equalTo(self.setBtn.mas_top).offset(-kScreenHeight * 132/1334);
    }];
}

#pragma mark-UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.textArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *data = self.textArray[section];
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMLLeftColumnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PMLLeftColumnCellId forIndexPath:indexPath];
    cell.labelString = self.textArray[indexPath.section][indexPath.row];
    cell.imageName = self.imageArray[indexPath.section][indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:PMLLEftColumnSectionFooterId];
    footerView.frame = CGRectMake(0, 0, self.tableView.width, 20);
    footerView.contentView.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] initWithFrame:footerView.bounds];
    lineView.backgroundColor = kRGBColor(240, 240, 240);
    [footerView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footerView).offset(38);
        make.right.equalTo(footerView).offset(-38);
        make.centerY.equalTo(footerView);
        make.height.mas_equalTo(1);
    }];
    return footerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PMLBaseViewController *currentVC = (PMLBaseViewController *)[PMLTools getCurrentViewController];
    switch (indexPath.section) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [currentVC pushViewControllerWithClassName:NSStringFromClass([PMLMyAttentionViewController class]) params:nil];
                }
                    break;
                case 1:
                {
                    [currentVC pushViewControllerWithClassName:NSStringFromClass([PMLIPraisedViewController class]) params:nil];
                }
                    break;
                case 2:
                {
                    [currentVC pushViewControllerWithClassName:NSStringFromClass([PMLMyDraftViewController class]) params:nil];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 2:
        {
            switch (indexPath.row) {
                case 0:
                {
                    [currentVC pushViewControllerWithClassName:NSStringFromClass([PMLRecentBrowseViewController class]) params:nil];
                }
                    break;
                case 1:
                {
                    [currentVC pushViewControllerWithClassName:NSStringFromClass([PMLTabkePartTpoicViewController class]) params:nil];
                }
                    break;
                case 2:
                {
                    [currentVC pushViewControllerWithClassName:NSStringFromClass([PMLMyCommentsViewController class]) params:nil];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    
    [self maskViewTouch];
}

#pragma mark-sender touch
- (void)goSetting {
    PMLBaseViewController *currentVC = (PMLBaseViewController *)[PMLTools getCurrentViewController];
    [currentVC pushViewControllerWithClassName:NSStringFromClass([PMLSettingViewController class]) params:nil];
    [self maskViewTouch];
}

- (void)maskViewTouch {
    [UIView animateWithDuration:KAnimationDuration animations:^{
        self.leftView.x = -(self.bounds.size.width * 2/3);
        self.maskView.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.touchBlock) {
            self.touchBlock();
        }
    }];
    
}
- (void)show {
    [UIView animateWithDuration:KAnimationDuration animations:^{
        self.leftView.x = 0;
        self.maskView.alpha = kMaskAlpha;
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
