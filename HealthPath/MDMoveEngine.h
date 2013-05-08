//
//  MDMoveEngine.h
//  HealthPathBCBS
//
//  Created by Dean Chen on 5/7/13.
//  Copyright (c) 2013 Dean Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDEngineProtocol.h"

@interface MDMoveEngine : NSObject

@property (weak, nonatomic) id ctrlrDelegate;

-(id) initWithDelegate:(id)delegate;
-(void) start;
-(void) stop;

-(float) summary;
-(NSArray *) dataSetFor:(MDTimePeriod)period;

@end
