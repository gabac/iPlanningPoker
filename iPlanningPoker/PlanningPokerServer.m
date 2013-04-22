//
//  PlanningPokerServer.m
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 22.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "PlanningPokerServer.h"

@implementation PlanningPokerServer

- (void)startBroadcastingForSessionId:(NSString *)sessionId {
    
    self.connectedClients = [NSMutableArray arrayWithCapacity:self.maxClients];
    
    self.session = [[GKSession alloc] initWithSessionID:sessionId displayName:nil sessionMode:GKSessionModeServer];
    self.session.delegate = self;
    self.session.available = YES;
}


#pragma mark - GKSessionDelegate
- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
    NSLog(@"PlanningPokerServer: peer %@ changed state %d", peerID, state);
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID {
	NSLog(@"PlanningPokerServer: receive connection request from peer %@", peerID);
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error {
    NSLog(@"PlanningPokerServer: connection with peer %@ failed %@", peerID, error);
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error {
	NSLog(@"PlanningPokerServer: session failed %@", error);
}


@end