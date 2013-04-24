//
//  PlanningPokerDeck.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 23.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "DataPacket.h"

#import <GameKit/GameKit.h>
#import <Foundation/Foundation.h>

@protocol PlanningPokerDeckDelegate;

@interface PlanningPokerDeck : NSObject<GKSessionDelegate>

@property (weak, nonatomic) id<PlanningPokerDeckDelegate> delegate;
@property (strong, nonatomic) GKSession *session;

- (void)startPlanningWithSession:(GKSession *)session;
- (void)stopPlanningWithReason:(ErrorReason)errorReason;
- (void)sendDataPacketToallPeers:(DataPacket *)dataPacket;

@end

@protocol PlanningPokerDeckDelegate <NSObject>

- (void)stopPlanning:(PlanningPokerDeck *)cards withReason:(ErrorReason)errorReason;
- (void)connectionEstablished;


@end
