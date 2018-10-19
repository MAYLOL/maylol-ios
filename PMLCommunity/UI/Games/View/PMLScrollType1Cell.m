//
//  PMLScrollType1Cell.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/11.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLScrollType1Cell.h"
#import "PMLScrollType1CellItem.h"

static NSString *const CollectionViewCellID = @"CollectionViewCellID";//默认
static NSString *const PMLScrollType1CellItemID = @"PMLScrollType1CellItemID";//默认


@interface PMLScrollType1Cell()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)UIButton *iconView;
@property (nonatomic, strong) UIView *underLine;

@end

@implementation PMLScrollType1Cell

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectionView];
    [self addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.right.equalTo(self.mas_right).offset(-16);
        make.height.mas_equalTo(self.height);
        make.width.mas_equalTo(22);
    }];
    UIView *underLine = [UIView new];
    underLine.backgroundColor = [UIColor colorWithHex:@"#E6E6E6"];
    [self addSubview:underLine];
    [underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.mas_equalTo(1);
    }];
    _underLine = underLine;
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PMLScrollType1CellItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PMLScrollType1CellItemID forIndexPath:indexPath];
    if (indexPath.row <= 2) {
        cell.isHide = false;
        cell.numberStr = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    } else {
        cell.isHide = true;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(43, 43);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(13, 16, 15, 28);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
}

- (void)rightAction:(UIButton *)sender {
    CGFloat offsetTotal = self.collectionView.contentSize.width - self.width;//可偏移总量
    CGFloat currentOffset = self.collectionView.contentOffset.x;//当前偏移量
    CGFloat offset = currentOffset + kScreenWidth;//即将偏移量

    if (currentOffset >= offsetTotal){
        return;
    }
    if (offset >= offsetTotal){
        offset = offsetTotal;
    }

    [self.collectionView setContentOffset:CGPointMake(offset, 0) animated:true];

}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width - 35, self.height - 1) collectionViewLayout:[UICollectionViewLayout new]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CollectionViewCellID];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLScrollType1CellItem class]) bundle:nil] forCellWithReuseIdentifier:PMLScrollType1CellItemID];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 25;
        layout.minimumLineSpacing = 25;
        _collectionView.collectionViewLayout = layout;
        return  _collectionView;
    }
    return _collectionView;
}

- (UIButton *)iconView {
    if (!_iconView){
        _iconView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_iconView setImage:[UIImage imageNamed:@"release_icon_arrow"] forState:UIControlStateNormal];
        _iconView.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0 );
        [_iconView addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _iconView;
}

@end
