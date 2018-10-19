//
//  PMLCommentInputView.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLCommentInputView.h"
#import "NSString+PMLString.h"

#define  BORDER_WIDTH_1PX  ([[UIScreen mainScreen] scale] > 0.0 ? 1.0 / [[UIScreen mainScreen] scale] : 1.0)
@interface PMLCommentInputView()<UITextViewDelegate>
@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UIView *contentView;
@end

@implementation PMLCommentInputView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.backgroundColor = [UIColor colorWithHex:@"#FFFFFF"];
//    [self addSubview:self.sentButton];
//    [self addSubview:self.inputTV];
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.inputTV];
}

- (void)layoutSubviews {
//    [self.sentButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.mas_right).offset(-5);
//        make.top.equalTo(self.mas_top).offset(5);
//        make.bottom.equalTo(self.mas_bottom).offset(-5);
//        make.width.mas_equalTo(40);
//    }];

    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(8);
        make.bottom.equalTo(self.mas_bottom).offset(-8);
        make.left.equalTo(self.mas_left).offset(25);
        make.right.equalTo(self.mas_right).offset(-25);
    }];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(0);
        make.height.mas_equalTo(11);
        make.width.mas_equalTo(11);
    }];
    [self.inputTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(5);
        make.top.equalTo(self.contentView.mas_top).offset(1);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
}

- (void)sentClickSuccess:(UIButton *)sender{

    if (self.textHandle){
        self.textHandle(self.inputTV.text);
    }
    if (self.inputKDelegate != nil && [self.inputKDelegate respondsToSelector:@selector(commentInputKViewSentText:)]) {
        [self.inputKDelegate commentInputKViewSentText:self.inputTV.text];
    }

    self.inputTV.text = [self defaultStr];
    [self resignFirstResponster];
}

#pragma mark- =====================public method=====================
- (void)becomeFirstResponster{
    [self.inputTV becomeFirstResponder];
//    [self.sentButton setBackgroundColor:[UIColor colorWithHex:@"#0096ff"]];
//    [self.sentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

}

- (void)becomeFirstResponsterWithtxtHandle:(void (^)(NSString *))txtHandle {
    self.textHandle = txtHandle;
    [self becomeFirstResponster];
}

- (void)resignFirstResponster{
    [self.inputTV resignFirstResponder];
//    [self.sentButton setBackgroundColor:[UIColor colorWithHex:@"#BFBFBF"]];
//    [self.sentButton setTitleColor:[UIColor colorWithHex:@"#999999"] forState:UIControlStateNormal];


}

- (BOOL)isFirstResponsder {

    return self.inputTV.isFirstResponder;
}

#pragma mark - Delegate -
//MARK: UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    textView.text = @"";
    if (self.clickActionHandle){
        self.clickActionHandle();
        return NO;
    }
    //self.inputTV.text = @"";
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([self.inputTV.textInputMode primaryLanguage] == nil){
        return NO;
    }

    if ([NSString JudgeStringIsContainEmoji:text]){
        text = @"";
        [textView.text stringByReplacingOccurrencesOfString:text withString:@""];
    }

    if ([text  isEqual: @"\n"]){
        [self sentClickSuccess:nil];
        return NO;
    }

    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    textView.text = [self defaultStr];
}

//- (void)setIsEnableUse:(BOOL)isEnableUse {
//    _isEnableUse = isEnableUse;
//    if (!isEnableUse){
//        self.inputTV.editable = NO;
//        self.sentButton.enabled = NO;
//    }
//}

- (void)setClickActionHandle:(void (^)(void))clickActionHandle {
    _clickActionHandle = clickActionHandle;
}

- (UIView *)contentView {
    if (!_contentView){
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor whiteColor];
        [_contentView.layer setBorderWidth:BORDER_WIDTH_1PX];
        [_contentView.layer setBorderColor:[UIColor colorWithHex:@"#999999"].CGColor];
        _contentView.layer.cornerRadius = 14;
        _contentView.layer.masksToBounds = false;
    }
    return _contentView;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [UIImageView new];
        [_imgView setImage:[UIImage imageNamed:@"home_detail_icon"]];
    }
    return _imgView;
}

- (UITextView *)inputTV
{
    if (!_inputTV) {
        _inputTV = [[UITextView alloc] init];
        [_inputTV setFont:[UIFont systemFontOfSize:12.0f]];
        [_inputTV setReturnKeyType:UIReturnKeySend];
//        [_inputTV.layer setMasksToBounds:YES];
//        [_inputTV.layer setBorderWidth:BORDER_WIDTH_1PX];
//        [_inputTV.layer setBorderColor:[UIColor colorWithWhite:0.0 alpha:0.3].CGColor];
//        [_inputTV.layer setCornerRadius:4.0f];
        [_inputTV setTextColor:[UIColor colorWithHex:@"#666666"]];
        _inputTV.textAlignment = NSTextAlignmentLeft;
        _inputTV.text = [self defaultStr];
        [_inputTV setDelegate:self];
        [_inputTV setScrollsToTop:NO];
    }
    return _inputTV;
}

- (UIButton *)sentButton {
    if (!_sentButton){
        _sentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sentButton setTitle:kInternationalContent(@"发送") forState: UIControlStateNormal];
        [_sentButton setTitleColor:[UIColor colorWithHex:@"#999999"] forState:UIControlStateNormal];
        _sentButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sentButton setBackgroundColor:[UIColor colorWithHex:@"#BFBFBF"]];
        [_sentButton addTarget:self action:@selector(sentClickSuccess:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sentButton;
}

- (NSString *)defaultStr {
    return  kInternationalContent(@"添加评论......");
}
@end
