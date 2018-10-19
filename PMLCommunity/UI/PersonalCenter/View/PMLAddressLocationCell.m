//
//  PMLAddressLocationCell.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/26.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLAddressLocationCell.h"
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

@interface PMLAddressLocationCell()<CLLocationManagerDelegate>
@property (nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic ,strong) CLLocationManager *locationManager;
@end

@implementation PMLAddressLocationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor whiteColor];

    [self addSubview:self.iconImageView];
    [self addSubview:self.nameLabel];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17);
        make.centerY.equalTo(self.mas_centerY).offset(0);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(7);
        make.centerY.equalTo(self.mas_centerY).offset(0);
//        make.top.equalTo(self.mas_top).offset(15);
    }];
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(kInternationalContent(@"定位服务当前可能尚未打开，请设置打开！"));
    } else {
        [self.locationManager startUpdatingLocation];//开始定位
    }
}

#pragma mark- =====================CLLocationManagerDelegate=====================
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = [locations lastObject]; CLGeocoder *geocoder = [[CLGeocoder alloc]init]; //反地理编码
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
    NSLog(@"--array--%d---error--%@",(int)placemarks.count,error);
    if (placemarks.count > 0) {
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        NSString *city = placemark.administrativeArea;//获取城市
        NSString *country = placemark.country;// 获取国家
        NSString *isoCountryCode = placemark.ISOcountryCode;
        NSLog(@"%@",isoCountryCode);
        self.nameLabel.text = country;
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(loactionCountry:)]) {
            [self.delegate loactionCountry:country];
        }
    }
}];
}

- (PMLBaseLabel *)nameLabel {
    if (!_nameLabel){
        _nameLabel = [[PMLBaseLabel alloc] initWithFrame:CGRectMake(25, 15, 300, 15)];
        _nameLabel.textColor = [UIColor colorWithHex:@"#1A1A1A"];
        _nameLabel.text = kInternationalContent(@"正在获取位置...");
        _nameLabel.font = [UIFont systemFontOfSize:12];
        [_nameLabel sizeToFit];
    }
    return _nameLabel;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView){
        _iconImageView = [[UIImageView alloc] init];
        [_iconImageView setImage:kImageWithName(@"region_icon_location")];
    }
    return _iconImageView;
}

- (CLLocationManager *)locationManager {
    if (!_locationManager){
        _locationManager = [CLLocationManager new];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 1000.0f;
        [_locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8以上版本定位需要）
    }
    return _locationManager;
}
@end
