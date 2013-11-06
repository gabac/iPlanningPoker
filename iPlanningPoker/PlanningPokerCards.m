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
    PlanningPokerCardsWaitingForReady,
    PlanningPokerCardsChooseCardValue,
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

- (void)sendDataPacketToServer:(DataPacket *)dataPacket {
    
    NSError *error;
    
    if(![self.session sendData:[dataPacket getDataPacketData] toPeers:[NSArray arrayWithObject:self.serverPeerId] withDataMode:GKSendDataReliable error:&error]) {
        NSLog(@"Error sending Data to all peers: %@", error);
    }
    
}

- (void)receivedDataPacket:(DataPacket *)dataPacket {
    
    switch(dataPacket.dataPacketType) {
        case DataPacketTypeSignInRequest: {
            NSAssert(planningPokerCardsState == PlanningPokerCardsWaitingForSignIn, @"Wrong state!!");
            
            planningPokerCardsState = PlanningPokerCardsWaitingForReady;
            NSLog(@"Sign in request");
            
            DataPacket *dataPacketResponse = [DataPacket dataPacketWithType:DataPacketTypeSignInResponse];
            dataPacketResponse.payload = self.session.peerID;
            
            [self sendDataPacketToServer:dataPacketResponse];
            
            break;
        }
        case DataPacketTypeServerReady: {
            NSAssert(planningPokerCardsState == PlanningPokerCardsWaitingForReady, @"Wrong state!!");
            
            planningPokerCardsState = PlanningPokerCardsChooseCardValue;
            NSLog(@"Server ready");
            
            [self beginPlanningSession];
            
            break;
        }
        case DataPacketTypeServerQuit: {
            NSAssert(planningPokerCardsState != PlanningPokerCardsStopping, @"Wrong state!!");
            
            [self leavePlanningWithReason:ErrorReasonServerQuits];
            
            break;
        }
        default:
            NSLog(@"unexcpected packet type");
            break;
    }
}

- (void)beginPlanningSession {
    NSLog(@"begin planning session on client");
    
    [self.delegate connectionEstablished];
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
            
            NSAssert(planningPokerCardsState != PlanningPokerCardsStopping, @"Wrong state!!");
            [self leavePlanningWithReason:ErrorReasonConnectionDropped];
            
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
