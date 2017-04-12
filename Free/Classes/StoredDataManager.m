//
//  StoredDataManager.m
//  Free
//
//  Created by Anthony Fernandez on 31/03/2017.
//  Copyright © 2017 GENyUS. All rights reserved.
//

#import "StoredDataManager.h"




#pragma mark - Stored Data Manager: Implementation

@implementation StoredDataManager

SYNTHESIZE_SINGLETON_FOR_CLASS(StoredDataManager, sharedManager);



#pragma mark - Public API

- (BOOL)hasConnectedOneAccount {
    return ( [[NSUserDefaults standardUserDefaults] objectForKey:@"Account_Login"]
            && [[NSUserDefaults standardUserDefaults] objectForKey:@"Account_Password"]
            && [[NSUserDefaults standardUserDefaults] objectForKey:@"Account_Fullname"] );
}

- (void)storedAccountLogin:(NSString *)login {
    [[NSUserDefaults standardUserDefaults] setObject:login forKey:@"Account_Login"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)storedAccountPassword:(NSString *)password {
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"Account_Password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)storedAccountFullname:(NSString *)fullname {
    [[NSUserDefaults standardUserDefaults] setObject:fullname forKey:@"Account_Fullname"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)connectedAccountLogin {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"Account_Login"];
}

- (NSString *)connectedAccountPassword {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"Account_Password"];
}

- (NSString *)connectedAccountFullname {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"Account_Fullname"];
}

@end
