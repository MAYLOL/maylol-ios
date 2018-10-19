//
//  UIView+PMLViewFrom.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>

CGPoint CGRectGetCenter(CGRect rect);
CGRect  CGRectMoveToCenter(CGRect rect, CGPoint center);

@interface UIView (PMLViewFrom)

@property (assign, nonatomic) CGFloat x;
@property (assign, nonatomic) CGFloat y;

@property (assign, nonatomic) CGFloat bottom;
@property (assign, nonatomic) CGFloat right;

@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) CGFloat height;

@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGPoint origin;

@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;

@property (assign, nonatomic, readonly) CGFloat maxX;
@property (assign, nonatomic, readonly) CGFloat maxY;

@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

- (void)moveBy:(CGPoint)delta;
- (void)scaleBy:(CGFloat)scaleFactor;
- (void)fitInSize:(CGSize)aSize;
+ (instancetype)loadViewFromNib;

/**
 给view设置圆角
 
 @param corners 圆角位置
 @param cornerRadii 圆角弧度
 */
- (void)setCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;


/**
 给view设置圆角虚线

 @param rect view位置
 @param radius 圆角数
 @param strokeColor 虚线x颜色
 @param lineWidth 线宽
 */
- (CAShapeLayer *)setDottedBox:(CGRect)rect cornerRadius:(CGFloat)radius strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth;
@end
