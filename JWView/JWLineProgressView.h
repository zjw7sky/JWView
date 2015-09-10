//
//  JWLineProgressView.h
//  DongYa
//
//  Created by gjtxz on 15/8/25.
//  Copyright (c) 2015年 hanyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWLineProgressView : UIView

// 0 ~ 1
@property (assign,nonatomic) CGFloat    percent;

@property (strong,nonatomic) UIColor    *bacColor;
@property (strong,nonatomic) UIColor    *fillColor;

@end
