//
//  PMLSelectItemViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/20.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLSelectItemViewController.h"
#import "PMLDrawerView.h"
#import "PMLSelectedItemView.h"

@interface PMLSelectItemViewController ()<PMLDrawerViewDelegate,PMLSelectedItemViewDelegate>
@property (nonatomic, strong) PMLSelectedItemView *itemsView;
@property (nonatomic, strong) PMLDrawerView *drawerView;
@end

@implementation PMLSelectItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavLeftButton:nil];
    [self setUpTitleViewWithText:kInternationalContent(@"选择项目") showLine:NO];
    [self setupSubViews];
    // Do any additional setup after loading the view.
}

- (void)setupSubViews {
    _itemsView = [[PMLSelectedItemView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    _itemsView.showTitle = YES;
    _itemsView.delegate = self;
    _itemsView.alone = YES;
    [self.view addSubview:_itemsView];
    _drawerView = [[PMLDrawerView alloc] initWithFrame:CGRectMake(0, _itemsView.bottom, kScreenWidth, self.view.height - _itemsView.bottom - kNavBarHeight) controller:self];
    _drawerView.delegate = self;
    [self.view addSubview:_drawerView];
}

- (void)refreshLayout:(CGFloat)itemViewHeight {
    [UIView animateWithDuration:KAnimationDuration animations:^{
        self.itemsView.height = itemViewHeight;
        self.drawerView.y = self.itemsView.bottom;
        self.drawerView.height = self.view.height - self.itemsView.bottom;
        [self.drawerView layout];
    }];
}

#pragma mark-PMLDrawerViewDelegate
- (void)pmlDrawerView:(PMLDrawerView *)drawerView didFinishSelectedItem:(NSString *)itemContent {
    WeakSelf(weakSelf);
    [self.itemsView refreshItemViewWithContent:@[itemContent] complete:^(CGFloat itemViewHeight) {
        [weakSelf refreshLayout:itemViewHeight];
    }];
}

#pragma mark-PMLSelectedItemViewDelegate
- (void)deleteItemComplete:(CGFloat)itemViewHeight {
    [self refreshLayout:itemViewHeight];
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
