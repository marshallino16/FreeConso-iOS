//
//  ConsoManager.m
//  Free
//
//  Created by Anthony Fernandez on 28/03/2017.
//  Copyright © 2017 GENyUS. All rights reserved.
//

#import "ConsoManager.h"
#import "ConsoStore.h"
#import "Conso.h"


#pragma mark - Conso Manager: Implementation

@implementation ConsoManager

SYNTHESIZE_SINGLETON_FOR_CLASS(ConsoManager, sharedManager);


- (void)fetchAllConsoInfosWithCompletionHandler:(CompletionHandler)completionHandler login:(NSString *)login password:(NSString *)password {
    
    [[ConsoStore sharedStore] fetchAllConsoInfosWithCompletionHandler:completionHandler login:login password:password];
}

@end
