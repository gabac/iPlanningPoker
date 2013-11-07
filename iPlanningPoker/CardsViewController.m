//
//  CardsViewController.m
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 06.11.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "CardsViewController.h"

@interface CardsViewController ()

@end

@implementation CardsViewController

ErrorReason errorReason;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)pressedSendValueButton:(id)sender {
    
    NSLog(@"send value %@", self.cardValue.text);
    
    [self.cards sendCardValueToServer:self.cardValue.text];
    
}

- (IBAction)pressedExitButton:(id)sender {
    
    [self.cards leavePlanningWithReason:ErrorReasonUserQuits];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)showAlertView {
    
    NSAssert(errorReason != ErrorReasonNoError, @"Wrong state!");
    
    NSString *title = nil;
    NSString *message = nil;
    
    if(errorReason == ErrorReasonServerQuits || errorReason == ErrorReasonConnectionDropped) {
        title = NSLocalizedString(@"ch.stramash.iPlanningPoker.clientView.disconnected", nil);
        message = NSLocalizedString(@"ch.stramash.iPlanningPoker.clientView.disconnectedText", nil);
    }
    
    if(title && message) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"ch.stramash.iPlanningPoker.buttons.ok", nil)
                                                  otherButtonTitles:nil, nil];
        
        [alertView show];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return FALSE;
}

#pragma marks - PlanningPokerCards delegates

- (void)leavePlanning:(PlanningPokerCards *)cards withReason:(ErrorReason)errorReasonFromDelegate {
    errorReason = errorReasonFromDelegate;
    [self showAlertView];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
