//
//  MDFirstModel.h
//  HealthPath
//
//  Created by Dean Chen on 5/3/13.
//  Copyright (c) 2013 Dean Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MODEL1_RUN_PERIOD 5.0

@interface MDFirstModel : NSObject

@property (weak, nonatomic) id appDelegate;

-(MDFirstModel *) initWithDelegate:(id)delegate;
-(void) start;
-(void) stop;

@end
