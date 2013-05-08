//
//  MDThirdCustomTableViewController.m
//  HealthPath
//
//  Created by Dean Chen on 5/3/13.
//  Copyright (c) 2013 Dean Chen. All rights reserved.
//

#import "MDThirdCustomTableViewController.h"
#import "MDThirdCustomTableViewCell.h"
#import "ISRefreshControl.h"
#import "MDMoveEngine.h"
#import "MDEatEngine.h"
#import "MDSleepEngine.h"
#import "MDCustomScoreView.h"
#import "MDCustomSleepView.h"
#import "MDCustomCorrView.h"
#import "MDCustomEatView.h"
#import "MDCustomMoveView.h"


@interface MDThirdCustomTableViewController () {
    float eatScore;
    float sleepScore;
    float moveScore;
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

- (void)refresh {
    // TODO
    // refresh data from data processing engine.
    // Can be called explicitly or triggered by pulldown gesture

    // NSLog(@"Refresh");
    // call into data processing engines to refresh
    
    // Done with refresh
    [self.refreshControl endRefreshing];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // TODO
    // set background image
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"md_sleep_bg.png"]];
    self.tableView.backgroundView.contentMode = UIViewContentModeBottom;

    // add refresh control
    self.refreshControl = (id)[[ISRefreshControl alloc] init];
    [self.refreshControl addTarget:self
                            action:@selector(refresh)
                  forControlEvents:UIControlEventValueChanged];
    

    // initialize engines to refresh data
    self.moveEngine = [[MDMoveEngine alloc] initWithDelegate:self];
    self.eatEngine = [[MDEatEngine alloc] initWithDelegate:self];
    self.sleepEngine = [[MDSleepEngine alloc] initWithDelegate:self];

    eatScore = [self.eatEngine summary];
    sleepScore = [self.moveEngine summary];
    moveScore = [self.sleepEngine summary];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
#if 0
    // put placeholder
    UIImage *cellimage;
    
    cellimage = [UIImage imageNamed:@"gray_cell.png"];
    // cellimage = [UIImage imageNamed:[[self.upcomingList objectAtIndex:[indexPath row]] profileImg] ];
    cell.imageView.image = cellimage;
    // cell.imageView.frame = CGRectMake(0,0,320,200);
    cell.backgroundColor = [UIColor grayColor];
    // cell.textLabel.text = @"TEST";
    
    // cell.textLabel.text = [(NSDictionary *)[self.friendSettingDictList objectAtIndex:[indexPath row]] objectForKey:@"friendname"];
    
    // NSLog(@"Request to display %@", cell.textLabel.text );
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

@end
