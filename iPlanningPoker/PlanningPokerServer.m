//
//  PlanningPokerServer.m
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 22.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "PlanningPokerServer.h"

typedef enum
{
	ServerStateIdle,
	ServerStateStartAcceptingConnections,
	ServerStateStopAcceptingConnections,
}
ServerState;

@implementation PlanningPokerServer

ServerState serverState;

- (id)init {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    serverState = ServerStateIdle;
    
    return self;
}

- (void)startBroadcastingForSessionId:(NSString *)sessionId {
    
    NSAssert(serverState == ServerStateIdle, @"Wrong state!!");
    
    serverState = ServerStateStartAcceptingConnections;
    
    self.connectedClients = [NSMutableArray arrayWithCapacity:self.maxClients];
    
    self.session = [[GKSession alloc] initWithSessionID:sessionId displayName:nil sessionMode:GKSessionModeServer];
    self.session.delegate = self;
    self.session.available = YES;
}


#pragma mark - GKSessionDelegate
- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
    NSLog(@"PlanningPokerServer: peer %@ changed state %d", peerID, state);
    
    //check the state
    switch(state) {
        case GKPeerStateAvailable:
            NSLog(@"GKPeerStateAvailable");
            break;
        case GKPeerStateUnavailable:
            NSLog(@"GKPeerStateUnavailable");
            break;
        case GKPeerStateConnected:
            //Client has connected to server
            NSLog(@"GKPeerStateConnected");
            
            NSAssert(serverState == ServerStateStartAcceptingConnections, @"Wrong state!!");
            
            if(![self.connectedClients containsObject:peerID]) {
                
                [self.connectedClients addObject:peerID];
                [self.delegate planningPokerServer:self connectedToClient:peerID];
            }
            
            break;
        case GKPeerStateDisconnected:
            //Client has disconnected from server
            NSLog(@"GKPeerStateDisconnected");
            
            NSAssert(serverState == ServerStateIdle, @"Wrong state!!");
            
            if([self.connectedClients containsObject:peerID]) {

                [self.connectedClients removeObject:peerID];
                [self.delegate planningPokerServer:self disconnetedFromClient:peerID];
            }
            
            break;
        case GKPeerStateConnecting:
            NSLog(@"GKPeerStateConnecting");
            break;
    }
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID {
	NSLog(@"PlanningPokerServer: received connection request from peer %@", peerID);
    
    NSAssert(serverState == ServerStateStartAcceptingConnections, @"Wrong state!!");
    
    if([self.connectedClients count] < self.maxClients) {
        NSError *error;
        
        if([session acceptConnectionFromPeer:peerID error:&error]) {
            NSLog(@"Connection accepted from %@", peerID);
        } else {
            NSLog(@"Connection error from peer: %@ with error: %@", peerID, error);
        }
    } else {
        NSLog(@"Denied connection...too many devices");
    }
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error {
    NSLog(@"PlanningPokerServer: connection with peer %@ failed %@", peerID, error);
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error {
	NSLog(@"PlanningPokerServer: session failed %@", error);
}


@end
