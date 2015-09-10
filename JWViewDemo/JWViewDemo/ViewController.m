//
//  ViewController.m
//  JWViewDemo
//
//  Created by gjtxz on 15/9/10.
//  Copyright (c) 2015年 hanyou. All rights reserved.
//

#import "ViewController.h"
#import "JWCircleView.h"
#import "JWLineProgressView.h"
#import "JWSlide.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *slide;

@property (weak, nonatomic) IBOutlet JWCircleView *circleView;
@property (weak, nonatomic) IBOutlet JWLineProgressView *lineView;
@property (weak, nonatomic) IBOutlet JWSlide *doubleSlide;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)slideChange:(UISlider *)sender {
    _circleView.percent = sender.value;
    if (sender.value < 0.5) {
        _circleView.mainColor = [UIColor redColor];
    }else{
        _circleView.mainColor = [UIColor greenColor];
    }
    _lineView.percent = sender.value;

}

@end
