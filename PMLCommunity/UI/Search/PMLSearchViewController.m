//
//  PMLSearchViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/23.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLSearchViewController.h"
#import "PMLSearchView.h"
#import "PMLShareUtilty.h"
//test
#import "PMLShareView.h"
@interface PMLSearchViewController ()
@property (nonatomic, strong) PMLSearchView *searchView;
@property (nonatomic, strong) PMLShareView *shareView;
@end

@implementation PMLSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightItem = [self createBarBtnWithContent:@"关闭" target:self sel:@selector(closeController) postion:@"right"];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.navigationItem.hidesBackButton = YES;
    [self setUpSearchView];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.searchView.searchField resignFirstResponder];
}

- (void)setUpSearchView
{
    _searchView = [[PMLSearchView alloc] init];
    _searchView.frame = CGRectMake(15, 0, kScreenWidth * 315/375, 30);
    self.navigationItem.titleView = _searchView;
    _searchView.layer.cornerRadius = 3;
    [[PMLShareUtilty defaultUtility] shareWithUrl:nil title:nil desc:nil icon:nil respVC:nil];
}

#pragma mark-sender touch
- (void)closeController
{
//    NSArray *viewcontrollers = self.navigationController.viewControllers;
//    NSLog(@"%@",viewcontrollers);
    if (self.searchView.isFirstResponder) {
        [self.searchView.searchField resignFirstResponder];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }else{
        [self.navigationController popViewControllerAnimated:YES];
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
