//
//  ConsoCellTableViewCell.m
//  Free
//
//  Created by Anthony Fernandez on 29/03/2017.
//  Copyright © 2017 GENyUS. All rights reserved.
//

#import "ConsoCell.h"
#import "ViewHelper2.h"



#pragma mark - Conso Cell: Private Interface

@interface ConsoCell ()

@property (nonatomic, weak) IBOutlet UIView *containerView;
@property (nonatomic, weak) IBOutlet UILabel *tagLabel;
@property (nonatomic, weak) IBOutlet UILabel *consoLabel;
@property (nonatomic, weak) IBOutlet UILabel *overageLabel;

@end



#pragma mark - Conso Cell: Implementation

@implementation ConsoCell



#pragma mark Life Cycle

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Update selection style
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // View background
    [self.contentView setBackgroundColor:RGB(250.0, 250.0, 250.0)];
    
    //Create shadow path
    [ViewHelper2 generateShadowBoxWithView:self.containerView radius:2.0f offsetWidth:0.0f offsetHeight:2.0f opacity:0.7f color:RGB(208, 208, 209)];
    self.containerView.layer.borderWidth = 0.3f;
    self.containerView.layer.borderColor = [RGB(205, 205, 211) CGColor];
    
    self.tagLabel.layer.cornerRadius = 2.0f;
    self.tagLabel.translatesAutoresizingMaskIntoConstraints = YES;
}


#pragma mark - Public API

- (void)updateWithConsoType:(ConsoType)consoType conso:(Conso *)conso {
    
    if (consoType == ConsoTypeData) {
        self.tagLabel.text = @"DATA CONSO";
        self.tagLabel.backgroundColor = RGB(133, 194, 4);
        
        NSString *consoLeft = [NSString stringWithFormat:@"%@ left", NNIL(conso.dataConsoLeft)];
        self.consoLabel.text = NNIL(consoLeft);
        self.overageLabel.text = NNIL(conso.DataConsoOverage);
    }
    else if (consoType == ConsoTypeVoice) {
        self.tagLabel.text = @"VOICE CONSO";
        self.tagLabel.backgroundColor = RGB(98, 171, 227);
        
        self.consoLabel.text = NNIL(conso.voiceConso);
        self.overageLabel.text = NNIL(conso.voiceOverage);
    }
    else if (consoType == ConsoTypeSMS) {
        self.tagLabel.text = @"SMS CONSO";
        self.tagLabel.backgroundColor = RGB(229, 79, 135);
        
        self.consoLabel.text = NNIL(conso.smsConso);
        self.overageLabel.text = NNIL(conso.smsOverage);
    }
    else if (consoType == ConsoTypeMMS) {
        self.tagLabel.text = @"MMS CONSO";
        self.tagLabel.backgroundColor = RGB(79, 69, 67);
        
        self.consoLabel.text = NNIL(conso.mmsConso);
        self.overageLabel.text = NNIL(conso.mmsOverage);
    }
    else {
        self.tagLabel.text = @"Other";
        self.tagLabel.backgroundColor = RGB(230, 179, 76);
    }
    
    NSAttributedString *attributedNumberOfPrints = [ViewHelper2 attributedStringWithString:self.tagLabel.text font:self.tagLabel.font color:self.tagLabel.textColor alignment:self.tagLabel.textAlignment];
    CGFloat numberOfPrintsWidth = [ViewHelper2 widthForAttributedString:attributedNumberOfPrints constrainedToHeight:18];
    self.tagLabel.frame = CGRectMake(16, 16, numberOfPrintsWidth + 8, 18);
    [self.tagLabel layoutIfNeeded];
}

@end
