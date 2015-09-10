//
//  JWSlide.m
//  DongYa
//
//  Created by gjtxz on 15/8/27.
//  Copyright (c) 2015年 hanyou. All rights reserved.
//

#import "JWSlide.h"


@interface JWSlide()

@property (strong,nonatomic) UILabel        *label;

@property (assign,nonatomic) NSInteger      hour;
@property (assign,nonatomic) NSInteger      min;

@property (strong,nonatomic) UIImageView    *startImg;
@property (strong,nonatomic) UIImageView    *endImg;

@end


@implementation JWSlide


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
    }
    
    return self;
}
- (void)awakeFromNib{
    [self setUp];
}


- (void) setUp{
    
    
    _startAngle = -M_PI_2;
    _endAngle = -M_PI_2+0.00001;
    
    UIView *conView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:conView];
 
//    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(25, 25, self.bounds.size.width-50, self.bounds.size.height-50)];
//    img.image = [UIImage imageNamed:@"ic_sleep_dial_normal"];
//    [conView addSubview:img];
    

    
    
    UILabel *label = [[UILabel alloc]initWithFrame:conView.bounds];
    label.textColor = [UIColor purpleColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:35];
    label.text = @"0%";
    [conView addSubview:label];
    _label = label;
    
    UIImageView *imgv1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"slide1"]];
    imgv1.frame = CGRectMake(0, 0, 19, 51);
    [conView addSubview:imgv1];
    UIImageView *imgv2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"slide2"]];
    [conView addSubview:imgv2];
    imgv1.frame = CGRectMake(0, 0, 19, 51);
    _startImg= imgv1;
    _endImg = imgv2;
    
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self addGestureRecognizer:recognizer];
}


#pragma mark - 画图

- (void)drawRect:(CGRect)rect {
    
    CGFloat all =  0.0;
    if (_endAngle > _startAngle) {
        all = _endAngle - _startAngle;
    }else{
        all = _endAngle - _startAngle + (2*M_PI);
    }
  
    
    CGFloat  R2 = (self.bounds.size.width-46)/2 ;
    
    CGFloat x1 = self.bounds.size.width/2 + R2 * cos(_startAngle);
    CGFloat y1 = self.bounds.size.width/2 + R2 * sin(_startAngle);
    _startImg.center = CGPointMake(x1, y1);
    _startImg.transform = CGAffineTransformRotate(CGAffineTransformIdentity, _startAngle+M_PI_2);
 
    
    CGFloat x2 = self.bounds.size.width/2  + R2 * cos(_endAngle);
    CGFloat y2 = self.bounds.size.width/2  + R2 * sin(_endAngle);
    _endImg.center = CGPointMake(x2, y2);
    _endImg.transform = CGAffineTransformRotate(CGAffineTransformIdentity, _endAngle+M_PI_2);
 
 
    CGFloat per = all/(2*M_PI);
    
    _label.text = [NSString stringWithFormat:@"%d%%",(int)(100*per)];
    
    [self drawCradientCircle];
}


//画渐变颜色圆弧  （方法2）  r,g,b 变化
- (void)drawCradientCircle{
    CGFloat all =  0;
    if (_endAngle > _startAngle) {
        all = _endAngle - _startAngle;
    }else{
        all = _endAngle - _startAngle + (2*M_PI);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat fromR = 0.0,fromG = 0.0,fromB = 0.0;
    [[UIColor purpleColor] getRed:&fromR green:&fromG blue:&fromB alpha:nil];
    CGFloat toR = 0.0,toG = 0.0,toB = 0.0;
    [[UIColor yellowColor] getRed:&toR green:&toG blue:&toB alpha:nil];
    
    CGFloat r, g, b;
    CGFloat lineWidth  =20;
    CGFloat  R = (self.bounds.size.width- 50- lineWidth)/2;
    NSUInteger count = 180;
    
    CGContextSetLineWidth(context, lineWidth);
    for (NSInteger i = 0; i <=  count; i++) {
        CGFloat beginAngle = _startAngle +  i* all/count;
        CGFloat toAngle  = beginAngle + all / count;
        r = fromR + (toR - fromR)/count * i;
        g = fromG + (toG - fromG)/count * i;
        b = fromB + (toB - fromB)/count * i;
        
        CGContextSaveGState(context);
        CGContextBeginPath(context);
        CGContextSetRGBStrokeColor(context, r, g, b, 1);
        CGContextAddArc(context, self.bounds.size.width / 2, self.bounds.size.height / 2, R, beginAngle, toAngle, 0);
        CGContextDrawPath(context, kCGPathStroke);
    }
}

 

#pragma mark - 手势处理

-(void)handlePan:(UIPanGestureRecognizer *)recognizer{
    
    CGPoint touchPoint = [recognizer locationInView:self];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if(CGRectContainsPoint( [self touchRectForHandle:_startImg] , touchPoint))
        {
            _startImg.highlighted = YES;
        }
        else if(CGRectContainsPoint([self touchRectForHandle:_endImg], touchPoint))
        {
            _endImg.highlighted = YES;
        }
    }
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        if (_startImg.highlighted) {
 
            [self setStartAngle:([self angleBetweenCenterAndPoint:touchPoint] - M_PI_2)];
            
        }else if (_endImg.highlighted){
 
            [self setEndAngle:([self angleBetweenCenterAndPoint:touchPoint] - M_PI_2)];
        } 
    }
    
    if(recognizer.state == UIGestureRecognizerStateEnded){

        _startImg.highlighted = NO;
        _endImg.highlighted = NO;

    }
    if (recognizer.state == UIGestureRecognizerStateFailed) {
        _startImg.highlighted = NO;
        _endImg.highlighted = NO;
    }
}

 


#pragma mark - Func

- (CGRect) touchRectForHandle:(UIView*) view
{
    float xPadding = 10;
    float yPadding = 10;  
    
    CGRect touchRect = view.frame;
    touchRect.origin.x -= xPadding/2.0;
    touchRect.origin.y -= yPadding/2.0;
    touchRect.size.height += xPadding;
    touchRect.size.width += yPadding;
    return touchRect;
}

-(CGFloat)angleBetweenCenterAndPoint:(CGPoint)point {
    
    CGPoint center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    CGFloat origAngle = atan2f(center.y - point.y, point.x - center.x);
    
    //Translate to Unit circle
    if (origAngle > 0) {
        origAngle = (M_PI - origAngle) + M_PI;
    } else {
        origAngle = fabs(origAngle);
    }
    
    //Rotating so "origin" is at "due north/Noon", I need to stop mixing metaphors
    origAngle = fmodf(origAngle+(M_PI/2), 2*M_PI);
    
    return origAngle;
}



#pragma mark - 属性设置

- (void)setStartAngle:(CGFloat)startAngle{
    _startAngle = startAngle;
    [self setNeedsDisplay];
}

- (void)setEndAngle:(CGFloat)endAngle{
    _endAngle = endAngle;
    [self setNeedsDisplay];
}

- (void)setEnabledSlide:(BOOL)enabledSlide{
    self.userInteractionEnabled = enabledSlide;
}


@end
