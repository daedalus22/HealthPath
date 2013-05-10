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
#import "MDCustomDrawScoreView.h"
#import "MDCustomDrawMoveScoreBarView.h"
#import "MDCustomDrawEatScoreBarView.h"

typedef enum MDBgImageKind_  {
    MD_BG_IMAGE_MOVE = 0,
    MD_BG_IMAGE_EAT,
    MD_BG_IMAGE_SLEEP,
    MD_NUM_ACTIVITY_KINDS
} MDBgImageKind;

typedef enum MDGraphKind_  {
    MD_BAR_MOVE = 0,
    MD_BAR_EAT,
    MD_BAR_SLEEP,
    MD_HGRAPH_ALL,
    MD_NUM_GRAPH_KINDS
} MDGraphKind;

@interface MDThirdCustomTableViewController : UITableViewController

@property (strong, nonatomic) MDMoveEngine *moveEngine;
@property (strong, nonatomic) MDEatEngine *eatEngine;
@property (strong, nonatomic) MDSleepEngine *sleepEngine;
@property (strong, nonatomic) IBOutlet MDCustomScoreView *scoreView;
@property (strong, nonatomic) IBOutlet MDCustomDrawScoreView *scoreHGraphView;
@property (strong, nonatomic) IBOutlet MDCustomDrawMoveScoreBarView *moveScoreBarView;
@property (strong, nonatomic) IBOutlet MDCustomDrawEatScoreBarView *eatScoreBarView;


@property (strong, nonatomic) IBOutlet UILabel *bvScore;
@property (strong, nonatomic) IBOutlet UILabel *bvTitle;
@property (strong, nonatomic) IBOutlet UILabel *bvGoal;


@property (strong, nonatomic) IBOutlet UITableViewCell *scoreCell;
@property (strong, nonatomic) IBOutlet UILabel *svDate;
@property (strong, nonatomic) IBOutlet UILabel *svGreeting;
@property (strong, nonatomic) IBOutlet UILabel *svScore;
@property (strong, nonatomic) IBOutlet UILabel *svEatScore;
@property (strong, nonatomic) IBOutlet UILabel *svMoveScore;
@property (strong, nonatomic) IBOutlet UILabel *svSleepScore;
@property (strong, nonatomic) IBOutlet UILabel *svWaterLeft;
@property (strong, nonatomic) IBOutlet UIButton *svWaterIcon;
@property (strong, nonatomic) IBOutlet UILabel *svVeggieLeft;
@property (strong, nonatomic) IBOutlet UIButton *svVeggieIcon;
@property (strong, nonatomic) IBOutlet UILabel *svStars;
@property (strong, nonatomic) IBOutlet UIImageView *svStarImg;

@end
