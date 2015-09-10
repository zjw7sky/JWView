//
//  JWCircleView.m
//  DongYa
//
//  Created by gjtxz on 15/8/24.
//  Copyright (c) 2015年 hanyou. All rights reserved.
//

#import "JWCircleView.h"
#import <QuartzCore/QuartzCore.h>

//外围圆的 终点  画圆的宽度
#define kCircleR            10
//预留宽度
#define kReserved           10

@interface JWCircleView ()

@property (strong,nonatomic) CAShapeLayer * shapeLayer;
@property (strong,nonatomic) CAShapeLayer * shapeLayer1;

@end


@implementation JWCircleView


- (instancetype)init{
    self  = [super init];
    if (!self) {
        return nil;
    }
    self.bounds = CGRectMake(0, 0, 100, 100);
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

- (void) setUp{
    _mainColor = [UIColor redColor];
    
    CGFloat NeedR = MIN(self.bounds.size.width, self.bounds.size.height)/2;
    
    CGFloat  R = NeedR - kReserved - (kCircleR/2);
    
    // 圆环
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    [self.layer addSublayer:shapeLayer];
    shapeLayer.frame = self.bounds;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    shapeLayer.strokeColor = [[UIColor grayColor] CGColor];//指定path的渲染颜色
    shapeLayer.opacity = 0.5; //  透明度小一点
    shapeLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    shapeLayer.lineWidth = 1;//线的宽度
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:shapeLayer.position  radius:R startAngle:-M_PI_2 endAngle:3*M_PI_2 clockwise:YES];
    shapeLayer.path =[path CGPath];
//    _shapeLayer = shapeLayer;
 
    // 圆饼
//    CAShapeLayer * shapeLayer1 = [CAShapeLayer layer];
//    [self.layer addSublayer:shapeLayer1];
//    shapeLayer1.frame = self.bounds;
//    shapeLayer1.fillColor = [_mainColor CGColor];
//    shapeLayer1.lineWidth = 0;//线的宽度
//    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:shapeLayer1.position  radius:R - 20 startAngle:- M_PI_2 endAngle:3*M_PI_2 clockwise:YES];
//    shapeLayer1.path =[path1 CGPath];
//    _shapeLayer1 = shapeLayer1;
   
}

- (void)drawRect:(CGRect)rect{
    CGFloat NeedR = MIN(self.bounds.size.width, self.bounds.size.height)/2;
    
    CGFloat  R = NeedR  - kReserved - (kCircleR/2);
    
    CGFloat all = M_PI * 2 *_percent;
    CGFloat x =  NeedR + R * cos(all - M_PI_2);
    CGFloat y =  NeedR+ R * sin(all - M_PI_2);
    
    [_mainColor set];
    
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(x, y) radius:kCircleR/2 startAngle:- M_PI_2 endAngle:3*M_PI_2 clockwise:YES];
    [path2 fill];
    
    UIBezierPath *path3 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(x, y) radius:kCircleR-3 startAngle:- M_PI_2 endAngle:3*M_PI_2 clockwise:YES];
    path3.lineWidth = 1;
    [path3 stroke];
    
    UIBezierPath *path4 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(x, y) radius:kCircleR startAngle:- M_PI_2 endAngle:3*M_PI_2 clockwise:YES];
    path4.lineWidth = 0.5;
    [path4 stroke];
 
 
    [self drawCradientCircle];
}

 //画渐变颜色圆弧  （方法1）  alpha 变化
- (void)drawCradientCircle{
    
    CGFloat all = M_PI * 2 *_percent;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSUInteger count = 180;
    CGFloat NeedR = MIN(self.bounds.size.width, self.bounds.size.height)/2;
    CGFloat  R = NeedR - kReserved - (kCircleR/2);
    
    CGFloat r, g, b;
    [_mainColor getRed:&r green:&g blue:&b alpha:nil];
    for (NSInteger i = 0; i <=  count; i++) {
        CGFloat beginAngle = -M_PI_2 +  i* all/count;
        CGFloat toAngle  = beginAngle + all / count;;
        CGFloat alpha = 1.0 / count * (i + 1);
        
        CGContextSaveGState(context);
        CGContextBeginPath(context);
        CGContextSetRGBStrokeColor(context, r, g, b, alpha);
        CGContextSetLineWidth(context, kCircleR/2);
        CGContextAddArc(context, NeedR, NeedR, R, beginAngle, toAngle, 0);
        CGContextDrawPath(context, kCGPathStroke);
    }
}

#pragma mark - 属性设置

- (void)setMainColor:(UIColor *)mainColor{
    if (! CGColorEqualToColor(_mainColor.CGColor, mainColor.CGColor)) {
        _mainColor = mainColor;
        [self setNeedsDisplay];
//        _shapeLayer.strokeColor = [_mainColor CGColor];
    }

}

- (void)setPercent:(CGFloat)percent{
    _percent = MAX(percent, 0);
    _percent = MIN(percent, 1); 
    [self setNeedsDisplay];
}






@end
