//
//  PlanningPokerCardsTest.m
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 06.11.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PlanningPokerCards.h"


@interface PlanningPokerCardsTest : XCTestCase

@end

@implementation PlanningPokerCardsTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    
    
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testExample
{
    PlanningPokerCards *planningPokerCards = [[PlanningPokerCards alloc] init];
    XCTAssertNotNil(planningPokerCards);
    
}

@end
