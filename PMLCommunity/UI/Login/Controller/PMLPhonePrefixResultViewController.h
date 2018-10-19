//
//  PMLPhonePrefixResultViewController.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/8.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseViewController.h"

typedef void (^PMLPhonePrefixResultItemSelectedBlock)(NSString *countryName,NSString *zone);

@interface PMLPhonePrefixResultViewController : PMLBaseViewController<UISearchResultsUpdating>
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, strong) NSDictionary *localList;
@property (nonatomic, copy) PMLPhonePrefixResultItemSelectedBlock itemSeletectedBlock;
@end
