//
//  JWCircleView.h
//  DongYa
//
//  Created by gjtxz on 15/8/24.
//  Copyright (c) 2015年 hanyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWCircleView : UIView
// 0 ~ 1
@property (assign,nonatomic) CGFloat percent;

//渐变主色 alpha 渐变
@property (strong,nonatomic) UIColor *mainColor;

@end
