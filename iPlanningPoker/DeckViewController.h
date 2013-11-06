//
//  DeckViewController.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 06.11.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "PlanningPokerDeck.h"
#import "TeamMember.h"

#import <UIKit/UIKit.h>

@interface DeckViewController : UIViewController<PlanningPokerDeckDelegate>

@property (weak, nonatomic) IBOutlet UIButton *exitButton;
@property (weak, nonatomic) IBOutlet UIImageView *choosingCard1;
@property (weak, nonatomic) IBOutlet UIImageView *choosingCard2;
@property (weak, nonatomic) IBOutlet UIImageView *choosingCard3;
@property (weak, nonatomic) IBOutlet UIImageView *choosingCard4;
@property (weak, nonatomic) IBOutlet UIImageView *choosingCard5;
@property (weak, nonatomic) IBOutlet UIImageView *choosingCard6;
@property (weak, nonatomic) IBOutlet UIImageView *choosingCard7;
@property (weak, nonatomic) IBOutlet UIImageView *choosingCard8;
@property (weak, nonatomic) IBOutlet UILabel *teamMemberLabel1;
@property (weak, nonatomic) IBOutlet UILabel *teamMemberLabel2;
@property (weak, nonatomic) IBOutlet UILabel *teamMemberLabel3;
@property (weak, nonatomic) IBOutlet UILabel *teamMemberLabel4;
@property (weak, nonatomic) IBOutlet UILabel *teamMemberLabel5;
@property (weak, nonatomic) IBOutlet UILabel *teamMemberLabel6;
@property (weak, nonatomic) IBOutlet UILabel *teamMemberLabel7;
@property (weak, nonatomic) IBOutlet UILabel *teamMemberLabel8;


@property (strong,nonatomic) PlanningPokerDeck *deck;

@end
