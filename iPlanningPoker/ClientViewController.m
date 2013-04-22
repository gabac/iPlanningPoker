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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.client.availableServers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *peerId = [self.client.availableServers objectAtIndex:indexPath.row];
    NSString *serverName = [self.client.session displayNameForPeer:peerId];
    
    cell.textLabel.text = serverName;
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
