//
//  PMLClearCacheViewController.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/10.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLClearCacheViewController.h"
#import <UICountingLabel/UICountingLabel.h>

#define PMLCachPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) objectAtIndex:0]

@interface PMLClearCacheViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (weak, nonatomic) IBOutlet UICountingLabel *cacheLabel;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;

@end

@implementation PMLClearCacheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = kRGBGrayColor(236);
    [self addNavLeftButton:nil];
    [self setUpTitleViewWithText:kInternationalContent(@"清除缓存") showLine:NO];

    self.textLabel.text = kInternationalContent(@"缓存总量");
    [self.clearBtn setTitle:kInternationalContent(@"一键清除") forState:UIControlStateNormal];
    self.cacheLabel.text = [NSString stringWithFormat:@"%.2fM",[PMLTools folderSizeAtPath:PMLCachPath]];
    self.cacheLabel.method = UILabelCountingMethodEaseOut;
    self.cacheLabel.formatBlock = ^NSString *(CGFloat value) {
        return [NSString stringWithFormat:@"0.00M"];
    };
    [self.clearBtn addTarget:self action:@selector(clearAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clearAction:(UIButton *)sender {
    [PMLTools clearCache:PMLCachPath];
    self.cacheLabel.format = @"0.00";
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
