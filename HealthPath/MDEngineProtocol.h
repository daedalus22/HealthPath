//
//  MDEngineProtocol.h
//  HealthPathBCBS
//
//  Created by Dean Chen on 5/7/13.
//  Copyright (c) 2013 Dean Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum MDCustomTableViewCellRow_  {
    MD_OVERALL_SCORE_AND_AVATAR_CELL = 0,
    MD_CORRELATION_CELL,
    MD_EAT_CELL,
    MD_MOVE_CELL,
    MD_SLEEP_CELL,
    MD_NUM_ROWS // keep this the last in the enumeration. This should match Storyboard TableView section!!
} MDCustomTableViewCellRow;

typedef enum MDTimePeriod_  {
    MD_DAILY = 0,
    MD_WEEKLY,
    MD_MONTHLY,
    MD_YEARLY
} MDTimePeriod;

@protocol MDEngineProtocol <NSObject>

-(id) initWithDelegate:(id)delegate;
-(void) start;
-(void) stop;

-(float) summary;
-(NSArray *) dataSetFor:(MDTimePeriod)period;

@end
