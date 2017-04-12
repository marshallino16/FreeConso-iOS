//
//  PhotoPost.h
//  Tisseo
//
//  Created by Junior on 19/09/16.
//  Copyright © 2016 GENyUS. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    ConsoTypeBasic  = 1,
    ConsoTypeVoice  = 2,
    ConsoTypeSMS    = 3,
    ConsoTypeMMS    = 4,
    ConsoTypeData   = 5
} ConsoType;

@interface Conso : NSObject

// Basic properties
@property (strong) NSString *fullname;
@property (strong) NSString *forfait;
@property (strong) NSString *phoneNumber;
@property (strong) NSString *consoFrom;
@property (strong) NSString *consoTo;

// Voice properties
@property (strong) NSString *voiceConso;
@property (strong) NSString *voiceConsoInter;
@property (strong) NSString *voiceOverage;

// Text
@property (strong) NSString *smsConso;
@property (strong) NSString *smsOverage;
@property (strong) NSString *mmsConso;
@property (strong) NSString *mmsOverage;

// Data
@property (assign) double dataPercent;
@property (strong) NSString *dataConso;
@property (strong) NSString *dataConsoLeft;
@property (strong) NSString *DataConsoOverage;

@property (strong) NSArray *bills;


@end
