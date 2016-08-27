//
//  ShapeProgressView.m
//  Gradient Progress
//
//  Created by shane west on 16/8/27.
//  Copyright © 2016年 Ericsson. All rights reserved.
//

#import "ShapeProgressView.h"
#import <QuartzCore/QuartzCore.h>
#import "Constant.h"

@implementation ShapeProgressView

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    //一个不透明类型的Quartz 2D绘画环境,相当于一个画布,你可以在上面任意绘画
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //画扇形，也就画圆，只不过是设置角度的大小，形成一个扇形
    UIColor *aColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:self.indicatorAlpha];
    CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
    CGContextSetLineWidth(context, 0);//线的宽度
    //以self.radius为半径围绕圆心画指定角度扇形
    CGContextMoveToPoint(context, self.center.x, self.center.y);
    // 画圆弧
    CGContextAddArc(context, self.center.x, self.center.y, self.radius,  self.offsetAngle+(rotateAngle*(self.arcAngle +self.indicatorWidth)/rotateSpeed), self.offsetAngle+(rotateAngle*(self.arcAngle)/rotateSpeed), 1);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
    
    if (self.isIndicator) {
        // 指针View...
        return;
    }else{
        // 多个小扇形构造渐变的大扇形  直角扇形
        for (int i = 0; i <= self.arcAngle; i++) {
            //画扇形，也就画圆，只不过是设置角度的大小，形成一个扇形
            UIColor *aColor = [UIColor colorWithRed:58/255.0f green:190/255.0f blue:209/255.0f alpha:100/100.0f]; // 原始
            CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
            CGContextSetLineWidth(context, 0);//线的宽度
            //以self.radius为半径围绕圆心画指定角度扇形
            CGContextMoveToPoint(context, self.center.x, self.center.y);
            
            if ( i ==0) {
                CGContextAddArc(context, self.center.x, self.center.y, self.radius,  self.offsetAngle+(rotateAngle*(i)/rotateSpeed), self.offsetAngle+(rotateAngle*(i)/rotateSpeed), 1);
            }else{
                CGContextAddArc(context, self.center.x, self.center.y, self.radius,  self.offsetAngle+(rotateAngle*(i)/rotateSpeed), self.offsetAngle+(rotateAngle*(i - 1.2)/rotateSpeed), 1);
            }
            
            CGContextClosePath(context);
            CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
        }
    }
}

/**
 *  重绘
 */
- (void)redraw{
    [self setNeedsDisplay];
}

@end
