//
//  MDCustomDrawEatScoreBarView.m
//  HealthPathBCBS
//
//  Created by Dean Chen on 5/9/13.
//  Copyright (c) 2013 Dean Chen. All rights reserved.
//

#import "MDCustomDrawEatScoreBarView.h"

@implementation MDCustomDrawEatScoreBarView
@synthesize barViewEatScore;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


void drawEatBar(CGContextRef context, float x, float y, float h, CGColorRef color) {
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
    int height = self.barViewEatScore/100*300;
    
    drawEatBar(context, barx, bary, height, [UIColor redColor].CGColor
            );
}
@end
