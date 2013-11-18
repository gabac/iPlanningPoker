//
//  PlanningPokerCardsTest.m
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 06.11.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PlanningPokerCards.h"
#import "DataPacket.h"

//PlanningPokerCardsWaitingForSignIn,
//PlanningPokerCardsWaitingForReady,
//PlanningPokerCardsChooseCardValue,
//PlanningPokerCardsWaitingForNextRound,
//PlanningPokerCardsStopping

@interface PlanningPokerCardsTest : XCTestCase

@property (strong, nonatomic) PlanningPokerCards *cards;

@end

@implementation PlanningPokerCardsTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    self.cards = [[PlanningPokerCards alloc] init];
    self.cards.serverPeerId = @"mock";
    
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testPlanningPokerCardsWaitingForSignIn
{
    XCTAssertNotNil(self.cards);
    
    [self joinSession];
    
    XCTAssertEqual([self.cards getState], PlanningPokerCardsWaitingForSignIn, @"Cards should wait for sign in");
}

- (void)testPlanningPokerCardsWaitingForReady
{
    XCTAssertNotNil(self.cards);
    
    [self signIn];
    
    XCTAssertEqual([self.cards getState], PlanningPokerCardsWaitingForReady, @"Cards should wait for sign in");
}

- (void)testPlanningPokerCardsChooseCardValue
{
    XCTAssertNotNil(self.cards);
    
    [self signIn];
    [self sendCardValue];
    
    XCTAssertEqual([self.cards getState], PlanningPokerCardsChooseCardValue, @"Cards should wait for sign in");
    
    XCTAssertNoThrow([self.cards sendCardValueToServer:@"test"], @"should be able to send card value");
}

- (void)testPlanningPokerCardsWaitingForNextRound
{
    XCTAssertNotNil(self.cards);
    
    [self signIn];
    [self sendCardValue];
    
    DataPacket *dataPacket = [DataPacket dataPacketWithType:DataPacketTypeShowingCardValues];
    [self.cards receivedDataPacket:dataPacket];
    
    XCTAssertEqual([self.cards getState], PlanningPokerCardsWaitingForNextRound, @"Cards should wait for sign in");
}

- (void)joinSession {
    [self.cards joinPlanningWithSession:nil];
}

- (void)signIn {
    [self joinSession];
    
    DataPacket *dataPacket = [DataPacket dataPacketWithType:DataPacketTypeSignInRequest];
    [self.cards receivedDataPacket:dataPacket];
}

- (void)sendCardValue {
    DataPacket *dataPacket = [DataPacket dataPacketWithType:DataPacketTypeServerReady];
    [self.cards receivedDataPacket:dataPacket];
}

@end
