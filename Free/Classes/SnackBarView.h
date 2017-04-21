//
//  SnackBarView.h
//  Free
//
//  Created by Anthony Fernandez on 01/02/2017.
//  Copyright © 2017 GENyUS. All rights reserved.
//

#import <UIKit/UIKit.h>



#pragma mark - Snack Bar View Completion Handler: Public interface

typedef void(^SnackBarCompletionHandler)();



#pragma mark - Snack Bar View: Public Interface

@interface SnackBarView : UIView

// Public API
+ (instancetype)snackBarWithTitle:(NSString *)title action:(NSString *)action completionHandler:(SnackBarCompletionHandler)completionHandler;

@end
