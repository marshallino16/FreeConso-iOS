//
//  BonjourMadameStore.h
//  Tisseo
//
//  Created by Junior on 19/09/16.
//  Copyright © 2016 GENyUS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CompletionHandler.h"



#pragma mark - Conso Store: Public Interface

@interface ConsoStore : NSObject

// Lifecycle
+ (ConsoStore *)sharedStore;

// Public API
- (void)fetchAllConsoInfosWithCompletionHandler:(CompletionHandler)completionHandler login:(NSString *)login password:(NSString *)password;

@end
