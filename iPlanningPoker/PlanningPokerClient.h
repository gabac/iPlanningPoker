//
//  PlanningPokerClient.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 22.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

#define kMaxAvailableServers 3

@protocol PlanningPokerClientDelegate;

@interface PlanningPokerClient : NSObject<GKSessionDelegate>

@property (strong, nonatomic) NSMutableArray *availableServers;
@property (strong, nonatomic) GKSession *session;

@property (weak, nonatomic) id<PlanningPokerClientDelegate> delegate;

- (void)startLookingForServersWithSessionId:(NSString *)sessionId;

@end


@protocol PlanningPokerClientDelegate <NSObject>

- (void)planningPokerClient:(PlanningPokerClient *)client serverBecameAvailable:(NSString *)peerId;
- (void)planningPokerClient:(PlanningPokerClient *)client serverBecameUnavailable:(NSString *)peerId;

@end
