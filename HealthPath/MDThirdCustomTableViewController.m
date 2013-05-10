//
//  MDThirdCustomTableViewController.m
//  HealthPath
//
//  Created by Dean Chen on 5/3/13.
//  Copyright (c) 2013 Dean Chen. All rights reserved.
//

#import "MDThirdCustomTableViewController.h"
#import "MDThirdCustomTableViewCell.h"
// #import "ISRefreshControl.h"
#import "MDMoveEngine.h"
#import "MDEatEngine.h"
#import "MDSleepEngine.h"
#import "MDCustomScoreView.h"
#import "MDCustomSleepView.h"
#import "MDCustomCorrView.h"
#import "MDCustomEatView.h"
#import "MDCustomMoveView.h"
#import <QuartzCore/QuartzCore.h>


@interface MDThirdCustomTableViewController () {
    float eatScore;
    float sleepScore;
    float moveScore;
    MDBgImageKind curBGImgKind;
    MDGraphKind curGraphKind;
    int stars;
    NSMutableDictionary *settings;
}
@end

@implementation MDThirdCustomTableViewController
@synthesize moveEngine;
@synthesize eatEngine;
@synthesize sleepEngine;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)update {    
    eatScore = [self.eatEngine summary];
    sleepScore = [self.moveEngine summary];
    moveScore = [self.sleepEngine summary];
    
    self.svMoveScore.text = [NSString stringWithFormat:@"%d", (int)moveScore];
    self.svSleepScore.text = [NSString stringWithFormat:@"%d", (int)sleepScore];
    self.svEatScore.text = [NSString stringWithFormat:@"%d", (int)eatScore];
    
    self.moveScoreBarView.barViewMoveScore = moveScore;
    if (curGraphKind == MD_BAR_MOVE) {
        self.bvScore.text = [NSString stringWithFormat:@"%d%%", (int)moveScore];
        self.bvGoal.text = [NSString stringWithFormat:@"TODAY'S GOAL: 10000 STEPS"];
        self.bvTitle.text = [NSString stringWithFormat:@"MOVE"];
    }

#if 1
    self.eatScoreBarView.barViewEatScore = eatScore;
    if (curGraphKind == MD_BAR_EAT) {
        self.bvScore.text = [NSString stringWithFormat:@"%d%%", (int)eatScore];
        self.bvGoal.text = [NSString stringWithFormat:@"TODAY'S GOAL: EAT 3 VEGGIES"];
        self.bvTitle.text = [NSString stringWithFormat:@"EAT"];
    }
#endif
    // Which activity needs the most attention?
    float minscore = moveScore;
    MDBgImageKind bgImgKind = MD_BG_IMAGE_MOVE;

    if (minscore > sleepScore) {
        minscore = sleepScore;
        bgImgKind = MD_BG_IMAGE_SLEEP;
    }
    if (minscore > eatScore) {
        minscore = eatScore;
        bgImgKind = MD_BG_IMAGE_EAT;
    }
    // Change background to match activity requiring most attention
    if (curBGImgKind != bgImgKind) {
        curBGImgKind = bgImgKind;
        if (curBGImgKind == MD_BG_IMAGE_MOVE) {
            self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"md_move_bg.png"]];
            self.tableView.backgroundView.contentMode = UIViewContentModeBottom;
            
        }
        if (curBGImgKind == MD_BG_IMAGE_SLEEP) {
            self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"md_sleep_bg.png"]];
            self.tableView.backgroundView.contentMode = UIViewContentModeBottom;
            
        }
        if (curBGImgKind == MD_BG_IMAGE_EAT) {
            self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"md_eat_bg.png"]];
            self.tableView.backgroundView.contentMode = UIViewContentModeBottom;
           
        }
    }
    
    self.svScore.text = [NSString stringWithFormat:@"%d", (int)(moveScore + sleepScore + eatScore)];

    // Date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    self.svDate.text = [dateFormatter stringFromDate:[NSDate date]];

    // Greeting
    self.svGreeting.text = [NSString stringWithFormat:@"%@'s health score", [settings objectForKey:@"name"]];

    // Cups of water left to drink today
    self.svWaterLeft.text = [NSString stringWithFormat:@"%d", self.eatEngine.todayWaterLeft];

    // Veggies left to eat today
    self.svVeggieLeft.text = [NSString stringWithFormat:@"%d", self.eatEngine.todayVeggieLeft];

    // Star number
    self.svStars.text = [NSString stringWithFormat:@"%d", stars];

    [self.eatScoreBarView setNeedsDisplay];
    [self.moveScoreBarView setNeedsDisplay];
    self.bvScore.text = [NSString stringWithFormat:@"%d%%", (int)eatScore];
    [self.bvScore setNeedsDisplay];
    // TODO
    // custom view for bar graphs
    //XX swipe gesture over button
    //XX label hgraph for tracking each catagory
    // add notification 
    
    // mockup menu (device agnostic, goals, share w/ doctor)
    // mockup social (loved one's view w/ chat, share)
}

- (void)refresh {
    // TODO
    // refresh data from data processing engine.
    // Can be called explicitly or triggered by pulldown gesture

    // HACK, reset water, veggie counters
    self.eatEngine.todayWaterLeft = 8;
    self.eatEngine.todayVeggieLeft = 3;

    
    // NSLog(@"Refresh");
    // call into data processing engines to refresh
    [self update];
    
    // Done with refresh
    [self.refreshControl endRefreshing];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // TODO
    // settings
    settings = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"John", @"name", @"hgraph", @"displaymode", @"Fitbit", @"tracking device", @"yes", @"sharing", nil];
    stars = 0;
    
    // Size screen for iphone4/5
    CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
    if (iOSDeviceScreenSize.height == 480)
    {
        self.scoreView.frame = CGRectMake(0,0,320,480);
    }
    if (iOSDeviceScreenSize.height == 568)
    {
        self.scoreView.frame = CGRectMake(0,0,320,568);
    }
    
    // set background image
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"md_sleep_bg.png"]];
    self.tableView.backgroundView.contentMode = UIViewContentModeBottom;

    // add refresh control
    // self.refreshControl = (id)[[ISRefreshControl alloc] init];
    self.refreshControl = (id)[[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(refresh)
                  forControlEvents:UIControlEventValueChanged];
    

    // initialize engines to refresh data
    self.moveEngine = [[MDMoveEngine alloc] initWithDelegate:self];
    self.eatEngine = [[MDEatEngine alloc] initWithDelegate:self];
    self.sleepEngine = [[MDSleepEngine alloc] initWithDelegate:self];


    [self update];
    [self hideAllGraphs];
    [self unhideBarMove];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

#if 0
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return MD_NUM_ROWS;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MDCell";
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    MDThirdCustomTableViewCell *cell = (MDThirdCustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        // cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell = [[MDThirdCustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
             
    }

    // set title
#if 1
    NSLog(@"Tableview cell row %d", indexPath.row);
    if  (indexPath.row == 0) {
        cell.activityTitle.text = @"MOVE";
        cell.activityLevel.text = [NSString stringWithFormat:@"%d", (int)moveScore];
    }
    if  (indexPath.row == 1) {
        cell.activityTitle.text = @"EAT";
        cell.activityLevel.text = [NSString stringWithFormat:@"%d", (int)eatScore];

    }
    if  (indexPath.row == 2) {
        cell.activityTitle.text = @"SLEEP";
        cell.activityLevel.text = [NSString stringWithFormat:@"%d", (int)sleepScore];

    }
#endif

    return cell;
}
#endif
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize iOSDeviceScreenSize = [[UIScreen mainScreen] bounds].size;
    if (iOSDeviceScreenSize.height == 480)
    {
        return 480;
    }
    if (iOSDeviceScreenSize.height == 568)
    {
        return 568;
    }
    return 480;
}

- (void)doRevealStar:(NSTimer *)timer  {
    self.svStars.hidden = NO;
}

- (void)revealStar {
    [NSTimer scheduledTimerWithTimeInterval:0.8f target:self selector:@selector(doRevealStar:) userInfo:nil repeats:NO];
}

- (void)doStarShine:(NSTimer *)timer  {
    self.svStars.hidden = YES;

    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    
    CAKeyframeAnimation *anim;
    anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    anim.values = [NSArray arrayWithObjects:
                   [NSNumber numberWithFloat:1.0],
                   [NSNumber numberWithFloat:1.0],
                   [NSNumber numberWithFloat:2.0],
                   nil];
    // this is key times expressed as fraction of total duration (total being 1.0)
    anim.keyTimes = [NSArray arrayWithObjects:
                     [NSNumber numberWithFloat:0.0],
                     [NSNumber numberWithFloat:0.6],
                     [NSNumber numberWithFloat:1.0],
                     nil];
    
    anim.duration = 0.8f;
    anim.repeatCount = 0;
    anim.autoreverses = NO;
    anim.removedOnCompletion = YES;
    
    CAKeyframeAnimation *updownAnimation;
    updownAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    updownAnimation.duration = 0.8;
    updownAnimation.repeatCount = 0;
    updownAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0],
                              [NSNumber numberWithFloat:-120],
                              [NSNumber numberWithFloat:-120],
                              nil];
    // this is key times expressed as fraction of total duration (total being 1.0)
    updownAnimation.keyTimes = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:0.0],
                                [NSNumber numberWithFloat:0.3],
                                [NSNumber numberWithFloat:1.0],
                                nil];
    
    updownAnimation.removedOnCompletion = YES;
    
    CAKeyframeAnimation *rotation;
    rotation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotation.values = [NSArray arrayWithObjects:
                       [NSNumber numberWithFloat:0],
                       [NSNumber numberWithFloat:0],
                       [NSNumber numberWithFloat:0],
                       [NSNumber numberWithFloat:6*M_PI],
                       nil];
    rotation.keyTimes = [NSArray arrayWithObjects:
                         [NSNumber numberWithFloat:0.0],
                         [NSNumber numberWithFloat:0.3],
                         [NSNumber numberWithFloat:0.6],
                         [NSNumber numberWithFloat:1.0],
                         nil];
    rotation.duration = 0.8f;
    rotation.repeatCount = 0;
    rotation.autoreverses = NO;
    rotation.removedOnCompletion = YES;
    
    animGroup.animations = [NSArray arrayWithObjects:anim, updownAnimation, rotation, nil];
    animGroup.delegate = self.svStarImg;
    animGroup.fillMode = kCAFillModeForwards;
    animGroup.removedOnCompletion = YES;
    animGroup.duration = 0.8;
    
    [[self.svStarImg layer] addAnimation:animGroup forKey:nil];
    stars++;
    [self update];
    [self revealStar];
}

- (void)starShine {
    [NSTimer scheduledTimerWithTimeInterval:1.6f target:self selector:@selector(doStarShine:) userInfo:nil repeats:NO];
}


- (void)doRevealVeggieLeft:(NSTimer *)timer  {
    self.svVeggieLeft.hidden = NO;
}

- (void)revealVeggieLeft {
    [NSTimer scheduledTimerWithTimeInterval:0.8f target:self selector:@selector(doRevealVeggieLeft:) userInfo:nil repeats:NO];
}

- (void)doRevealWaterLeft:(NSTimer *)timer  {
    self.svWaterLeft.hidden = NO;
}

- (void)revealWaterLeft {
    [NSTimer scheduledTimerWithTimeInterval:0.8f target:self selector:@selector(doRevealWaterLeft:) userInfo:nil repeats:NO];
}

- (IBAction)veggieConsumed:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded");
        //Do Whatever You want on End of Gesture
    }
    else if (sender.state == UIGestureRecognizerStateBegan){
        NSLog(@"UIGestureRecognizerStateBegan.");
        //Do Whatever You want on Began of Gesture
        NSLog(@"Handle long press gesture");
        if (self.eatEngine.todayVeggieLeft <= 0) {
            self.eatEngine.todayVeggieLeft = 0;
            [self update];
            return;
        }
        self.eatEngine.todayVeggieLeft--;
        // hide label, and display it later
        self.svVeggieLeft.hidden = YES;
        
        // give star when knocked veggie down to 0
        if (self.eatEngine.todayVeggieLeft == 0) {
            [self starShine];
        }
        
        CAAnimationGroup *animGroup = [CAAnimationGroup animation];
        
        CAKeyframeAnimation *anim;
        anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        anim.values = [NSArray arrayWithObjects:
                                  [NSNumber numberWithFloat:1.0],
                                  [NSNumber numberWithFloat:1.0],
                                  [NSNumber numberWithFloat:0.5],
                                  nil];
        // this is key times expressed as fraction of total duration (total being 1.0)
        anim.keyTimes = [NSArray arrayWithObjects:
                                    [NSNumber numberWithFloat:0.0],
                                    [NSNumber numberWithFloat:0.6],
                                    [NSNumber numberWithFloat:1.0],
                                    nil];
        
        anim.duration = 0.8f;
        anim.repeatCount = 0;
        anim.autoreverses = NO;
        anim.removedOnCompletion = YES;
        
        CAKeyframeAnimation *updownAnimation;
        updownAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
        updownAnimation.duration = 0.8;
        updownAnimation.repeatCount = 0;
        updownAnimation.values = [NSArray arrayWithObjects:
                                  [NSNumber numberWithFloat:0],
                                  [NSNumber numberWithFloat:-100],
                                  [NSNumber numberWithFloat:-100],
                                  nil];
        // this is key times expressed as fraction of total duration (total being 1.0)
        updownAnimation.keyTimes = [NSArray arrayWithObjects:
                                    [NSNumber numberWithFloat:0.0],
                                    [NSNumber numberWithFloat:0.3],
                                    [NSNumber numberWithFloat:1.0],
                                    nil];
        
        updownAnimation.removedOnCompletion = YES;
        
        CAKeyframeAnimation *rotation;
        rotation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        
        rotation.values = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0],
                           [NSNumber numberWithFloat:0],
                           [NSNumber numberWithFloat:0],
                           [NSNumber numberWithFloat:6*M_PI],
                           nil];
        rotation.keyTimes = [NSArray arrayWithObjects:
                             [NSNumber numberWithFloat:0.0],
                             [NSNumber numberWithFloat:0.3],
                             [NSNumber numberWithFloat:0.6],
                             [NSNumber numberWithFloat:1.0],
                             nil];
        rotation.duration = 0.8f;
        rotation.repeatCount = 0;
        rotation.autoreverses = NO;
        rotation.removedOnCompletion = YES;
        
        animGroup.animations = [NSArray arrayWithObjects:anim, updownAnimation, rotation, nil];
        animGroup.delegate = self.svVeggieIcon;
        animGroup.fillMode = kCAFillModeForwards;
        animGroup.removedOnCompletion = YES;
        animGroup.duration = 0.8;
        
        [[self.svVeggieIcon layer] addAnimation:animGroup forKey:nil];
        [self update];
        [self revealVeggieLeft];
        
    }
}

- (IBAction)waterConsumed:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded");
        //Do Whatever You want on End of Gesture
    }
    else if (sender.state == UIGestureRecognizerStateBegan){
        NSLog(@"UIGestureRecognizerStateBegan.");
        //Do Whatever You want on Began of Gesture
        NSLog(@"Handle long press gesture");
        if (self.eatEngine.todayWaterLeft <= 0) {
            self.eatEngine.todayWaterLeft = 0;
            [self update];
            return;
        }
        self.eatEngine.todayWaterLeft--;
        self.svWaterLeft.hidden = YES;

        // give star when knocked water down to 0
        if (self.eatEngine.todayWaterLeft == 0) {
            [self starShine];
        }
        
        CABasicAnimation *anim = nil;
        CAAnimationGroup *animGroup = [CAAnimationGroup animation];

        anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        anim.fromValue = [NSNumber numberWithDouble:1.0f];
        anim.toValue = [NSNumber numberWithDouble:1.0f];
        anim.duration = 0.8f;
        anim.repeatCount = 0;
        anim.autoreverses = NO;
        anim.removedOnCompletion = YES;
 
        CAKeyframeAnimation *updownAnimation;
        updownAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
        updownAnimation.duration = 0.8;
        updownAnimation.repeatCount = 0;
        updownAnimation.values = [NSArray arrayWithObjects:
                                  [NSNumber numberWithFloat:0],
                                  [NSNumber numberWithFloat:-120],
                                  [NSNumber numberWithFloat:-120],
                                  nil];
        // this is key times expressed as fraction of total duration (total being 1.0)
        updownAnimation.keyTimes = [NSArray arrayWithObjects:
                                    [NSNumber numberWithFloat:0.0],
                                    [NSNumber numberWithFloat:0.3],
                                    [NSNumber numberWithFloat:1.0],
                                    nil];
        
        updownAnimation.removedOnCompletion = YES;

        CAKeyframeAnimation *rotation;
        rotation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
        
        rotation.values = [NSArray arrayWithObjects:
                           [NSNumber numberWithFloat:0],
                           [NSNumber numberWithFloat:0],
                           [NSNumber numberWithFloat:M_PI],
                           [NSNumber numberWithFloat:M_PI],
                           nil];
        rotation.keyTimes = [NSArray arrayWithObjects:
                             [NSNumber numberWithFloat:0.0],
                             [NSNumber numberWithFloat:0.3],
                             [NSNumber numberWithFloat:0.6],
                             [NSNumber numberWithFloat:1.0],
                             nil];
        rotation.duration = 0.8f;
        rotation.repeatCount = 0;
        rotation.autoreverses = NO;
        rotation.removedOnCompletion = YES;
        
        animGroup.animations = [NSArray arrayWithObjects:anim, updownAnimation, rotation, nil];
        animGroup.delegate = self.svWaterIcon;
        animGroup.fillMode = kCAFillModeForwards;
        animGroup.removedOnCompletion = YES;
        animGroup.duration = 0.8;
        
        [[self.svWaterIcon layer] addAnimation:animGroup forKey:nil];
        [self update];
        [self revealWaterLeft];
    }
}

- (void)hideAllGraphs {
    self.scoreHGraphView.hidden = YES;
    self.svScore.hidden = YES;
    // move
    self.moveScoreBarView.hidden = YES;
    
    self.bvTitle.hidden = YES;
    self.bvScore.hidden = YES;
    self.bvGoal.hidden = YES;

    // sleep
    
    // eat
    self.eatScoreBarView.hidden = YES;

}

- (void)unhideHGraph {
    self.scoreHGraphView.hidden = NO;
    self.svScore.hidden = NO;
}

- (void)unhideBarMove {
    self.moveScoreBarView.hidden = NO;
    self.bvTitle.hidden = NO;
    self.bvScore.hidden = NO;
    self.bvGoal.hidden = NO;

}

- (void)unhideBarSleep {
    
}

- (void)unhideBarEat {
    self.eatScoreBarView.hidden = NO;
    self.bvTitle.hidden = NO;
    self.bvScore.hidden = NO;
    self.bvGoal.hidden = NO;    
}


- (IBAction)summaryChartSwiped:(UISwipeGestureRecognizer *)sender {
    curGraphKind = (curGraphKind+1) % MD_NUM_GRAPH_KINDS;
    NSLog(@"Current graph kind is %d", curGraphKind);
    
    [self update];
    
    [self hideAllGraphs];
    
    if (curGraphKind == MD_HGRAPH_ALL) {
        [self unhideHGraph];
    }
    if (curGraphKind == MD_BAR_MOVE) {
        [self unhideBarMove];
    }
    if (curGraphKind == MD_BAR_EAT) {
        [self unhideBarSleep];
    }
    if (curGraphKind == MD_BAR_SLEEP) {
        [self unhideBarEat];
    }
}

@end
