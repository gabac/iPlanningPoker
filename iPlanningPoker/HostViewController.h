//
//  HostViewController.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 22.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "PlanningPokerServer.h"

#import <UIKit/UIKit.h>

#define kSessionId @"iPlanningPoker"
#define kMaxClients 6

@interface HostViewController : UIViewController<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, PlanningPokerServerDelegate>

@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UITextField *hostNameTextField;
@property (strong, nonatomic) IBOutlet UITableView *clientsTableView;
@property (strong, nonatomic) IBOutlet UIButton *startPlanningButton;

@property (strong, nonatomic) PlanningPokerServer *server;

@end
