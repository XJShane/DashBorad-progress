//
//  Constant.h
//  Gradient Progress
//
//  Created by shane west on 16/8/27.
//  Copyright © 2016年 Ericsson. All rights reserved.
//

#import "UIView+Extension.h"


// 自定义颜色
#define GLRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.f green:(g)/255.f blue:(b)/255.f alpha:1.0]
#define GLRGBA(R, G, B, A) [UIColor colorWithRed:(R)/255.f green:(G)/255.f blue:(B)/255.f alpha:(A)]
#define GLWhiteColor(A) [UIColor colorWithRed:255.0/255.f green:255.0/255.f blue:255.0/255.f alpha:(A)]

// 屏幕宽高
#define GLScreenWidth [UIScreen mainScreen].bounds.size.width
#define GLScreenHeight [UIScreen mainScreen].bounds.size.height

#define beginAngle ((-5*M_PI_4) + (M_PI_4 * 0.2))
#define endAngle ((M_PI_4) - (M_PI_4 * 0.2))

/** 总角度 */
#define rotateAngle fabs(beginAngle - endAngle)
/** 旋转速度(总分) */
#define rotateSpeed 100
/** 分数(当前分) */
#define SCORE ((100)*(0.9))
/** 仪表盘旋转速度 */
#define kProgressSpeed 0.03