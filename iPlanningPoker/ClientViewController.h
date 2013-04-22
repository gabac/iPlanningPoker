//
//  ClientViewController.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 22.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "PlanningPokerClient.h"

#import <UIKit/UIKit.h>

#define kSessionId @"iPlanningPoker"

@interface ClientViewController : UIViewController<UITextFieldDelegate, PlanningPokerClientDelegate>

@property (strong, nonatomic) IBOutlet UITextField *clientNameTextField;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *startConnectingButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *searchingServerActivityIndicatorView;
@property (strong, nonatomic) IBOutlet UILabel *searchingServerLabel;

@property (strong, nonatomic) PlanningPokerClient *client;

@end
