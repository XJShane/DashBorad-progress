//
//  GraProgressView.m
//  Gradient Progress
//
//  Created by shane west on 16/8/27.
//  Copyright © 2016年 Ericsson. All rights reserved.
//

#import "GraProgressView.h"
#import "Constant.h"

@implementation GraProgressView
- (void)drawRect:(CGRect)rect {
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //1.1 设置线条的宽度
    CGContextSetLineWidth(ctx, 20);
    //1.2 设置线条的起始点样式
    CGContextSetLineCap(ctx,kCGLineCapButt);
    //1.3  虚实切换 ，实线5虚线10
    CGFloat length[] = {6,6}; //6,6.5
    CGContextSetLineDash(ctx, 0, length, 2);
    //1.4 设置颜色
    [[UIColor whiteColor] set];
    
    // 计算结束角度
    CGFloat end = beginAngle + (rotateAngle*(_num)/rotateSpeed);
    
    //2.设置路径
    if (_num > 0)
    {
        CGContextAddArc(ctx, self.width*0.5, self.height*0.5, self.width*0.39, beginAngle, end , 0);
        //3.绘制
        CGContextStrokePath(ctx);
    }
}

#pragma mark - set方法赋值 重绘
- (void)setNum:(NSInteger)num
{
    _num = num;
    [self setNeedsDisplay];
    _numLabel.text = [NSString stringWithFormat:@"%ld", num];
    [_numLabel sizeToFit];
}


#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _num = 0;
        
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake((GLScreenWidth-150)/2, (GLScreenWidth-150)/2, 120, 80)];
        _numLabel.textAlignment  = NSTextAlignmentCenter;
        _numLabel.textColor = [UIColor whiteColor];
        _numLabel.font = [UIFont systemFontOfSize:100];
        _numLabel.alpha = 1.0;
        [self addSubview:_numLabel];
    }
    return self;
}




@end
