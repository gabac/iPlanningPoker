//
//  NSMutableData+iPPr.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 24.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableData (iPPr)

- (void)appendInt32:(int)value;
- (void)appendInt16:(int)value;
- (void)appendInt8:(int)value;
- (void)appendString:(NSString *)value;

@end
