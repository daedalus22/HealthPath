//
//  MDFirstViewController.m
//  HealthPath
//
//  Created by Dean Chen on 5/3/13.
//  Copyright (c) 2013 Dean Chen. All rights reserved.
//

#import "MDFirstViewController.h"
#import "MDAppDelegate.h"

@interface MDFirstViewController ()

@end

@implementation MDFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // MDAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
#if 0

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Device ID"
                                                    message:[NSString stringWithFormat:@"%@", appDelegate.deviceToken]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    alert = nil;
#endif
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
