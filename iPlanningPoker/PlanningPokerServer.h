//
//  PlanningPokerServer.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 22.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import <GameKit/GameKit.h>
#import <Foundation/Foundation.h>

@interface PlanningPokerServer : NSObject<GKSessionDelegate>

@property (assign, nonatomic) int maxClients;
@property (strong, nonatomic) NSArray *connectedClients;
@property (strong, nonatomic) GKSession *session;

- (void)startBroadcastingForSessionId:(NSString *)sessionId;

@end
