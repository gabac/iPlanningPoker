//
//  DeckViewController.m
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 06.11.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "DeckViewController.h"

@interface DeckViewController ()

@end

@implementation DeckViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)pressedExitButton:(id)sender {
    
    [self.deck stopPlanningWithReason:ErrorReasonUserQuits];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PlanningPokerDeckDelegate methods

- (void)disconnectedTeamMember:(TeamMember *)teamMeamber {
    NSLog(@"disconnected team member with peerid %@", teamMeamber.peerID);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
