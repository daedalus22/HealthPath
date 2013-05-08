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

    // Drawing code
    CGContextSaveGState(context);
    CGContextSetLineCap(context, kCGLineCapButt);
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(context, 20.0);
    
    // dashed line
    CGFloat dashArray[] = {16,8};
    CGContextSetLineDash(context, 0, dashArray, 2);
    
    // draws circle centered at (160, 120) radius 80. from top (-pi/2) to pi, clockwise
    bool clockwise = YES;
    CGContextAddArc(context,
                    160,
                    120,
                    80,
                    -M_PI_2,
                    M_PI,
                    clockwise ? 0 : 1);
    
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}


@end
