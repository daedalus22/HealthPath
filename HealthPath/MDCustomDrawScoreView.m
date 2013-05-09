//
//  MDCustomDrawScoreView.m
//  HealthPathBCBS
//
//  Created by Dean Chen on 5/8/13.
//  Copyright (c) 2013 Dean Chen. All rights reserved.
//

#import "MDCustomDrawScoreView.h"

@implementation MDCustomDrawScoreView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    int centerx = 160, centery = 120, radius = 100, linewidth = 40;

    // Drawing code
#if 1
    CGContextSaveGState(context);
    CGContextSetLineCap(context, kCGLineCapButt);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:(30.0/255) green:(130.0/255) blue:0.0 alpha:1.0].CGColor);
    CGContextSetLineWidth(context, linewidth);
    
    // dashed line
    // CGFloat dashArray[] = {16,8};
    // CGContextSetLineDash(context, 0, dashArray, 2);
    
    // draws circle centered at (160, 120) radius 80. from top (-pi/2) to pi, clockwise
    bool clockwise = YES;
    CGContextAddArc(context,
                    centerx,
                    centery,
                    radius,
                    0,
                    2*M_PI,
                    clockwise ? 0 : 1);
    
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
#endif
    
    // draw a dot
    linewidth = 15;
    
    float cosR, sinR;
    cosR = cosf(-M_PI_4)*radius*1.3;
    sinR = sinf(-M_PI_4)*radius*1.3;
    CGContextSaveGState(context);

    CGContextMoveToPoint(context, centerx+cosR, centery+sinR);
    // CGContextMoveToPoint(context, centerx, centery);

    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, linewidth);

    
    CGContextAddLineToPoint(context, centerx+cosR + 1, centery+sinR);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    cosR = cosf(-3*M_PI_4)*radius*0.7;
    sinR = sinf(-3*M_PI_4)*radius*0.7;
    CGContextSaveGState(context);
    
    CGContextMoveToPoint(context, centerx+cosR, centery+sinR);
    // CGContextMoveToPoint(context, centerx, centery);
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, linewidth);
    
    
    CGContextAddLineToPoint(context, centerx+cosR + 1, centery+sinR);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
    cosR = cosf(M_PI_2)*radius*1.0;
    sinR = sinf(M_PI_2)*radius*1.0;
    CGContextSaveGState(context);
    
    CGContextMoveToPoint(context, centerx+cosR, centery+sinR);
    // CGContextMoveToPoint(context, centerx, centery);
    
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, linewidth);
    
    
    CGContextAddLineToPoint(context, centerx+cosR + 1, centery+sinR);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
    
}


@end
