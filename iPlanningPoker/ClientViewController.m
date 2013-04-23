//
//  ClientViewController.m
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 22.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "ClientViewController.h"

@interface ClientViewController ()

@end

@implementation ClientViewController

ErrorReason errorReason;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if (self.client == nil)
	{
        self.client = [[PlanningPokerClient alloc] init];
        self.client.delegate = self;
        
		self.clientNameTextField.placeholder = [[UIDevice currentDevice] name];
        
        errorReason = ErrorReasonNoError;
	}
}

-(void)showAlertView {
    
    NSAssert(errorReason != ErrorReasonNoError, @"Wrong state!");
    
    NSString *title = nil;
    NSString *message = nil;
    
    if(errorReason == ErrorReasonServerQuits) {
        title = NSLocalizedString(@"ch.stramash.iPlanningPoker.clientView.disconnected", nil);
        message = NSLocalizedString(@"ch.stramash.iPlanningPoker.clientView.disconnectedText", nil);
    } else if(errorReason == ErrorReasonNoNetworkCapabilities) {
        title = NSLocalizedString(@"ch.stramash.iPlanningPoker.clientView.noNetwork", nil);
        message = NSLocalizedString(@"ch.stramash.iPlanningPoker.clientView.dnoNetworkText", nil);
    }
    
    if(title && message) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"ch.stramash.iPlanningPoker.buttons.ok", nil)
                                                  otherButtonTitles:nil, nil];
        
        [alertView show];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return NO;
}

#pragma mark - Buttons
- (IBAction)pressedCancelButton:(id)sender {
    NSLog(@"Cancel button pressed");
    
    errorReason = ErrorReasonUserQuits;
    
	[self.client disconnectFromServer];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pressedStartConnectingButton:(id)sender {
    NSLog(@"Connecting button pressed");
    
    if (self.client == nil)
	{
        self.client = [[PlanningPokerClient alloc] init];
        self.client.delegate = self;
        
        errorReason = ErrorReasonNoError;
	}
    
    [self.client startLookingForServersWithSessionId:kSessionId andName:self.clientNameTextField.text];
    
    self.clientNameTextField.enabled = FALSE;
    self.startConnectingButton.enabled = FALSE;
    self.searchingServerLabel.text = NSLocalizedString(@"ch.stramash.iPlanningPoker.clientView.searchingServer", nil);
    self.searchingServerLabel.hidden = FALSE;
    self.searchingServerActivityIndicatorView.hidden = FALSE;
}

#pragma mark - PlanningPokerClient delegate

- (void)planningPokerClient:(PlanningPokerClient *)client serverBecameAvailable:(NSString *)peerId {
    
    NSString *serverName = [self.client.session displayNameForPeer:peerId];
    
    self.searchingServerLabel.text = [NSString stringWithFormat:NSLocalizedString(@"ch.stramash.iPlanningPoker.clientView.serverFound", nil), serverName];
    
    //Connect to server
    [self.client connectToServerWithPeerId:peerId];
}

- (void)planningPokerClient:(PlanningPokerClient *)client serverBecameUnavailable:(NSString *)peerId {
    self.searchingServerLabel.text = NSLocalizedString(@"ch.stramash.iPlanningPoker.clientView.searchingServer", nil);
}

- (void)planningPokerClient:(PlanningPokerClient *)client disconnectedFromServer:(NSString *)peerdId {
    self.client.delegate = nil;
    self.client = nil;
    
    [self showAlertView];

    self.clientNameTextField.enabled = TRUE;
    self.searchingServerLabel.text = nil;
    self.startConnectingButton.enabled = TRUE;
    self.searchingServerActivityIndicatorView.hidden = TRUE;
}

- (void)planningPokerClient:(PlanningPokerClient *)client withErrorReason:(ErrorReason)errorReasonFromDelegate {
    errorReason = errorReasonFromDelegate;
}

- (void)didConnectToServer {
    
    PlanningPokerCards *cards = [[PlanningPokerCards alloc] init];
    cards.delegate = self;
    
    [cards joinPlanningWithSession:self.client.session];
}

#pragma mark - PlanningPokerCardsDelegate methods

- (void)connectionEstablished {
    [self dismissViewControllerAnimated:NO completion:^{
        
        [self.delegate showCardsView];
        
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
