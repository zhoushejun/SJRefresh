//
//  SJPullRefreshImageView.m
//  SJRefresh
//
//  Created by zhoushejun on 16/10/9.
//  Copyright © 2016年 zhoushejun. All rights reserved.
//

#import "SJPullRefreshImageView.h"

@interface SJPullRefreshImageView ()

@property (nonatomic, strong) UIBezierPath *thePath;
@property (nonatomic, strong) CAShapeLayer *lineLayer; ///< 下拉过程中的进度条图层
@property (nonatomic, strong) CAShapeLayer *animationLayer; ///< 请求时转啊转的那个图层

@end

@implementation SJPullRefreshImageView

- (instancetype)init {
    if (self = [super init]) {
        [self drawStartAngle:0 endAngle:0];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self drawStartAngle:0 endAngle:0];
    }
    return self;
}

- (void)drawStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle {
    self.hidden = NO;

    [_lineLayer removeFromSuperlayer];
    _lineLayer = nil;
    
    _lineLayer = [[CAShapeLayer alloc] init];
    _lineLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width);
    _lineLayer.position = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    
    _thePath = [UIBezierPath bezierPathWithArcCenter:_lineLayer.position
                                              radius:self.bounds.size.width/2.0-1/[UIScreen mainScreen].scale
                                          startAngle:startAngle
                                            endAngle:endAngle
                                           clockwise:NO];

    _lineLayer.path = _thePath.CGPath;
    _lineLayer.fillColor = [UIColor clearColor].CGColor;
    _lineLayer.strokeColor = [UIColor whiteColor].CGColor;
    _lineLayer.hidden = NO;
    
    if (self.bounds.size.width < 15.0) {
        _lineLayer.lineWidth = 2.0;
    }
    else if (self.bounds.size.width < 30.0) {
        _lineLayer.lineWidth = 3*self.bounds.size.width/15.0;
    }
    else {
        
        _lineLayer.lineWidth = 3.0;
    }
    [self.layer addSublayer:_lineLayer];
    self.alpha = self.bounds.size.width / 30.0;
}

- (void)startAnimation {
    self.isAnimation = YES;
    self.lineLayer.hidden = YES;
    self.animationLayer.hidden = NO;
    [self.layer addSublayer:self.animationLayer];
    self.bounds = CGRectMake(0, 0, 30, 30);
    [self drawStartAngle:-M_PI_2
                endAngle:-M_PI_2+2*M_PI*self.bounds.size.width/30];
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.fromValue = @(-M_PI_2);
    rotateAnimation.toValue = @(-M_PI_2+2 * M_PI);
    rotateAnimation.duration = 1;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = NO;
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotateAnimation.repeatCount = HUGE;
    [self.animationLayer addAnimation:rotateAnimation forKey:@"rotateAnimation"];
//    [self strokeEndAnimation];
}

- (void)strokeEndAnimation {
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0.2);
    strokeEndAnimation.toValue = @(0.2);
    strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    strokeEndAnimation.duration = 2;
    strokeEndAnimation.repeatCount = HUGE;
    strokeEndAnimation.fillMode = kCAFillModeForwards;
    strokeEndAnimation.removedOnCompletion = NO;
    [self.animationLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimation"];
}

- (void)endAnimation {
    self.isAnimation = NO;
    self.animationLayer.hidden = YES;
    [self.animationLayer removeAllAnimations];
}

#pragma mark - setter and getter 

- (CAShapeLayer *)animationLayer {
    if (!_animationLayer) {
        _animationLayer = [[CAShapeLayer alloc] init];
        CGPoint arcCenterPoint = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
        CGFloat arcRadius = 14.5;
        CGFloat arcStartAngle = 0;
        CGFloat arcEndAngle = M_PI_4/4;
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:arcCenterPoint
                                                                  radius:arcRadius
                                                              startAngle:arcStartAngle
                                                                endAngle:arcEndAngle clockwise:YES];
        _animationLayer.path = bezierPath.CGPath;
        _animationLayer.fillColor = nil;
        _animationLayer.strokeColor = [UIColor whiteColor].CGColor;
        _animationLayer.lineWidth = 3.0;
        _animationLayer.lineCap = kCALineCapRound;
        _animationLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width);
        _animationLayer.position = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    }
    return _animationLayer;
}

@end
