//
//  MDFirstModel.m
//  HealthPath
//
//  Created by Dean Chen on 5/3/13.
//  Copyright (c) 2013 Dean Chen. All rights reserved.
//

#import "MDFirstModel.h"

@implementation MDFirstModel

@synthesize appDelegate;

-(MDFirstModel *) initWithDelegate:(id)delegate {
    self = [super init];
    
    self.appDelegate = delegate;
    return self;
}

-(void) performTask {
    // the main run loop for this model to perform its tasks
    while (YES) {
        NSLog(@"period task that runs every %f seconds", MODEL1_RUN_PERIOD);
        sleep(MODEL1_RUN_PERIOD);
    }
}

-(void) start {
    // start run loop for task implemented by FirstModel
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
                                             (unsigned long)NULL), ^(void) {
        [self performTask];
    });
}

-(void) stop {
    // stop run loop
}

@end
