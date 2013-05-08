//
//  MDThirdCustomTableViewController.h
//  HealthPath
//
//  Created by Dean Chen on 5/3/13.
//  Copyright (c) 2013 Dean Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDMoveEngine.h"
#import "MDEatEngine.h"
#import "MDSleepEngine.h"
#import "MDEngineProtocol.h"
#import "MDCustomScoreView.h"

@interface MDThirdCustomTableViewController : UITableViewController

@property (strong, nonatomic) MDMoveEngine *moveEngine;
@property (strong, nonatomic) MDEatEngine *eatEngine;
@property (strong, nonatomic) MDSleepEngine *sleepEngine;
@property (strong, nonatomic) IBOutlet MDCustomScoreView *scoreView;
@property (strong, nonatomic) IBOutlet UITableViewCell *scoreCell;

@end
