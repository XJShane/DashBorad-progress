//
//  ShapeProgressView.h
//  Gradient Progress
//
//  Created by shane west on 16/8/27.
//  Copyright © 2016年 Ericsson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShapeProgressView : UIView
/** 半径 */
@property (nonatomic, assign) CGFloat radius;
/** 扇形角度范围 */
@property (assign, nonatomic) CGFloat arcAngle;
/** 指针宽度 */
@property (assign, nonatomic) CGFloat indicatorWidth;
/** 指针透明 */
@property (assign, nonatomic) CGFloat indicatorAlpha;
/** 起始偏移角度 */
@property (assign, nonatomic) CGFloat offsetAngle;

@property (assign, nonatomic) BOOL isIndicator;


/**
 *  重绘
 */
- (void)redraw;
@end
