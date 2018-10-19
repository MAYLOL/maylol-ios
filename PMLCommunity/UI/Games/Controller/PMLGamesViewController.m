//
//  PMLGamesViewController.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/11.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLGamesViewController.h"
#import "PMLScrollType1Cell.h"
#import "PMLScrollType2Cell.h"
#import "PMLGamesHeaderView.h"
#import "PMLGamesSessionView.h"
#import "PMLGamesFooterView.h"

static NSString *const CollectionViewCellID = @"CollectionViewCellID";//默认
static NSString *const PMLGamesHeaderViewID = @"PMLGamesHeaderViewID";
static NSString *const ContentHeaderCollectionCellID = @"ContentHeaderCollectionCellID";
static NSString *const PMLScrollType1CellID = @"PMLScrollType1CellID";
static NSString *const PMLScrollType2CellID = @"PMLScrollType2CellID";
static NSString *const PMLGamesSessionViewID = @"PMLGamesSessionViewID";
static NSString *const ContentFooterCollectionCellID = @"ContentFooterCollectionCellID";



@interface PMLGamesViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSArray *sessionData;
@end

@implementation PMLGamesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self addNavLeftButton:@"home_nav_btn_more"];
    [self.view addSubview:self.collectionView];
    self.sessionData = @[@"",kInternationalContent(@"我的游戏"),kInternationalContent(@"单人游戏"),kInternationalContent(@"多人游戏")];
}


#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0){
        return 1;
    }
    if (section == 1){
        return 1;
    }
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0){
        PMLScrollType1Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PMLScrollType1CellID forIndexPath:indexPath];
        return cell;
    }

    if (indexPath.section == 1){
        PMLScrollType2Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PMLScrollType2CellID forIndexPath:indexPath];
        return cell;
    }

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = true;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth, 70);
    }
    if (indexPath.section == 1) {
        return CGSizeMake(kScreenWidth, 140);
    }

    return CGSizeMake((kScreenWidth - 45) / 2, 80);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 15, 0, 15);
    }

    return UIEdgeInsetsMake(0, 15, 10, 15);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 0){
            PMLGamesHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PMLGamesHeaderViewID forIndexPath:indexPath];
            headerView.backgroundColor = [UIColor whiteColor];
            return headerView;
        }

        PMLGamesSessionView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PMLGamesSessionViewID forIndexPath:indexPath];
        headerView.title.text = self.sessionData[indexPath.section];
        return headerView;
    }else {
        PMLGamesFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ContentFooterCollectionCellID forIndexPath:indexPath];
        return footerView;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(kScreenWidth, 90);
    }

    return CGSizeMake(kScreenWidth, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {

    if (section == 0){
        return CGSizeZero;
    }

    return CGSizeMake(kScreenWidth, 1);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.height - kNavBarHeight - 50 - iPhone_X_Bottom_Safe) collectionViewLayout:[UICollectionViewLayout new]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        //        _collectionView.prefetchingEnabled = false;
        [_collectionView registerClass:[PMLGamesHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PMLGamesHeaderViewID];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLGamesSessionView class]) bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:PMLGamesSessionViewID];
        [_collectionView registerClass:[PMLGamesFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:ContentFooterCollectionCellID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ContentHeaderCollectionCellID];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellID];
        [_collectionView registerClass:[PMLScrollType1Cell class] forCellWithReuseIdentifier:PMLScrollType1CellID];
        [_collectionView registerClass:[PMLScrollType2Cell class] forCellWithReuseIdentifier:PMLScrollType2CellID];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;
        _collectionView.collectionViewLayout = layout;
        return  _collectionView;
    }
    return _collectionView;
}
@end
