//
//  PlanningPokerDeck.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 23.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "DataPacket.h"
#import "TeamMember.h"

#import <GameKit/GameKit.h>
#import <Foundation/Foundation.h>

@protocol PlanningPokerDeckDelegate;

@interface PlanningPokerDeck : NSObject<GKSessionDelegate>

@property (weak, nonatomic) id<PlanningPokerDeckDelegate> delegate;
@property (strong, nonatomic) GKSession *session;
@property (strong, nonatomic) NSMutableDictionary *teamMembers;

- (void)startPlanningWithSession:(GKSession *)session clients:(NSArray *)clients;
- (void)stopPlanningWithReason:(ErrorReason)errorReason;
- (void)receivedDataPacket:(DataPacket *)dataPacket fromTeamMember:(TeamMember *)teamMember;
- (void)sendDataPacketToAllPeers:(DataPacket *)dataPacket;
- (BOOL)receivedResponsesFromAllTeamMember;
- (void)beginPlanningPoker;

@end

@protocol PlanningPokerDeckDelegate <NSObject>

- (void)stopPlanning:(PlanningPokerDeck *)cards withReason:(ErrorReason)errorReason;
- (void)connectionEstablished;
- (void)displayChoosenCards;
- (void)disconnectedTeamMember:(TeamMember *)teamMeamber;


@end
