//
//  MDThirdCustomTableViewCell.h
//  HealthPathBCBS
//
//  Created by Dean Chen on 5/6/13.
//  Copyright (c) 2013 Dean Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDCustomSleepView.h"

@interface MDThirdCustomTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *bgImg;
@property (strong, nonatomic) IBOutlet UILabel *activityTitle;
@property (strong, nonatomic) IBOutlet UILabel *activityLevel;
@property (strong, nonatomic) IBOutlet UIView *myView;

@end
