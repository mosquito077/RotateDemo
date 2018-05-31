//
//  ViewController.m
//  Demo
//
//  Created by Misty on 2018/5/28.
//  Copyright © 2018年 Misty. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIButton *btn2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 40, 40)];
    self.btn.backgroundColor = [UIColor blackColor];
    self.btn.selected = NO;
    [self.btn addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btn];
    
    self.btn2 = [[UIButton alloc] initWithFrame:CGRectMake(140, 80, 40, 20)];
    self.btn2.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.btn2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tapped:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {      //锁定
        //关锁动画
        self.btn2.layer.anchorPoint = CGPointMake(0, 1);
        self.btn2.layer.position = CGPointMake(140+0*40, 80+1*20);
        
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        rotationAnimation.byValue = [NSNumber numberWithFloat:-M_PI];
        rotationAnimation.duration = 0.5;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = 1;
        rotationAnimation.removedOnCompletion = NO;
        rotationAnimation.fillMode = kCAFillModeForwards;
        [self.btn2.layer addAnimation:rotationAnimation forKey:nil];
        
        //下移动画
        CABasicAnimation *positionAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        positionAnimation.fromValue = [NSValue valueWithCGPoint:self.btn2.layer.position];
        positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.btn2.layer.position.x, self.btn2.layer.position.y+3.f)];
        positionAnimation.duration = 0.5;
        positionAnimation.cumulative = YES;
        positionAnimation.beginTime = CACurrentMediaTime() + 0.5;
        positionAnimation.repeatCount = 1;
        positionAnimation.removedOnCompletion = NO;
        positionAnimation.fillMode = kCAFillModeForwards;
        [self.btn2.layer addAnimation:positionAnimation forKey:@"downAnimation"];
        
    } else {             //解锁
        //上移动画
        CABasicAnimation *upAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
        upAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.btn2.layer.position.x, self.btn2.layer.position.y+3.f)];
        upAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.btn2.layer.position.x, self.btn2.layer.position.y)];
        upAnimation.duration = 0.5;
        upAnimation.cumulative = YES;
        upAnimation.repeatCount = 1;
        upAnimation.removedOnCompletion = NO;
        upAnimation.fillMode = kCAFillModeForwards;
        [self.btn2.layer addAnimation:upAnimation forKey:@"upAnimation"];
        
        //开锁动画
        self.btn2.layer.anchorPoint = CGPointMake(0, 1);
        CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        rotationAnimation.byValue = [NSNumber numberWithFloat:-M_PI];
        rotationAnimation.duration = 0.5;
        rotationAnimation.beginTime = CACurrentMediaTime() + 0.5;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = 1;
        rotationAnimation.removedOnCompletion = NO;
        rotationAnimation.fillMode = kCAFillModeForwards;
        [self.btn2.layer addAnimation:rotationAnimation forKey:nil];
    }
}



@end
