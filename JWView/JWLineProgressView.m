//
//  JWLineProgressView.m
//  DongYa
//
//  Created by gjtxz on 15/8/25.
//  Copyright (c) 2015年 hanyou. All rights reserved.
//

#import "JWLineProgressView.h"
#import <QuartzCore/QuartzCore.h>

@interface JWLineProgressView ()
 
@end

@implementation JWLineProgressView


- (instancetype)init{
    self  = [super init];
    if (!self) {
        return nil;
    }
    self.bounds = CGRectMake(0, 0, 100, 40);
    [self setUp];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    [self setUp];
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self setUp];
}

- (void)setUp{
    self.backgroundColor = [UIColor clearColor];
    _bacColor = [UIColor yellowColor];
    _fillColor = [UIColor purpleColor];
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self addGestureRecognizer:recognizer];
}

- (void)drawRect:(CGRect)rect{

    CGFloat w = 8;
    
    //获得处理的上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //指定直线样式
    CGContextSetLineCap(context, kCGLineCapSquare);
    //直线宽度
    CGContextSetLineWidth(context, 2.0);
    
    //设置颜色
    CGContextSetStrokeColorWithColor(context, _bacColor.CGColor);   //设置颜色
    //开始绘制
    CGContextBeginPath(context);
    NSInteger all = rect.size.width/w;
    
    for (NSInteger i = 0; i < all; i ++) {
        CGContextMoveToPoint(context,2+ i *w , 2);
        CGContextAddLineToPoint(context,2+i *w, rect.size.height -4);
    }
    //绘制完成
    CGContextStrokePath(context);

    
    //设置颜色
    CGContextSetStrokeColorWithColor(context, _fillColor.CGColor);   //设置颜色
    //开始绘制
    CGContextBeginPath(context);
    
    NSInteger hall = (NSInteger)(_percent* all);
    for (NSInteger i = 0; i < hall-1; i ++) {
        CGContextMoveToPoint(context, 2+i *w , 2);
        CGContextAddLineToPoint(context,2+i *w, rect.size.height - 4);
    }
    //绘制完成
    CGContextStrokePath(context);
 
  
    CGContextSetStrokeColorWithColor(context, _fillColor.CGColor);   //设置颜色
    CGFloat x = MAX(hall-1, 0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 2+x*w , 2);
    CGContextAddLineToPoint(context,2+x*w, rect.size.height -4);
    CGContextStrokePath(context);
    
}



-(void)handlePan:(UIPanGestureRecognizer *)recognizer{
    CGPoint touchPoint = [recognizer locationInView:self];
    CGFloat per = (touchPoint.x/self.bounds.size.width);
    [self setPercent:per];
 
}
 
-(void)setPercent:(CGFloat)percent{
    _percent = MAX(percent, 0);
    _percent = MIN(percent, 1);
    [self setNeedsDisplay];
 
}

-(void)setBacColor:(UIColor *)bacColor{
    if (! CGColorEqualToColor(_bacColor.CGColor, bacColor.CGColor)) {
        _bacColor = bacColor;
        [self setNeedsDisplay];
    }
}

-(void)setFillColor:(UIColor *)fillColor{
    if (! CGColorEqualToColor(_fillColor.CGColor, fillColor.CGColor)) {
        _fillColor = fillColor;
        [self setNeedsDisplay];
    }
}

@end
