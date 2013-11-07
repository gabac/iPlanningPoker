//
//  CardsViewController.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 06.11.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "PlanningPokerCards.h"

#import <UIKit/UIKit.h>

@protocol CardsViewControllerDelegate;

@interface CardsViewController : UIViewController<UITextFieldDelegate, PlanningPokerCardsDelegate>

@property (weak, nonatomic) IBOutlet UITextField *cardValue;
@property (weak, nonatomic) IBOutlet UIButton *sendValueButton;
@property (weak, nonatomic) IBOutlet UIButton *exitButton;

@property (strong, nonatomic) PlanningPokerCards *cards;

@end

@protocol CardsViewControllerDelegate <NSObject>


@end