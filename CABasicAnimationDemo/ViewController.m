//
//  ViewController.m
//  CABasicAnimationDemo
//
//  Created by yongliangP on 16/8/16.
//  Copyright © 2016年 yongliangP. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

#define kWindowWidth  [UIScreen mainScreen].bounds.size.width
#define kWindowHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *sharkTagButton;
@property (weak, nonatomic) IBOutlet UIButton *alphaTagButton;
@property (weak, nonatomic) IBOutlet UIButton *keyButton;

//@property (weak, nonatomic) IBOutlet UIButton *alphaTagButton;

@property (nonatomic,strong) CMMotionManager *motionManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //呼吸动画
    [self setUpAlphaAnimation];
    
    //摇摆动画
    //[self setUpSharkAnimation];
    
    //陀螺仪&加速器
    [self setUpdeviceMotionAnimation];
    
//    //关键帧动画->使用Values
//    [self setUpCAKeyframeAnimationUseValues];
    
    //关键帧动画->使用path
    [self setUpCAKeyframeAnimationUsePath];

    // Do any additional setup after loading the view, typically from a nib.
}


-(void)setUpdeviceMotionAnimation
{
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.deviceMotionUpdateInterval = 1.0f/100.0f; //1秒100次
    self.sharkTagButton.layer.anchorPoint = CGPointMake(0.5, 0);
    [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        if(fabs(motion.attitude.roll)<1.0f)
        {
            [UIView animateWithDuration:0.6 animations:^{
                self.sharkTagButton.layer.transform = CATransform3DMakeRotation(-(motion.attitude.roll), 0, 0, 1);
            }];
        }else if (fabs(motion.attitude.roll)<1.5f)
        {
            [UIView animateWithDuration:0.6 animations:^{
                
                int s;
                if (motion.attitude.roll>0)
                {
                    s=-1;
                }else
                {
                    s = 1;
                }
                self.sharkTagButton.layer.transform = CATransform3DMakeRotation(s*M_PI_2, 0, 0, 1);
            }];
        }
        if ((motion.attitude.pitch)<0)
        {
            [UIView animateWithDuration:0.6 animations:^{
                self.sharkTagButton.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
            }];
        }
        
    }];
    
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
    [self.alphaTagButton.layer addAnimation:animation forKey:@"alpha"];
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
    [self.sharkTagButton.layer addAnimation:rotationAnimation forKey:@"shark"];
}


-(void)setUpCAKeyframeAnimationUseValues
{

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    animation.keyPath = @"position";
    
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(kWindowWidth - 50, 50)];
    
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(kWindowWidth - 50, kWindowHeight-50)];
    
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(50, kWindowHeight-50)];
    
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(50, 50)];
    
    animation.values = @[value1,value2,value3,value4,value5];
    animation.repeatCount = MAXFLOAT;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.duration = 6.0f;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.keyButton.layer addAnimation:animation forKey:@"values"];
    
}


-(void)setUpCAKeyframeAnimationUsePath
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    animation.keyPath = @"position";
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    //矩形线路
    CGPathAddRect(path, NULL, CGRectMake(50,50, kWindowWidth - 100,kWindowHeight - 100));
    
    animation.path=path;
    
    CGPathRelease(path);
    
    animation.repeatCount = MAXFLOAT;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    animation.duration = 6.0f;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [self.keyButton.layer addAnimation:animation forKey:@"path"];


}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
