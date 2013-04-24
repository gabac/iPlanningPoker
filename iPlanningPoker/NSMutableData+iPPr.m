//
//  NSMutableData+iPPr.m
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 24.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import "NSMutableData+iPPr.h"

@implementation NSMutableData (iPPr)

- (void)appendInt32:(int)value {
    value = htonl(value);
    [self appendBytes:&value length:4];
}

- (void)appendInt16:(int)value {
    value =htons(value);
    [self appendBytes:&value length:2];
}

- (void)appendInt8:(int)value {
    [self appendBytes:&value length:1];
}

- (void)appendString:(NSString *)value {
    const char *charValue = [value UTF8String];
    [self appendBytes:charValue length:strlen(charValue) + 1];
}

@end
