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
@property (nonatomic, strong) CAShapeLayer *lineLayer;
@end

@implementation SJPullRefreshImageView

- (instancetype)init {
    if (self = [super init]) {
        [self addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:nil];

        [self drawStartAngle:0 endAngle:0];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:nil];

        [self drawStartAngle:0 endAngle:0];
    }
    return self;
}

- (void)drawStartAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle {
    [_lineLayer removeFromSuperlayer];
    _lineLayer = [[CAShapeLayer alloc] init];
    _lineLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width);
    _lineLayer.position = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    
    _thePath = [UIBezierPath bezierPathWithArcCenter:_lineLayer.position radius:self.bounds.size.width/2.0-1.0 startAngle:startAngle endAngle:endAngle clockwise:NO];
    _lineLayer.path = _thePath.CGPath;
    _lineLayer.fillColor = [UIColor clearColor].CGColor;
    _lineLayer.strokeColor = [UIColor blackColor].CGColor;
    if (self.bounds.size.width/2.0 < 20.0) {
        _lineLayer.lineWidth = 3*self.bounds.size.width/2.0/20.0;
    }
    else {
        
        _lineLayer.lineWidth = 3.0;
    }
    [self.layer addSublayer:_lineLayer];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    CGFloat w = 60;
    [self drawStartAngle:-M_PI_2
                     endAngle:(3/2.0)*M_PI*self.bounds.size.width/w];

}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"bounds"];
}

@end
