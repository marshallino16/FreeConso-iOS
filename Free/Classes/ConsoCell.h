//
//  ConsoCellTableViewCell.h
//  Free
//
//  Created by Anthony Fernandez on 29/03/2017.
//  Copyright © 2017 GENyUS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Conso.h"



#pragma mark - Conso Cell: Public Interface

@interface ConsoCell : UITableViewCell

// Public API
- (void)updateWithConsoType:(ConsoType)consoType conso:(Conso *)conso;

@end
