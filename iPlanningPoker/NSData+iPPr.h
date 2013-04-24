//
//  NSData+iPPr.h
//  iPlanningPoker
//
//  Created by Cyril Gabathuler on 24.04.13.
//  Copyright (c) 2013 Cyril Gabathuler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (iPPr)

- (int)int32AtOffset:(size_t)offset;
- (short)int16AtOffset:(size_t)offset;
- (char)int8AtOffset:(size_t)offset;
- (NSString *)stringAtOffset:(size_t)offset bytesRead:(size_t *)amount;

@end
