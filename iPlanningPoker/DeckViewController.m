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

NSArray *choosingCards;
NSArray *choosenCards;
NSArray *teamMemberNames;
NSArray *teamMemberValues;
NSMutableArray *membersPositions;
int sizeOfTeam;

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
    
    choosingCards = [NSArray arrayWithObjects:self.choosingCard1, self.choosingCard2, self.choosingCard3, self.choosingCard4, self.choosingCard5, self.choosingCard6, self.choosingCard7, self.choosingCard8, nil];
    
    choosenCards = [NSArray arrayWithObjects:self.choosenCard1, self.choosenCard2, self.choosenCard3, self.choosenCard4, self.choosenCard5, self.choosenCard6, self.choosenCard7, self.choosenCard8,nil];
    
    teamMemberNames = [NSArray arrayWithObjects:self.teamMemberLabel1, self.teamMemberLabel2, self.teamMemberLabel3, self.teamMemberLabel4, self.teamMemberLabel5, self.teamMemberLabel6, self.teamMemberLabel7, self.teamMemberLabel8, nil];
    
    teamMemberValues = [NSArray arrayWithObjects:self.teamMemberValue1, self.teamMemberValue2, self.teamMemberValue3, self.teamMemberValue4, self.teamMemberValue5, self.teamMemberValue6, self.teamMemberValue7, self.teamMemberValue8,nil];
    
    sizeOfTeam = [self.deck.teamMembers count];
    
    membersPositions = [NSMutableArray array];
    
    [self.deck.teamMembers enumerateKeysAndObjectsUsingBlock:^(id key, TeamMember *obj, BOOL *stop) {
        [membersPositions addObject:obj];
    }];
    
    
    for(int i = 0; i < sizeOfTeam; i++) {
        UIImageView *choosingCard = [choosingCards objectAtIndex:i];
        UILabel *label = [teamMemberNames objectAtIndex:i];
        
        choosingCard.hidden = FALSE;
        label.hidden = FALSE;
        label.text = ((TeamMember *)[membersPositions objectAtIndex:i]).name;
    }
}

- (IBAction)pressedExitButton:(id)sender {
    
    [self.deck stopPlanningWithReason:ErrorReasonUserQuits];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - PlanningPokerDeckDelegate methods

- (void)disconnectedTeamMember:(TeamMember *)teamMeamber {
    NSLog(@"disconnected team member with peerid %@", teamMeamber.peerID);
}

- (void)displayChoosenCards {
    
    for(int i = 0; i < sizeOfTeam; i++) {
        UIImageView *choosingCard = [choosingCards objectAtIndex:i];
        UIImageView *choosenCard = [choosenCards objectAtIndex:i];
        UILabel *value = [teamMemberValues objectAtIndex:i];
        
        choosingCard.hidden = TRUE;
        
        choosenCard.hidden = FALSE;
        value.text = ((TeamMember *)[membersPositions objectAtIndex:i]).cardValue;
        value.hidden = FALSE;
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
