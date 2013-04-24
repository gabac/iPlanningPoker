//
//  PlanningPokerDeck.m
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 23.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "PlanningPokerDeck.h"

typedef enum {
    
    PlanningPokerDeckWaitingForSignIn,
    PlanningPokerDeckStopping
    
} PlanningPokerDeckState;


@implementation PlanningPokerDeck

PlanningPokerDeckState planningPokerDeckState;

#pragma mark - PlanningPokerDeck logic

- (void)startPlanningWithSession:(GKSession *)session {
    
    self.session = session;
    
    self.session.delegate = self;
    self.session.available = FALSE;
    
    [self.session setDataReceiveHandler:self withContext:nil];
    
    planningPokerDeckState = PlanningPokerDeckWaitingForSignIn;
    
    DataPacket *dataPacket = [DataPacket dataPacketWithType:DataPacketTypeSignInRequest];
    [self sendDataPacketToAllPeers:dataPacket];
}

- (void)stopPlanningWithReason:(ErrorReason)errorReason {
    
    planningPokerDeckState = PlanningPokerDeckStopping;
    
    [self.session disconnectFromAllPeers];
    self.session.delegate = nil;
    self.session = nil;
    
    [self.delegate stopPlanning:self withReason:errorReason];
}

#pragma mark - Networking

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context {
    NSLog(@"data received: %@ from peer: %@", [data description], peer);
    
    DataPacket *dataPacket = [DataPacket dataPacketWithData:data];
    
    if(!dataPacket) {
        NSLog(@"Illeagl data packet");
        return;
    }
    
    [self receivedDataPacket:dataPacket];
}

- (void)receivedDataPacket:(DataPacket *)dataPacket {
    
    switch(dataPacket.dataPacketType) {
        case DataPacketTypeSignInResponse: {
            NSAssert(planningPokerDeckState == PlanningPokerDeckWaitingForSignIn, @"Wrong state!!");
            
            NSLog(@"Sign in response from %@", [self.session displayNameForPeer:dataPacket.payload]);
            break;
        }
        default:
            NSLog(@"unexcpected packet type");
            break;
    }
}

- (void)sendDataPacketToAllPeers:(DataPacket *)dataPacket {
    
    NSError *error;
    
    if(![self.session sendDataToAllPeers:[dataPacket getDataPacketData] withDataMode:GKSendDataReliable error:&error]) {
        NSLog(@"Error sending Data to all peers: %@", error);
    }

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
