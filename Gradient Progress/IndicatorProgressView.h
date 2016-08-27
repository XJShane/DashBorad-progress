//
//  IndicatorProgressView.h
//  Gradient Progress
//
//  Created by shane west on 16/8/27.
//  Copyright © 2016年 Ericsson. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShapeProgressView;

@interface IndicatorProgressView : UIView
/** 半径 */
@property (nonatomic, assign) CGFloat radius;
/** 背景图片 */
@property (nonatomic, strong) UIImage *backgroundImage;
/** 扇形指针 */
@property (nonatomic, weak) ShapeProgressView *shapeView;
/** 扇形角度范围 */
@property (assign, nonatomic) CGFloat arcAngle;
/** 指针宽度 */
@property (assign, nonatomic) CGFloat indicatorWidth;
/** 指针透明 */
@property (assign, nonatomic) CGFloat indicatorAlpha;
/** 起始偏移角度 */
@property (assign, nonatomic) CGFloat offsetAngle;
/** 是否画底色 */
@property (assign, nonatomic) BOOL isRader;

/** 指针 */
@property (nonatomic,strong) CAGradientLayer *lineView;

/**
 *  重新绘制修改范围
 */
- (void)changeRedrawRange;

@end
