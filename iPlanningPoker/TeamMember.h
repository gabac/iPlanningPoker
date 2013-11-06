//
//  TeamMember.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 06.11.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeamMember : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *peerID;
@property (nonatomic, assign) BOOL receivedResponse;

@end
