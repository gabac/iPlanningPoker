//
//  DeckViewController.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 06.11.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "PlanningPokerDeck.h"

#import <UIKit/UIKit.h>

@interface DeckViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *exitButton;

@property (strong,nonatomic) PlanningPokerDeck *deck;

@end
