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
        [self.client startLookingForServersWithSessionId:kSessionId];
        
		self.clientNameTextField.placeholder = self.client.session.displayName;
//        [self.availableServersTableView reloadData];
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
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)pressedStartConnectingButton:(id)sender {
    NSLog(@"Connecting button pressed");
    
    self.startConnectingButton.enabled = FALSE;
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
    
    //Delegate methods to inform other views?
    self.searchingServerLabel.text = NSLocalizedString(@"ch.stramash.iPlanningPoker.clientView.searchingServer", nil);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
