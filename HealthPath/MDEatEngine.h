//
//  MDEatEngine.h
//  HealthPathBCBS
//
//  Created by Dean Chen on 5/7/13.
//  Copyright (c) 2013 Dean Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDEngineProtocol.h"

@interface MDEatEngine : NSObject <MDEngineProtocol>

@property (weak, nonatomic) id ctrlrDelegate;

-(id) initWithDelegate:(id)delegate;
-(void) start;
-(void) stop;

-(float) summary;
-(NSArray *) dataSetFor:(MDTimePeriod)period;

@property (nonatomic) int todayWaterLeft;
@property (nonatomic) int todayVeggieLeft;

@end
