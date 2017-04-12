//
//  StoredDataManager.h
//  Free
//
//  Created by Anthony Fernandez on 31/03/2017.
//  Copyright © 2017 GENyUS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthetizeSingleton.h"




#pragma mark - Store Data Manager: Public Interface

@interface StoredDataManager : NSObject

// Lifecycle
+ (StoredDataManager *)sharedManager;

// Public API
- (BOOL)hasConnectedOneAccount;
- (void)storedAccountLogin:(NSString *)login;
- (void)storedAccountPassword:(NSString *)password;
- (void)storedAccountFullname:(NSString *)fullname;

- (NSString *)connectedAccountLogin;
- (NSString *)connectedAccountPassword;
- (NSString *)connectedAccountFullname;

@end
