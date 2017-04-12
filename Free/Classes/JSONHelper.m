//
//  JSONHelper.m
//  Tisseo
//
//  Created by Junior on 20/09/16.
//  Copyright © 2016 GENyUS. All rights reserved.
//

#import "JsonHelper.h"



#pragma mark - NSDictionary JSON Category: Implementation

@implementation NSDictionary (JSON)

// Public API

+ (NSDictionary *)dictionaryWithJsonData:(NSData *)data {
    // Parse data
    id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    // Check if data have been successfully parsed
    if (!result) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Could not parse data" userInfo:nil];
    }
    
    // Check if data is a dictionary
    if (![result isKindOfClass:[NSDictionary class]]) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Could not parse data as a dictionary" userInfo:nil];
    }
    
    // Result is a valid dictionary: return it
    return result;
}

- (NSDictionary *)dictionaryForKey:(NSString *)key {
    return [self objectForKey:key checkingAgainstClass:[NSDictionary class]];
}

- (NSArray *)arrayForKey:(NSString *)key {
    return [self objectForKey:key checkingAgainstClass:[NSArray class]];
}

- (NSString *)stringForKey:(NSString *)key {
    return [self objectForKey:key checkingAgainstClass:[NSString class]];
}

- (NSNumber *)numberForKey:(NSString *)key {
    return [self objectForKey:key checkingAgainstClass:[NSNumber class]];
}

- (NSData *)jsonData {
    return [NSJSONSerialization dataWithJSONObject:self options:0 error:NULL];
}



// Private method

- (id)objectForKey:(NSString *)key checkingAgainstClass:(Class)class {
    // Retrieve asked value
    id value = [self objectForKey:key];
    
    // If value is not present, then return nil
    if (value == nil) {
        return nil;
    }
    
    // If value is null, then return nil
    if (value == [NSNull null]) {
        return nil;
    }
    
    // If value is not of asked type, then throw exception
    if (![value isKindOfClass:class]) {
        NSString *reason = [NSString stringWithFormat:@"Value '%@' for key '%@' is not of class '%@'", value, key, class];
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
    }
    
    // Value is present, not null and of asked type: return it
    return value;
}

@end



#pragma mark - NSArray JSON Category: Implementation

@implementation NSArray (JSON)

// Public API

+ (NSArray *)arrayWithJsonData:(NSData *)data {
    // Parse data
    id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    // Check if data have been successfully parsed
    if (!result) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Could not parse data" userInfo:nil];
    }
    
    // Check if data is an array
    if (![result isKindOfClass:[NSArray class]]) {
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:@"Could not parse data as an array" userInfo:nil];
    }
    
    // Result is a valid array: return it
    return result;
}

- (NSDictionary *)dictionaryAtIndex:(NSUInteger)index {
    return [self objectAtIndex:index checkingAgainstClass:[NSDictionary class]];
}

- (NSArray *)arrayAtIndex:(NSUInteger)index {
    return [self objectAtIndex:index checkingAgainstClass:[NSArray class]];
}

- (NSString *)stringAtIndex:(NSUInteger)index {
    return [self objectAtIndex:index checkingAgainstClass:[NSString class]];
}

- (NSNumber *)numberAtIndex:(NSUInteger)index {
    return [self objectAtIndex:index checkingAgainstClass:[NSNumber class]];
}

- (NSData *)jsonData {
    return [NSJSONSerialization dataWithJSONObject:self options:0 error:NULL];
}



// Private method

- (id)objectAtIndex:(NSUInteger)index checkingAgainstClass:(Class)class {
    // Retrieve asked value
    id value = [self objectAtIndex:index];
    
    // Note: value can not be nil
    
    // If value is null, then return nil
    if (value == [NSNull null]) {
        return nil;
    }
    
    // If value is not of asked type, then throw exception
    if (![value isKindOfClass:class]) {
        NSString *reason = [NSString stringWithFormat:@"Value '%@' for index '%lu' is not of class '%@'", value, (unsigned long)index, class];
        @throw [NSException exceptionWithName:NSInvalidArgumentException reason:reason userInfo:nil];
    }
    
    // Value is present, not null and of asked type: return it
    return value;
}

@end
