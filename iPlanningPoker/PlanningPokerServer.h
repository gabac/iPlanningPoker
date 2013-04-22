//
//  PlanningPokerServer.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 22.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import <GameKit/GameKit.h>
#import <Foundation/Foundation.h>

@protocol PlanningPokerServerDelegate;

@interface PlanningPokerServer : NSObject<GKSessionDelegate>

@property (assign, nonatomic) int maxClients;
@property (strong, nonatomic) NSMutableArray *connectedClients;
@property (strong, nonatomic) GKSession *session;

@property (weak, nonatomic) id<PlanningPokerServerDelegate> delegate;

- (void)startBroadcastingForSessionId:(NSString *)sessionId;

@end

@protocol PlanningPokerServerDelegate <NSObject>

- (void)planningPokerServer:(PlanningPokerServer *)server connectedToClient:(NSString *)peerId;
- (void)planningPokerServer:(PlanningPokerServer *)server disconnetedFromClient:(NSString *)peerId;

@end