//
//  ConsoManager.h
//  Free
//
//  Created by Anthony Fernandez on 28/03/2017.
//  Copyright © 2017 GENyUS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthetizeSingleton.h"
#import "CompletionHandler.h"



#pragma mark - Conso Manager: Public Interface

@interface ConsoManager : NSObject

// Lifecycle
+ (ConsoManager *)sharedManager;

// Public API
- (void)fetchAllConsoInfosWithCompletionHandler:(CompletionHandler)completionHandler login:(NSString *)login password:(NSString *)password;

@end
