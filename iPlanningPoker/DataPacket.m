//
//  DataPacket.m
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 24.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "DataPacket.h"

@implementation DataPacket

- (id)initWithType:(DataPacketType)dataPacketType {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.dataPacketType = dataPacketType;
    
    return self;

}

+ (id)dataPacketWithType:(DataPacketType)dataPacketType {
    return [[self alloc] initWithType:dataPacketType];
}

- (NSData *)getDataPacketData {
    NSMutableData *data = [[NSMutableData alloc] initWithCapacity:100];
    
    [data appendInt32:'iPPr']; //0x69505072
    [data appendInt32:0];
    [data appendInt16:self.dataPacketType];
    
    return data;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ :: dataType: %d", [super description], self.dataPacketType];
}

@end
