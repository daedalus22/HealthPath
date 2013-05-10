//
//  MDCustomDrawEatScoreBarView.m
//  HealthPathBCBS
//
//  Created by Dean Chen on 5/9/13.
//  Copyright (c) 2013 Dean Chen. All rights reserved.
//

#import "MDCustomDrawEatScoreBarView.h"

#define BARHEIGHT 230

@implementation MDCustomDrawEatScoreBarView
@synthesize barViewEatScore = _barViewEatScore;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


static void drawEatBar(CGContextRef context, float x, float y, float h, CGColorRef color) {
    
    CGPoint startPoint = CGPointMake(x, y);
    CGPoint endPoint = CGPointMake(x, y - h);
    
    
    CGContextSaveGState(context);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, 70);
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, y-BARHEIGHT);
    CGContextStrokePath(context);

    if (h <= 0) {
        CGContextRestoreGState(context);
        return;
    }
    CGContextSetStrokeColorWithColor(context, color);
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
    int barx = 160, bary = 350;
    int height = self.barViewEatScore/100.0*BARHEIGHT;
 
    // some tweaking adjust for line width
    if (height < 70) {
        height = height - 30;
    } else {
        if (height < 150) {
            height = height - 40;
        }
    }
    
    
    
    drawEatBar(context, barx, bary, height, [UIColor colorWithRed:131/255.0 green:196/255.0 blue:87/255.0 alpha:1.0].CGColor);
}
@end
