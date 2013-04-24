//
//  DataPacket.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 24.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "NSMutableData+iPPr.h"

#import <Foundation/Foundation.h>

typedef enum {
    DataPacketTypeSignInRequest = 0x64
} DataPacketType;

@interface DataPacket : NSObject

@property (assign, nonatomic) DataPacketType dataPacketType;

+ (id)dataPacketWithType:(DataPacketType)dataPacketType;
- (id)initWithType:(DataPacketType)dataPacketType;

- (NSData *)getDataPacketData;

@end
