//
//  ViewController.m
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 22.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pressedSetupNewRoundButton:(id)sender {
    NSLog(@"pressedSetupNewRoundButton");
    
    HostViewController *hostViewController = [[HostViewController alloc] initWithNibName:@"HostViewController_iPad" bundle:nil];
    
    [self presentViewController:hostViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
