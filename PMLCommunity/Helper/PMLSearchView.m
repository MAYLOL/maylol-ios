//
//  PMLSearchView.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/23.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLSearchView.h"
@interface PMLSearchView ()<UITextFieldDelegate>
@property (nonatomic, strong) PMLBaseTextField *searchField;
@property (nonatomic, strong) PMLBaseButton *searchIcon;
@end
@implementation PMLSearchView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHex:@"#f5f5f5"];
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews
{
    _searchIcon = [PMLBaseButton buttonWithType:UIButtonTypeCustom];
    [_searchIcon setImage:kImageWithName(@"search_icon") forState:UIControlStateNormal];
    [_searchIcon sizeToFit];
    [self addSubview:_searchIcon];
    
    _searchField = [[PMLBaseTextField alloc] init];
    _searchField.delegate = self;
    _searchField.returnKeyType = UIReturnKeySearch;
    _searchField.placeholder = @"搜索您感兴趣的内容";
    [_searchField setValue:[UIColor colorWithHex:@"#b3b3b3"] forKeyPath:@"_placeholderLabel.textColor"];
    [_searchField setValue:[UIFont customPingFRegularFontWithSize:12] forKeyPath:@"_placeholderLabel.font"];
    _searchField.font = [UIFont customPingFRegularFontWithSize:12];
    [self addSubview:_searchField];
}

#pragma mark-UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField hasText]) {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark-getter setter
- (void)setPlaceholderStr:(NSString *)placeholderStr
{
    _placeholderStr = placeholderStr;
    self.searchField.placeholder = _placeholderStr;
}

- (PMLBaseTextField *)searchField {
    return _searchField;
}

- (BOOL)isFirstResponder {
    if ([self.searchField isFirstResponder]) {
        return YES;
    }else {
        return NO;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.searchIcon.x = 17;
    self.searchIcon.centerY = self.centerY;
    
    self.searchField.frame = CGRectMake(self.searchIcon.right + 13, 0, self.width - self.searchIcon.right - 13, self.height);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
