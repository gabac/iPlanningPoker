//
//  PlanningPoker.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 23.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "DataPacket.h"

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@protocol PlanningPokerCardsDelegate;

@interface PlanningPokerCards : NSObject<GKSessionDelegate>

@property (weak, nonatomic) id<PlanningPokerCardsDelegate> delegate;
@property (strong, nonatomic) GKSession *session;
@property (strong, nonatomic) NSString *serverPeerId;

- (void)joinPlanningWithSession:(GKSession *)session;
- (void)leavePlanningWithReason:(ErrorReason)errorReason;
- (void)receivedDataPacket:(DataPacket *)dataPacket;
- (void)sendDataPacketToServer:(DataPacket *)dataPacket;
- (void)beginPlanningSession;

@end

@protocol PlanningPokerCardsDelegate <NSObject>

- (void)leavePlanning:(PlanningPokerCards *)cards withReason:(ErrorReason)errorReason;
- (void)connectionEstablished;

@end

