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

@interface PlanningPokerClient : NSObject<GKSessionDelegate>

@property (strong, nonatomic) NSArray *availableServers;
@property (strong, nonatomic) GKSession *session;

- (void)startLookingForServersWithSessionId:(NSString *)sessionId;

@end
