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

#pragma mark - Buttons

- (IBAction)pressedSetupNewRoundButtonPhone:(id)sender {
    NSLog(@"pressedSetupNewRoundButton iPhone");
    
    ClientViewController *clientViewController = [[ClientViewController alloc] initWithNibName:@"ClientViewController_iPhone" bundle:nil];
    clientViewController.delegate = self;
    
    [self presentViewController:clientViewController animated:YES completion:nil];
}

- (IBAction)pressedSetupNewRoundButtonPad:(id)sender {
    NSLog(@"pressedSetupNewRoundButton iPad");
    
    HostViewController *hostViewController = [[HostViewController alloc] initWithNibName:@"HostViewController_iPad" bundle:nil];
    [self presentViewController:hostViewController animated:YES completion:nil];
}

#pragma mark - ClientViewControllerDelegate methods

- (void)showCardsViewWithClient:(PlanningPokerClient *)client {
    
    CardsViewController *cardsViewController = [[CardsViewController alloc] init];
    
    [self presentViewController:cardsViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
