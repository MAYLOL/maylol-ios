//
//  PMLHomeCommunityViewController.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/15.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLHomeCommunityViewController.h"
#import "CWCarousel.h"
#import "PMLAutoScrollView.h"
#import "PMLVerticalFlowLayout.h"
#import "PMLCommunityCollectionViewCell.h"
#import "PMLHomeWaterFlowModel.h"

static NSString *const BannerViewCellId = @"BannerViewCellId";
static NSString *const VerticalFlowViewCellId = @"VerticalFlowViewCellId";
static NSString *const VerticalFlowViewHeaderId = @"VerticalFlowViewHeaderId";
@interface PMLHomeCommunityViewController ()<PMLAutoScrollViewDelegate,CWCarouselDelegate,CWCarouselDatasource,PMLVerticalFlowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource,PMLCommunityCollectionViewCellDelegate>
@property (nonatomic, strong) PMLBaseView *topScrollView;
@property (nonatomic, strong) PMLAutoScrollView *topItemScrollView;
@property (nonatomic, strong) CWCarousel *bannerView;
@property (nonatomic, strong) PMLBaseCollectionView *verticalFlowView;
@property (nonatomic, strong) NSMutableArray <PMLHomeWaterFlowModel *>*dataArray;
@property (nonatomic, strong) NSMutableArray *bannerArray;


@end

@implementation PMLHomeCommunityViewController

//社区
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTopItemScrollView];
    
//    NSMutableDictionary *prams = [NSMutableDictionary dictionary];
//    prams[@"tel"] = @"15510453026";
//    prams[@"passcode"] = [PMLTools RSAEncryption:@"panchuang123456"];
//    prams[@"passcode2"] = [PMLTools RSAEncryption:@"panchuang123456"];
//    [PMLViewModel modifyPwdByPhoneWithParams:prams requestType:PMLRequestPut success:^(NSURLSessionDataTask *task, id responeObject) {
//        NSLog(@"%@",responeObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        [self showHUDPureTitle:kInternationalContent(@"账号注册失败")];
//    }];
//    prams[@""]
    
    
//    prams[@"tel"] = @"15510453026";
//    prams[@"passcode"] = [PMLTools RSAEncryption:@"panchuang123"];
//    prams[@"passcode2"] = [PMLTools RSAEncryption:@"panchuang123"];
//    [PMLViewModel phoneRegisterWithParams:prams requestType:PMLRequestPut success:^(NSURLSessionDataTask *task, id responeObject) {
//        NSLog(@"%@",responeObject);
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        [self showHUDPureTitle:kInternationalContent(@"账号注册失败")];
//    }];
    
    [self.view addSubview:self.verticalFlowView];
    [self.verticalFlowView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}

- (void)setUpTopItemScrollView
{
    UIView *topScrollView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    [self.view addSubview:topScrollView];
    
    UIView *lineView =[[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHex:@"#F0F0F0" alpha:0.96];
    [topScrollView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(topScrollView);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *addItemBtn = [self createButtonWithTitle:nil normalImg:@"home_nav_icon_add" selectedImg:@"home_nav_icon_add" target:self sel:@selector(addItemClicked)];
    [topScrollView addSubview:addItemBtn];
    [addItemBtn sizeToFit];
    addItemBtn.centerY = topScrollView.centerY;
    addItemBtn.right = kScreenWidth - 15;
    
    CGSize itemSize = [PMLTools sizeForString:kInternationalContent(@"推荐") font:kDefauleFont(13) maxSize:CGSizeMake(100, 100)];
    self.topItemScrollView = [[PMLAutoScrollView alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth - (addItemBtn.width + 15 + 34), itemSize.height) delegate:self dataSource:@[kInternationalContent(@"推荐"),kInternationalContent(@"热门"),kInternationalContent(@"微整"),kInternationalContent(@"医院"),kInternationalContent(@"美食"),kInternationalContent(@"健身"),kInternationalContent(@"医院"),kInternationalContent(@"旅游"),kInternationalContent(@"逛街"),kInternationalContent(@"吃饭"),kInternationalContent(@"健身"),kInternationalContent(@"医院"),kInternationalContent(@"旅游"),kInternationalContent(@"逛街"),kInternationalContent(@"吃饭")] defaultSelectIndex:0];
//    self.topItemScrollView.labelFont = 13;
    self.topItemScrollView.normalColor = kRGBColor(153, 153, 153);
    self.topItemScrollView.selectColor = kRGBColor(0, 0, 0);
    self.topItemScrollView.normalFont = [UIFont customPingFRegularFontWithSize:13];
    self.topItemScrollView.selectFont = [UIFont customPingFSemiboldFontWithSize:13];
    self.topItemScrollView.itemMargin = kScreenWidth * 40/750;
    self.topItemScrollView.edgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
    [topScrollView addSubview:self.topItemScrollView];
    self.topItemScrollView.centerY = topScrollView.centerY;
    
}

#pragma mark-NetRequest
- (void)loadWaterFlowData {
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"pageIndex"] = [NSString stringWithFormat:@"%ld",self.pageIndex];
    parms[@"pageSize"] = [NSString stringWithFormat:@"%ld",PMLPageSize];
    [PMLViewModel homeWaterFlowWithParams:parms requestType:PMLRequestPost success:^(NSURLSessionDataTask *task, id responeObject) {
        NSLog(@"%@",responeObject);
        NSArray *array = [responeObject objectForCheckedKey:@"articles"];
        if (array.count > 0) {
            for (NSDictionary *dic in array) {
                PMLHomeWaterFlowModel *model = [PMLHomeWaterFlowModel mj_objectWithKeyValues:dic];
                [self.dataArray addObject:model];
            }
            [self.verticalFlowView.mj_footer endRefreshing];
        }
        if ([(NSArray *)responeObject count] > 0) {
            
        }else {
            [self.verticalFlowView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.verticalFlowView.mj_header endRefreshing];
        [self.verticalFlowView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
        [self.verticalFlowView.mj_header endRefreshing];
        [self.verticalFlowView.mj_footer endRefreshing];
    }];
}

- (void)articleOperation:(NSString *)articleId likeOperation:(BOOL)like{
    NSMutableDictionary *parms = [NSMutableDictionary dictionary];
    parms[@"uid"] = @"";
    parms[@"aid"] = articleId;
    if (like) {
//        [PMLViewModel ar];
    }else {
        
    }
}

#pragma mark-PMLAutoScrollViewDelegate
- (void)autoScrollView:(PMLAutoScrollView *)autoScrollView didSelectAtIndex:(NSInteger)index
{
    
}

#pragma mark-CWCarouselDelegate,CWCarouselDatasource
- (UICollectionViewCell *)viewForCarousel:(CWCarousel *)carousel indexPath:(NSIndexPath *)indexPath index:(NSInteger)index
{
    PMLCommunityCollectionViewCell *cell = [carousel.carouselView dequeueReusableCellWithReuseIdentifier:BannerViewCellId forIndexPath:indexPath];
//    UIImageView *imgView = [cell.contentView viewWithTag:100];
//    if(!imgView) {
//        imgView = [[UIImageView alloc] initWithFrame:cell.contentView.bounds];
//        imgView.tag = 100;
//        imgView.backgroundColor = kRandomColor;
//        [cell.contentView addSubview:imgView];
//        cell.layer.masksToBounds = YES;
//        cell.layer.cornerRadius = 5;
//    }
//    [imgView sd_setImageWithURL:[NSURL URLWithString:self.bannerArray[index]]];
    return cell;
}

- (NSInteger)numbersForCarousel
{
    return self.bannerArray.count;
}

- (void)CWCarousel:(CWCarousel *)carousel didSelectedAtIndex:(NSInteger)index
{
    NSLog(@"...%ld...", index);
}

#pragma mark-UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PMLCommunityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:VerticalFlowViewCellId forIndexPath:indexPath];
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:VerticalFlowViewHeaderId forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor whiteColor];
    if (!self.bannerView) {
        CWFlowLayout *flowLayout = [[CWFlowLayout alloc] initWithStyle:CWCarouselStyle_H_1];
        CWCarousel *bannerView = [[CWCarousel alloc] initWithFrame:CGRectMake(0, 10, headerView.width, headerView.height - 10) delegate:self datasource:self flowLayout:flowLayout];
        bannerView.isAuto = YES;
        [bannerView registerViewClass:[UICollectionViewCell class] identifier:BannerViewCellId];
        bannerView.pageControl.hidden = YES;
        [headerView addSubview:bannerView];
        self.bannerView = bannerView;
    }
    return headerView;
}

#pragma mark-PMLVerticalFlowLayoutDelegate
- (CGFloat)PML_verticalFlowLayout:(PMLVerticalFlowLayout *)layout collectionView:(UICollectionView *)collectionVew heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PMLHomeWaterFlowModel *model = self.dataArray[indexPath.row];
    return model.cellHeight;
}

- (UIEdgeInsets)PML_verticalFlowLayout:(PMLVerticalFlowLayout *)layout edgeInsetsForcollectionView:(UICollectionView *)collectionVew
{
    return UIEdgeInsetsMake(10, 15, 0, 15);
}

#pragma mark-PMLCommunityCollectionViewCellDelegate
- (void)cellItemClicked:(NSIndexPath *)indexPath touchType:(TouchItemType)type {
    PMLHomeWaterFlowModel *model = self.dataArray[indexPath.row];
    if (model.whetherLike) {
        NSLog(@"取消点赞");
    }else {
        NSLog(@"点赞");
    }
    
}

#pragma mark-sender touch
- (void)addItemClicked
{
    
}

#pragma mark-lazy load
- (PMLBaseCollectionView *)verticalFlowView
{
    if (!_verticalFlowView) {
        _verticalFlowView = [[PMLBaseCollectionView alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, self.view.height - 30 - kTabBar - kNavBarHeight) collectionViewLayout:[UICollectionViewLayout new]];
        _verticalFlowView.backgroundColor = [UIColor whiteColor];
        _verticalFlowView.delegate = self;
        _verticalFlowView.dataSource = self;
        _verticalFlowView.showsVerticalScrollIndicator = NO;
        [_verticalFlowView registerNib:[UINib nibWithNibName:NSStringFromClass([PMLCommunityCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:VerticalFlowViewCellId];
        [_verticalFlowView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:VerticalFlowViewHeaderId];
        PMLVerticalFlowLayout *layout = [[PMLVerticalFlowLayout alloc] initWithDelegate:self headerSize:CGSizeMake(kScreenWidth, kScreenWidth * 340/750)];
        _verticalFlowView.collectionViewLayout = layout;
        _verticalFlowView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.pageIndex = 1;
            [self loadWaterFlowData];
        }];
        _verticalFlowView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self.pageIndex ++;
            [self loadWaterFlowData];
        }];
    }
    return _verticalFlowView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)bannerArray {
    if (!_bannerArray) {
        _bannerArray = [NSMutableArray array];
    }
    return _bannerArray;
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
