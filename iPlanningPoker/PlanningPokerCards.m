//
//  PlanningPoker.m
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 23.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "PlanningPokerCards.h"

typedef enum {
    
  PlanningPokerCardsWaitingForSignIn,
  PlanningPokerCardsStopping
    
} PlanningPokerCardsState;

@implementation PlanningPokerCards

PlanningPokerCardsState planningPokerCardsState;

#pragma mark - PlanningPoker logic

- (void)joinPlanningWithSession:(GKSession *)session {
    
    self.session = session;
    
    self.session.delegate = self;
    self.session.available = FALSE;
    
    [self.session setDataReceiveHandler:self withContext:nil];
    
    planningPokerCardsState = PlanningPokerCardsWaitingForSignIn;
    
}

- (void)leavePlanningWithReason:(ErrorReason)errorReason {
    
    planningPokerCardsState = PlanningPokerCardsStopping;
    
    [self.session disconnectFromAllPeers];
    self.session.delegate = nil;
    self.session = nil;
    
    [self.delegate leavePlanning:self withReason:errorReason];
}

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context {
    
}

#pragma mark - GKSessionDelegate

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
    NSLog(@"PlanningPokerServer: peer %@ changed state %d", peerID, state);
    
    //check the state
    switch(state) {
        case GKPeerStateAvailable:
            //New server available
            NSLog(@"GKPeerStateAvailable");
            break;
        case GKPeerStateUnavailable:
            //Server is no longer available
            NSLog(@"GKPeerStateUnavailable");
            break;
        case GKPeerStateConnected:
            //client is connected to server
            NSLog(@"GKPeerStateConnected");
            break;
        case GKPeerStateDisconnected:
            NSLog(@"GKPeerStateDisconnected");
            break;
        case GKPeerStateConnecting:
            NSLog(@"GKPeerStateConnecting");
            break;
    }
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID {
	NSLog(@"PlanningPokerServer: received connection request from peer %@", peerID);
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error {
    NSLog(@"PlanningPokerServer: connection with peer %@ failed %@", peerID, error);
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error {
	NSLog(@"PlanningPokerServer: session failed %@", error);
}

@end
