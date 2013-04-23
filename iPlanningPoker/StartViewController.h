//
//  ViewController.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 22.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "HostViewController.h"
#import "ClientViewController.h"
#import "CardsViewController.h"

#import <UIKit/UIKit.h>

@interface StartViewController : UIViewController<ClientViewControllerDelegate, CardsViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *setupNewRoundButton;

@end
