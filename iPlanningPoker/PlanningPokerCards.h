//
//  PlanningPoker.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 23.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@protocol PlanningPokerCardsDelegate;

@interface PlanningPokerCards : NSObject<GKSessionDelegate>

@property (weak, nonatomic) id<PlanningPokerCardsDelegate> delegate;
@property (strong, nonatomic) GKSession *session;

- (void)startPlanningWithSession:(GKSession *)session;
- (void)stopPlanningWithReason:(ErrorReason)errorReason;

@end

@protocol PlanningPokerCardsDelegate <NSObject>

- (void)stopPlanning:(PlanningPokerCards *)cards withReason:(ErrorReason)errorReason;
- (void)connectionEstablished;

@end

