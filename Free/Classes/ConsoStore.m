//
//  BonjourMadameStore.m
//  Tisseo
//
//  Created by Junior on 19/09/16.
//  Copyright © 2016 GENyUS. All rights reserved.
//

#import "ConsoStore.h"
#import "SynthetizeSingleton.h"
#import "AFNetworking.h"
#import "JsonHelper.h"
#import "Conso.h"
#import "Bill.h"
#import "Configuration.h"




#pragma mark - Conso Store: Private interface

@interface ConsoStore ()

@end



#pragma mark - Conso Store Store: Implementation

@implementation ConsoStore

SYNTHESIZE_SINGLETON_FOR_CLASS(ConsoStore, sharedStore);


#pragma mark Public method: Conso infos retrieving

- (void)fetchAllConsoInfosWithCompletionHandler:(CompletionHandler)completionHandler login:(NSString *)login password:(NSString *)password {
    
    // Send request
    AFHTTPRequestOperationManager *requestOperationManager = [AFHTTPRequestOperationManager manager];
    [requestOperationManager GET:[self servicePoint]
                      parameters:@{@"usr": login, @"passwd": password}
                         success:^(AFHTTPRequestOperation *operation, NSDictionary *response) {
                             @try {
                                 
                                 // Handle result
                                 Conso *conso       = [[Conso alloc] init];
                                 conso.fullname     = [response stringForKey:@"fullname"];
                                 conso.forfait      = [response stringForKey:@"forfait"];
                                 conso.phoneNumber  = [response stringForKey:@"phone-number"];
                                 conso.consoFrom    = [response stringForKey:@"conso-from-date"];
                                 conso.consoTo      = [response stringForKey:@"conso-to-date"];
                                 
                                 NSDictionary *voice    = [response dictionaryForKey:@"voice"];
                                 conso.voiceConso       = [voice stringForKey:@"conso"];
                                 conso.voiceOverage     = [voice stringForKey:@"overage"];
                                 conso.voiceConsoInter  = [voice stringForKey:@"international"];
                                 
                                 NSDictionary *text     = [response dictionaryForKey:@"text"];
                                 conso.smsConso         = [text stringForKey:@"conso-sms"];
                                 conso.smsOverage       = [text stringForKey:@"overage-sms"];
                                 conso.mmsConso         = [text stringForKey:@"conso-mms"];
                                 conso.mmsOverage       = [text stringForKey:@"overage-mms"];
                                 
                                 NSDictionary *data     = [response dictionaryForKey:@"data"];
                                 conso.dataPercent      = [[data valueForKey:@"conso-percent"] doubleValue];
                                 conso.dataConso        = [data stringForKey:@"conso"];
                                 conso.dataConsoLeft    = [data stringForKey:@"conso-left"];
                                 conso.DataConsoOverage = [data stringForKey:@"overage"];
                                 
                                 NSArray *bills                 = [response arrayForKey:@"bills"];
                                 NSMutableArray *billsObject    = [NSMutableArray array];
                                 for (NSDictionary *billDictionary in bills) {
                                     
                                     Bill *billObject           = [[Bill alloc] init];
                                     
                                     billObject.downloadURL     = [billDictionary stringForKey:@"url"];
                                     billObject.price           = [billDictionary stringForKey:@"price"];
                                     billObject.date            = [billDictionary stringForKey:@"date"];
                                     
                                     [billsObject addObject:billObject];
                                 }
                                 
                                 conso.bills = billsObject;
                                 
                                 completionHandler(conso, nil);
                             }
                             @catch (NSException *exception) {
                                 NSLog(@"Error: %@", exception);
                                 completionHandler(nil, nil);
                             }
                         }
                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                             NSLog(@"Error: %@", error);
                             completionHandler(nil, nil);
                         }
     ];
}




#pragma mark Private method: Endpoint

- (NSString *)servicePoint {
    return [NSString stringWithFormat:@"%@%@", BASE_URL, @"getConso"];
}

@end
