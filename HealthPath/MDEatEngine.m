//
//  MDEatEngine.m
//  HealthPathBCBS
//
//  Created by Dean Chen on 5/7/13.
//  Copyright (c) 2013 Dean Chen. All rights reserved.
//

#import "MDEatEngine.h"
#import "MDEngineProtocol.h"

@interface MDEatEngine () {
    bool taskRunning;
}
@end

@implementation MDEatEngine

@synthesize ctrlrDelegate;
@synthesize todayWaterLeft;
@synthesize todayVeggieLeft;

-(id) initWithDelegate:(id)delegate {
    self = [super init];
    
    self.ctrlrDelegate = delegate;
    self.todayWaterLeft = 8;
    self.todayVeggieLeft = 3;

    // perform other initialization here. start task loop if necessary
    NSLog(@"Eat Engine initialized");
    return self;
    
    return self;
}

-(void) performTask {
    float period = 1.0;
    
    // the main run loop for this model to perform its tasks
    while (taskRunning) {
        // NSLog(@"period task that runs every %f seconds", period);
        sleep(period);
    }
}

-(void) start {
    // start run loop for task implemented by FirstModel
    taskRunning = YES;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        [self performTask];
    });
}

-(void) stop {
    // stop run loop
    taskRunning = NO;
}

-(float) summary {
    // returns summary score representing status
    return (float)((int)(100-self.todayVeggieLeft*33.33));
}

-(NSArray *) dataSetFor:(MDTimePeriod)period {
    switch (period) {
        case MD_DAILY:
            return nil;
        case MD_WEEKLY:
            return nil;
        case MD_MONTHLY:
            return nil;
        case MD_YEARLY:
            return nil;
        default:
            return nil;
    }
}

@end
