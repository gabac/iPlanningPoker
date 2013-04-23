//
//  PlanningPokerClient.m
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 22.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "PlanningPokerClient.h"

typedef enum
{
	ClientStateIdle,
	ClientStateLookingForServers,
	ClientStateConnecting,
	ClientStateConnected,
}
ClientState;

@implementation PlanningPokerClient

ClientState clientState;
NSString *serverPeerId;

- (id)init {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    clientState = ClientStateIdle;
    
    return self;
}

- (void)startLookingForServersWithSessionId:(NSString *)sessionId {
    
    NSAssert(clientState == ClientStateIdle, @"Wrong state!!");
    
    clientState = ClientStateLookingForServers;
    
    self.availableServers = [NSMutableArray arrayWithCapacity:kMaxAvailableServers];
    
    self.session = [[GKSession alloc] initWithSessionID:sessionId displayName:nil sessionMode:GKSessionModeClient];
    self.session.delegate = self;
    self.session.available = YES;
}

- (void)connectToServerWithPeerId:(NSString *)peerId {
    
    NSAssert(clientState == ClientStateLookingForServers, @"Wrong state!!");
    
    clientState = ClientStateConnecting;
    serverPeerId = peerId;
    
    [self.session connectToPeer:serverPeerId withTimeout:self.session.disconnectTimeout];
}

- (void)disconnectFromServer {
    
    NSAssert(clientState != ClientStateIdle, @"Wrong state");
    
    clientState = ClientStateIdle;
    
    [self.session disconnectFromAllPeers];
    self.session.available = FALSE;
    self.session.delegate = nil;
    self.session = nil;
    
    self.availableServers = nil;
    
    [self.delegate planningPokerClient:self disconnectedFromServer:serverPeerId];
    serverPeerId = nil;
}


#pragma mark - GKSessionDelegate

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
    NSLog(@"PlanningPokerServer: peer %@ changed state %d", peerID, state);
    
    //check the state
    switch(state) {
        case GKPeerStateAvailable:
            //New server available
            NSLog(@"GKPeerStateAvailable");
            
            NSAssert(clientState == ClientStateLookingForServers, @"Wrong state!!");
            
            if (![self.availableServers containsObject:peerID]) {
                [self.availableServers addObject:peerID];
                [self.delegate planningPokerClient:self serverBecameAvailable:peerID];
            }
            
            break;
        case GKPeerStateUnavailable:
            //Server is no longer available
            NSLog(@"GKPeerStateUnavailable");
            
            NSAssert(clientState == ClientStateLookingForServers, @"Wrong state!!");
            
            if ([self.availableServers containsObject:peerID]) {
                [self.availableServers removeObject:peerID];
                [self.delegate planningPokerClient:self serverBecameUnavailable:peerID];
            }
            
            break;
        case GKPeerStateConnected:
            //client is connected to server
            NSLog(@"GKPeerStateConnected");
            
            NSAssert(clientState == ClientStateConnecting, @"Wrong state!!");
            
            clientState = ClientStateConnected;
            
            break;
        case GKPeerStateDisconnected:
            NSLog(@"GKPeerStateDisconnected");
            
            NSAssert(clientState == ClientStateConnected, @"Wrong state!!");
            
            [self disconnectFromServer];
            
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
    
    NSAssert(clientState != ClientStateIdle, @"Wrong state!!");
    
    [self disconnectFromServer];
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error {
	NSLog(@"PlanningPokerServer: session failed %@", error);
}

@end
