//
//  NSArray+PMLArray.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/22.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (PMLArray)

- (nullable id)objectAtCheckedIndex:(NSInteger)index;

- (NSString *)stringAtCheckedIndex:(NSInteger)index;

@end

@interface NSMutableArray (PMLArray)

- (void)addCheckedObject:(id)object;

@end

@interface NSDictionary (PMLArray)

- (nullable id)objectForCheckedKey:(id)key;

- (NSString *)stringForCheckedKey:(id)key;

@end
