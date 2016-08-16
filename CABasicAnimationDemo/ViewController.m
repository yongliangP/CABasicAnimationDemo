//
//  ViewController.m
//  CABasicAnimationDemo
//
//  Created by yongliangP on 16/8/16.
//  Copyright © 2016年 yongliangP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *sharkTagButton;
@property (weak, nonatomic) IBOutlet UIButton *alphaTagButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //呼吸动画
    [self setUpAlphaAnimation];
    
    //摇摆动画
    [self setUpSharkAnimation];
    
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)setUpAlphaAnimation
{
    CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:1.0f];
    animation.toValue = [NSNumber numberWithFloat:0.0f];
    animation.autoreverses = YES;    //回退动画（动画可逆，即循环）
    animation.duration = 1.0f;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;//removedOnCompletion,fillMode配合使用保持动画完成效果
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.alphaTagButton.layer addAnimation:animation forKey:@"aAlpha"];
}



-(void)setUpSharkAnimation
{
    //设置旋转原点
    self.sharkTagButton.layer.anchorPoint = CGPointMake(0.5, 0);
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //角度转弧度（这里用1，-1简单处理一下）
    rotationAnimation.toValue = [NSNumber numberWithFloat:1];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:-1];
    rotationAnimation.duration = 1.0f;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.autoreverses = YES;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    rotationAnimation.fillMode = kCAFillModeForwards;
    [self.sharkTagButton.layer addAnimation:rotationAnimation forKey:@"revItUpAnimation"];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
