//
//  IndicatorView.m
//  Gradient Progress
//
//  Created by shane west on 16/8/27.
//  Copyright © 2016年 Ericsson. All rights reserved.
//

#import "BackProgressView.h"
#import "Constant.h"

@implementation BackProgressView

- (void)drawRect:(CGRect)rect {
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //1.1 设置线条的宽度
    CGContextSetLineWidth(ctx, 20);
    //1.2 设置线条的起始点样式
    CGContextSetLineCap(ctx,kCGLineCapButt);
    //1.3  虚实切换 ，实线5虚线10
    CGFloat length[] = {6,6};
    CGContextSetLineDash(ctx, 0, length, 2);
    //1.4 设置颜色
    [[UIColor colorWithWhite:1 alpha:0.1] set];
    //2.设置路径
    CGContextAddArc(ctx, self.width*0.5, self.height*0.5, self.width*0.39, beginAngle, endAngle, 0);
    //3.绘制
    CGContextStrokePath(ctx);
}

@end
