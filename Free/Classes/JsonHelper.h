//
//  JSONHelper.h
//  Free
//
//  Created by Junior on 20/09/16.
//  Copyright © 2016 GENyUS. All rights reserved.
//

#import <Foundation/Foundation.h>



#pragma mark - NSDictionary JSON Category: Public interface

@interface NSDictionary (JSON)

// Note: all methods may throw NSInvalidArgumentException if necessary

// Convenient method to parse JSON data
+ (NSDictionary *)dictionaryWithJsonData:(NSData *)data;

// Convenient methods to extract parsed data
- (NSDictionary *)dictionaryForKey:(NSString *)key;
- (NSArray *)arrayForKey:(NSString *)key;
- (NSString *)stringForKey:(NSString *)key;
- (NSNumber *)numberForKey:(NSString *)key;

// Convenient method to serialize to JSON format
- (NSData *)jsonData;

@end



#pragma mark - NSArray JSON Category: Public interface

@interface NSArray (JSON)

// Note: all methods may throw NSInvalidArgumentException if necessary

// Convenient method to parse JSON data
+ (NSArray *)arrayWithJsonData:(NSData *)data;

// Convenient methods to extract parsed data
- (NSDictionary *)dictionaryAtIndex:(NSUInteger)index;
- (NSArray *)arrayAtIndex:(NSUInteger)index;
- (NSString *)stringAtIndex:(NSUInteger)index;
- (NSNumber *)numberAtIndex:(NSUInteger)index;

// Convenient method to serialize to JSON format
- (NSData *)jsonData;

@end
