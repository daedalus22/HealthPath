//
//  MDCustomDrawMoveScoreBarView.m
//  HealthPathBCBS
//
//  Created by Dean Chen on 5/9/13.
//  Copyright (c) 2013 Dean Chen. All rights reserved.
//

#import "MDCustomDrawMoveScoreBarView.h"

@implementation MDCustomDrawMoveScoreBarView
@synthesize barViewMoveScore;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#if 0
void draw3PxStroke(CGContextRef context, CGPoint startPoint, CGPoint endPoint, CGColorRef color)
{
    CGContextSaveGState(context);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextSetLineWidth(context, 3.0);
    CGContextMoveToPoint(context, startPoint.x + 0.5, startPoint.y + 0.5);
    CGContextAddLineToPoint(context, endPoint.x + 0.5, endPoint.y + 0.5);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}
#endif

void drawBar(CGContextRef context, float x, float y, float h, CGColorRef color) {
    CGPoint startPoint = CGPointMake(x, y);
    CGPoint endPoint = CGPointMake(x, y - h);
    
    CGContextSaveGState(context);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextSetLineWidth(context, 70);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    int barx = 160, bary = 420;
    int height = self.barViewMoveScore/100*300;
    
    drawBar(context, barx, bary, height, [UIColor purpleColor].CGColor
            );
#if 0
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
#endif
}


@end
