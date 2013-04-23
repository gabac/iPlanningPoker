//
//  ClientViewController.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 22.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "PlanningPokerClient.h"
#import "CardsViewController.h"
#import "PlanningPokerCards.h"

#import <UIKit/UIKit.h>

#define kSessionId @"iPlanningPoker"

@protocol ClientViewControllerDelegate;

@interface ClientViewController : UIViewController<UITextFieldDelegate, PlanningPokerClientDelegate, PlanningPokerCardsDelegate>

@property (strong, nonatomic) IBOutlet UITextField *clientNameTextField;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *startConnectingButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *searchingServerActivityIndicatorView;
@property (strong, nonatomic) IBOutlet UILabel *searchingServerLabel;

@property (strong, nonatomic) PlanningPokerClient *client;
@property (weak, nonatomic) id<ClientViewControllerDelegate> delegate;

@end

@protocol ClientViewControllerDelegate <NSObject>

- (void)showCardsView;

@end
