//
//  PMLGetCodeButton.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/10.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLGetCodeButton.h"
#import "UIColor+PMLColor.h"

@interface PMLGetCodeButton()
@property (nonatomic, assign) NSInteger times;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation PMLGetCodeButton

- (void)awakeFromNib {
    [super awakeFromNib];
    self.times = 60;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.times = 60;
    }
    return self;
}

- (void)click {
    self.enabled = NO;
    if (self.isOK) {
        [self setTitle:[NSString stringWithFormat:@"%ld",self.times] forState:UIControlStateDisabled];
    } else {
          [self setTitle:[NSString stringWithFormat:@"%@(%ldS)",kInternationalContent(@"重新发送"), self.times] forState:UIControlStateDisabled];
    }
//    self.backgroundColor = self.clickColor;
    [self setTitleColor:self.clickColor forState:UIControlStateDisabled];
    self.tag = 2;
    self.timer.fireDate = [NSDate date];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

}

#pragma mark - private methods

- (void)update:(NSTimer *)ti {
    if (self.times == 0) {
        [self cancel];
        return;
    }
    self.times -= 1;
    if (self.isOK){
         [self setTitle:[NSString stringWithFormat:@"%ld", self.times] forState:UIControlStateDisabled];
    } else {
        [self setTitle:[NSString stringWithFormat:@"%@(%ldS)",kInternationalContent(@"重新发送"), self.times] forState:UIControlStateDisabled];
    }

}

- (void)cancel {
    self.tag = 1;
    self.enabled = YES;
    self.times = 60;
    self.timer.fireDate = [NSDate distantFuture];
    if (self.isOK){
        [self setTitle:kInternationalContent(@"重新发送") forState:UIControlStateNormal];
        [self setTitleColor:self.backColor forState:UIControlStateNormal];
    } else {
        [self setTitle:kInternationalContent(@"重新发送") forState:UIControlStateNormal];
        [self setTitleColor:self.backColor forState:UIControlStateNormal];
    }
}

#pragma mark - getter methods

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(update:) userInfo:nil repeats:YES];
    }
    return _timer;
}



@end
