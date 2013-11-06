//
//  HostViewController.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 22.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "PlanningPokerServer.h"
#import "PlanningPokerDeck.h"

#import <UIKit/UIKit.h>

#define kSessionId @"iPlanningPoker"
#define kMaxClients 6

@protocol HostViewControllerDelegate;

@interface HostViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, PlanningPokerServerDelegate, PlanningPokerDeckDelegate>

@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UITableView *clientsTableView;
@property (strong, nonatomic) IBOutlet UIButton *startPlanningButton;

@property (strong, nonatomic) PlanningPokerServer *server;
@property (strong, nonatomic) PlanningPokerDeck *deck;
@property (weak, nonatomic) id<HostViewControllerDelegate> delegate;

@end

@protocol HostViewControllerDelegate <NSObject>

- (void)showDeckViewWithDeck:(PlanningPokerDeck *)deck;

@end
