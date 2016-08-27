//
//  ViewController.m
//  Gradient Progress
//
//  Created by shane west on 16/8/27.
//  Copyright © 2016年 Ericsson. All rights reserved.
//

#import "ViewController.h"
#import "Constant.h"
#import "BackProgressView.h"
#import "GraProgressView.h"
#import "IndicatorProgressView.h"
#import "ShapeProgressView.h"
@interface ViewController ()
{
    CGFloat _topOffset;
}
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIImageView *carSque;
@property (nonatomic, strong) BackProgressView *backView; /** 底色进度条 */
@property (nonatomic, strong) GraProgressView *graView; /** 渐变进度条 */
@property (nonatomic,strong) NSTimer *proTimer;
@property (nonatomic, strong) IndicatorProgressView *radarView; /** 扇形 */
@property (nonatomic, strong) IndicatorProgressView *indicatorView; /** 扇形 */
@end

@implementation ViewController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initBaseAttribute];
    [self initProgressView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!self.proTimer) {
        self.proTimer = [NSTimer scheduledTimerWithTimeInterval:kProgressSpeed target:self selector:@selector(changeRadarView) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.proTimer forMode:NSRunLoopCommonModes];
    }
}

#pragma mark - private
- (void)initProgressView{
    
    // 底色进度条
    self.backView.frame = CGRectMake(-8, 10, self.carSque.width, self.carSque.height);
    [self.carSque addSubview:self.backView];
    
    // 渐变进度条
    self.graView.frame = self.backView.frame;
    [self.carSque addSubview:self.graView];
    // 渐变设置
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.graView.frame;
    gradientLayer.startPoint = CGPointMake(0, 0.5);
    gradientLayer.endPoint = CGPointMake(1, 0.5);
    CGColorRef color1 = GLRGBColor(1, 133, 241).CGColor;
    CGColorRef color2 = GLRGBColor(42, 196, 184).CGColor;
    gradientLayer.colors = @[(__bridge id)color1, (__bridge id)color2];
    gradientLayer.mask = self.graView.layer;
    [self.carSque.layer addSublayer:gradientLayer];
    self.graView.frame = gradientLayer.bounds;
    
    // 扇形
    self.radarView.frame = CGRectMake(-8, 10, self.carSque.width, self.carSque.height);
    self.radarView.radius = self.carSque.width * 0.35;
    self.radarView.arcAngle = 0;
    //    self.radarView.indicatorWidth = 0.1;
    //    self.radarView.indicatorAlpha = 0.70; // 指针透明度
    self.radarView.offsetAngle = beginAngle;
    self.radarView.isRader = NO;
    [self.carSque addSubview:self.radarView];
    // 渐变
    CAGradientLayer *gradientLayerRadarView = [[CAGradientLayer alloc] init];
    gradientLayerRadarView.frame = self.radarView.frame;
    gradientLayerRadarView.startPoint = CGPointMake(0, 0.5);
    gradientLayerRadarView.endPoint = CGPointMake(1, 0.5);
    CGColorRef color3 = GLRGBA(1, 133, 241, 0.0).CGColor;
    CGColorRef color4 = GLRGBA(72, 204, 201, 0.0).CGColor;
    CGColorRef color5 = GLRGBA(72, 204, 201, 0.15).CGColor;
    CGColorRef color6 = GLRGBA(72, 204, 201, 0.36).CGColor;
    gradientLayerRadarView.colors = @[(__bridge id)color3, (__bridge id)color4, (__bridge id)color5, (__bridge id)color6];
    gradientLayerRadarView.mask = self.radarView.layer;
    [self.carSque.layer addSublayer:gradientLayerRadarView];
    self.radarView.frame = gradientLayerRadarView.bounds;
    
    // 指针
    self.indicatorView.frame = CGRectMake(-8, 10, self.carSque.width, self.carSque.height);
    self.indicatorView.radius = self.carSque.width * 0.35; // 绘制半径
    self.indicatorView.arcAngle = 0; // 扇形角度范围，default： 0
    self.indicatorView.indicatorWidth = 0.36; // 指针宽度
    self.indicatorView.indicatorAlpha = 0.25; // 指针透明度
    self.indicatorView.offsetAngle = beginAngle;
    self.indicatorView.isRader = YES;
    [self.carSque addSubview:self.indicatorView];
    
}



- (void)initBaseAttribute{
    
    self.view.backgroundColor = GLRGBA(0, 1, 10, 1.0);
    _topOffset = 100;
    // 背景1
    [self.view addSubview:self.bgView];
    self.bgView.frame = CGRectMake(0, _topOffset, GLScreenWidth, 443);
    // carSque
    [self.view addSubview:self.carSque];
    self.carSque.size = CGSizeMake(339, 326);
    self.carSque.y = _topOffset;
    self.carSque.centerX = GLScreenWidth * 0.5;
}


#pragma mark - progress control
/** 7.1 增加：进度条定时器回调 */
- (void)changeRadarView{
    // 1.进度块
    self.graView.num += 1;
    
    // 2.扇形
    self.radarView.arcAngle += 1;
    if (self.radarView.arcAngle >= SCORE)  {
        self.radarView.arcAngle = SCORE;
        [self.radarView changeRedrawRange];
    }

    // 3.指针
    self.indicatorView.arcAngle += 1;
    if (self.indicatorView.arcAngle >= SCORE)  {
        self.indicatorView.arcAngle = SCORE;
        [self.indicatorView changeRedrawRange];
        [self.proTimer invalidate];
        self.proTimer = nil;
        return;
    }
    
    // 4.扇形+指针重绘
    [self.indicatorView changeRedrawRange];
    [self.radarView changeRedrawRange];
}



#pragma mark - 懒加载
- (UIImageView *)bgView{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] init];
        _bgView.image = [UIImage imageNamed:@"car_bg_top"];
    }
    return _bgView;
}

- (UIImageView *)carSque{
    if (!_carSque) {
        _carSque = [[UIImageView alloc] init];
        _carSque.image = [UIImage imageNamed:@"car_sque"];
    }
    return _carSque;
}

- (BackProgressView *)backView{
    if (!_backView) {
        _backView = [[BackProgressView alloc] init];
        _backView.backgroundColor = [UIColor clearColor];
    }
    return _backView;
}

- (GraProgressView *)graView{
    if (!_graView) {
        _graView = [[GraProgressView alloc] init];
        _graView.backgroundColor = [UIColor clearColor];
    }
    return _graView;
}

- (IndicatorProgressView *)radarView{
    if (!_radarView) {
        _radarView = [[IndicatorProgressView alloc] init];
        _radarView.backgroundColor = [UIColor clearColor];
    }
    return _radarView;
}

- (IndicatorProgressView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[IndicatorProgressView alloc] init];
        _indicatorView.backgroundColor = [UIColor clearColor];
    }
    return _indicatorView;
}



@end
