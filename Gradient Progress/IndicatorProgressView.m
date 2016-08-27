//
//  IndicatorProgressView.m
//  Gradient Progress
//
//  Created by shane west on 16/8/27.
//  Copyright © 2016年 Ericsson. All rights reserved.
//

#import "IndicatorProgressView.h"
#import <QuartzCore/QuartzCore.h>
#import "Constant.h"
#import "ShapeProgressView.h"

@interface IndicatorProgressView()
@property (weak, nonatomic) CAGradientLayer *startLine;
@property (assign, nonatomic) CGFloat indicatorScale;
@end

@implementation IndicatorProgressView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        // 2.初始指针
//        [self setStartLine];
        _indicatorScale = 6.5;
    }
    
    return self;
}

/** 1.LRRadarIndicatorView */
- (void)setup {
    if (!self.shapeView) {
        ShapeProgressView *shapeView = [[ShapeProgressView alloc] init];
        [self addSubview:shapeView];
        _shapeView = shapeView;
        shapeView.isIndicator = self.isRader;
    }
}

/** 2.初始指针 */
- (void)setStartLine{
    // 1.指针
    CAGradientLayer *startLine = [CAGradientLayer layer];
    _startLine = startLine;
    // 设置尺寸r
    startLine.bounds = CGRectMake(0, 0, 2, _radius+_indicatorScale);
    // 设置位置
    startLine.position = CGPointMake(self.width*0.5, self.height*0.5);
    // 设置锚点
    startLine.anchorPoint = CGPointMake(0.5, 0.95);
    // 设置秒针渐变
    CGColorRef color1 = [UIColor colorWithWhite:1.0 alpha:0.8].CGColor;
    CGColorRef color2 = [UIColor colorWithWhite:1.0 alpha:0.1].CGColor;
    startLine.colors = @[(__bridge id)color1, (__bridge id)color2];
    // 设置圆角
    startLine.cornerRadius = 2;
    startLine.masksToBounds = YES;
    
    // 2.初始化num，初始化位置
    startLine.transform = CATransform3DMakeRotation(2*M_PI_4 + beginAngle, 0, 0, 1);
    
    // 4.添加
    [self.layer addSublayer:startLine];
    
    // 赋值保存
    _lineView = startLine;
}

#pragma mark - 重绘
- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    //那个线条 和 后面的扇形弧度，，其实frame是整个屏幕，所以旋转是绕着用户头像
    if (self.shapeView)
    {
        self.shapeView.frame = self.bounds; // frame
        self.shapeView.backgroundColor = [UIColor clearColor];
        self.shapeView.radius = self.radius; // 半径
        self.shapeView.arcAngle = self.arcAngle; // 扇形角度
        self.shapeView.indicatorWidth = self.indicatorWidth;
        self.shapeView.indicatorAlpha = self.indicatorAlpha;
        self.shapeView.offsetAngle = self.offsetAngle;
        self.shapeView.isIndicator = self.isRader;
    }
}


/**
 *  重新绘制修改范围
 */
- (void)changeRedrawRange{
    // 1.重新设置属性
    [self setIndicatorViewAttribute];
    // 2.重绘
    [self.shapeView redraw];
    
    // 不是指针直接return
    if (!_isRader) return;
    // 3.实时创建指针
    [self setLine];
    
}


/**
 *  重新设置属性
 */
- (void)setIndicatorViewAttribute{
    self.shapeView.radius = self.radius; // 半径
    self.shapeView.arcAngle = self.arcAngle; // 扇形角度
    self.shapeView.indicatorWidth = self.indicatorWidth;
    self.shapeView.indicatorAlpha = self.indicatorAlpha;
    self.shapeView.offsetAngle = self.offsetAngle;
}


/** 实时绘制(创建)指针 */
- (void)setLine{
    
    // 移除上一根
    [_lineView removeFromSuperlayer];
    
    // 1.指针
    CAGradientLayer *lineV = [CAGradientLayer layer];
    // 设置尺寸
    lineV.bounds = CGRectMake(0, 0, 2, _radius+_indicatorScale); // 6.5
    // 设置位置
    lineV.position = CGPointMake(self.width*0.5, self.height*0.5);
    // 设置锚点
    lineV.anchorPoint = CGPointMake(0.5, 0.95);
    // 设置秒针渐变
    CGColorRef color1 = [UIColor colorWithWhite:1.0 alpha:0.8].CGColor;
    CGColorRef color2 = [UIColor colorWithWhite:1.0 alpha:0.1].CGColor;
    lineV.colors = @[(__bridge id)color1, (__bridge id)color2];
    // 设置圆角
    lineV.cornerRadius = 2;
    lineV.masksToBounds = YES;
    
    lineV.transform = CATransform3DMakeRotation(2*M_PI_4 + beginAngle+(rotateAngle*(_arcAngle)/rotateSpeed), 0, 0, 1);
    
    // 4.添加
    [self.layer addSublayer:lineV];
    
    // 保存上一根
    _lineView = lineV;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    // 设置初始指针的bounds
    _startLine.bounds = CGRectMake(0, 0, 2, _radius+_indicatorScale);
}


@end
