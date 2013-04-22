//
//  ClientViewController.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 22.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClientViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *clientNameTextField;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UITableView *availableServersTableView;

@end
