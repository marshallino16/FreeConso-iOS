//
//  CompletionHandler.h
//  Tisseo
//
//  Created by Junior on 19/09/16.
//  Copyright © 2016 GENyUS. All rights reserved.
//

#import <Foundation/Foundation.h>



// Progress handler
typedef void(^ProgressHandler)(float progress, BOOL *stop);

// Completion handler
typedef void(^CompletionHandler)(id result, NSError *error);

// Error builder
#define ERROR(errorCode) [NSError errorWithDomain:@"ApplicativeErrorDomain" code:errorCode userInfo:nil]
#define ERROR_WITH_USER_DETAILS(errorCode, details) [NSError errorWithDomain:@"ApplicativeErrorDomain" code:errorCode userInfo:@{@"details": details}]


