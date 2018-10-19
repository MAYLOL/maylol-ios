//
//  NSArray+PMLArray.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/22.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "NSArray+PMLArray.h"

@implementation NSArray (PMLArray)

//检查index是否超过总大小
- (nullable id)objectAtCheckedIndex:(NSInteger)index
{
    if ([self count] <= index) {
        //        DLog(@"NSArray数据超过容量");
        return nil;
    }
    else if (index <= -1) {
        //        DLog(@"index 错误");
        return nil;
    }
    else
    {
        return [self objectAtIndex:index];
    }
}

- (NSString *)stringAtCheckedIndex:(NSInteger)index
{
    if ([self count] <= index) {
        //        DLog(@"NSArray数据超过容量");
        return @"";
    }
    else if (index <= -1) {
        //        DLog(@"index 错误");
        return @"";
    }
    else
    {
        return (NSString *)[self objectAtIndex:index];
    }
}

@end

@implementation NSMutableArray (PMLArray)

- (void)addCheckedObject:(id)object
{
    if (object != nil) {
        [self addObject:object];
    }
    else
    {
        NSLog(@"");
    }
}

@end

@implementation NSDictionary (PMLArray)

- (nullable id)objectForCheckedKey:(id)key
{
    id object_ = [self objectForKey:key];
    
    if ([object_ isKindOfClass:[NSNull class] ]) {
        return nil;
    }
    
    return object_;
}

- (NSString *)stringForCheckedKey:(id)key
{
    id object_ = [self objectForKey:key];
    
    if ([object_ isKindOfClass:[NSString class]]) {
        
        return object_;
    }
    
    if([object_ isKindOfClass:[NSNumber class]]) {
        
        return [object_ stringValue];
    }
    else
    {
        return @"";
    }
}

@end
