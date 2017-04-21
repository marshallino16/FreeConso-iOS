//
//  SnackBarView.m
//  Free
//
//  Created by Anthony Fernandez on 01/02/2017.
//  Copyright © 2017 GENyUS. All rights reserved.
//

#import "SnackBarView.h"
#import "Configuration.h"
#import "ViewHelper2.h"


#define SNACK_BAR_HEIGHT            (44.0)
#define SNACK_BAR_PADDING           (16.0)

#define SNACK_BAR_SHORT_DURATION    (2.0)
#define SNACK_BAR_LONG_DURATION     (3.5)




#pragma mark - Snack Bar View: Private Interface

@interface SnackBarView ()

// Properties
@property (strong) NSString *title;
@property (strong) NSString *action;
@property (strong) UISwipeGestureRecognizer *swipeGestureRecognizer;
@property (nonatomic, copy) SnackBarCompletionHandler completionHandler;

// Views
@property (strong) UILabel *labelTitle;
@property (strong) NSMutableArray *buttonsActions;

@end




#pragma mark - Snack Bar View: Implementation

@implementation SnackBarView

- (instancetype)initWithTitle:(NSString *)title action:(NSString *)action completionHandler:(SnackBarCompletionHandler)completionHandler {
    CGRect snackBarFrame = CGRectMake(0, WINDOW.frame.size.height, WINDOW.frame.size.width, SNACK_BAR_HEIGHT);
    self = [super initWithFrame:snackBarFrame];
    if (self) {
        
        // Initialize frame
        self.frame = snackBarFrame;
        
        // Initialize title
        self.title = title;
        
        // Initialize actions
        self.action = action;
        self.buttonsActions = [NSMutableArray array];
        
        // Initialize swipe gesture
        if (self.swipeGestureRecognizer) {
            [self removeGestureRecognizer:self.swipeGestureRecognizer];
        }
        
        // Initialize completion handler
        self.completionHandler = completionHandler;
        
        self.swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipeRight:)];
        [self addGestureRecognizer:self.swipeGestureRecognizer];
        
        // Setup view
        [self setup];
        
        // Add BottomBar to the current view
        [WINDOW addSubview:self];
        [WINDOW bringSubviewToFront:self];
    }
    return self;
}

- (void)dealloc {
    
    // Reset title
    if (self.title) {
        self.title = nil;
    }
    
    // Reset title label
    if (self.labelTitle) {
        [self.labelTitle removeFromSuperview];
        self.labelTitle = nil;
    }
    
    // Reset action button
    if (self.buttonsActions) {
        for (UIButton *buttonAction in self.buttonsActions) {
            [buttonAction removeFromSuperview];
        }
        
        [self.buttonsActions removeAllObjects];
        self.buttonsActions = nil;
    }
    
    // Reset gesture recognizer
    [self removeGestureRecognizer:self.swipeGestureRecognizer];
    self.swipeGestureRecognizer = nil;
    
    // Reset completion handler
    if (self.completionHandler) {
        self.completionHandler = nil;
    }
}

- (void)setup {
    
    // View configuration
    // ------------------
    
    self.backgroundColor = RGB(50, 50, 50);
    self.opaque = YES;
    self.clipsToBounds = YES;
    
    CGFloat widthDelimitered = ( WINDOW.frame.size.width - ( 2 * SNACK_BAR_PADDING ));
    
    
    // Title
    // -----
    
    NSAttributedString *attributedDetail = [ViewHelper2 attributedStringWithString:[NNIL(self.title) uppercaseString] font:[UIFont fontWithName:@"Helvetica-Bold" size:16] color:[UIColor whiteColor] alignment:NSTextAlignmentLeft];
    CGFloat labelTitleCalculatedlWidth = [ViewHelper2 widthForAttributedString:attributedDetail constrainedToHeight:SNACK_BAR_HEIGHT];
    
    CGFloat labelTitleWIdth = widthDelimitered;
    
    if (labelTitleCalculatedlWidth > labelTitleWIdth) {
        labelTitleWIdth = widthDelimitered;
        
        // Increase Snack Bar height
        CGRect currentFrame = self.frame;
        currentFrame.size.height += SNACK_BAR_HEIGHT;
        self.frame = currentFrame;
    }
    
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(SNACK_BAR_PADDING, 0, labelTitleWIdth, SNACK_BAR_HEIGHT)];
    labelTitle.opaque = YES;
    labelTitle.backgroundColor = RGB(50, 50, 50);
    labelTitle.textColor = [UIColor whiteColor];
    labelTitle.textAlignment = NSTextAlignmentLeft;
    labelTitle.font = [UIFont fontWithName:@"Helvetica" size:16];;
    labelTitle.text = NNIL(self.title);
    labelTitle.lineBreakMode = NSLineBreakByWordWrapping;
    labelTitle.numberOfLines = 0;
    
    self.labelTitle = labelTitle;
    [self addSubview:self.labelTitle];
    
    
    // Actions
    // -------
    
    if (self.action.length > 0) {
        
        UIButton *buttonAction = [[UIButton alloc] initWithFrame:CGRectMake(WINDOW.frame.size.width - ( widthDelimitered / 3) - SNACK_BAR_PADDING, (self.frame.size.height == SNACK_BAR_HEIGHT) ? 0 : SNACK_BAR_HEIGHT, ( widthDelimitered / 3), SNACK_BAR_HEIGHT)];
        buttonAction.opaque = YES;
        buttonAction.backgroundColor = RGB(50, 50, 50);
        [buttonAction setTitleColor:RGB(255, 64, 129) forState:UIControlStateNormal];
        [buttonAction setTitle:[self.action uppercaseString] forState:UIControlStateNormal];
        buttonAction.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        buttonAction.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [buttonAction addTarget:self action:@selector(didTapOnButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        buttonAction.tag = 0;
        
        [self addSubview:buttonAction];
        
    }
    
    
    // Show
    // ----
    [self show];
}



#pragma mark - Public API

+ (instancetype)snackBarWithTitle:(NSString *)title action:(NSString *)action completionHandler:(SnackBarCompletionHandler)completionHandler {
    return [[SnackBarView alloc] initWithTitle:title action:action completionHandler:completionHandler];
}



#pragma mark - Private API

- (void)show {
    
    // Show Snack Bar
    if (self.frame.origin.y == WINDOW.frame.size.height) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect currentFrame = self.frame;
            currentFrame.origin.y -= currentFrame.size.height;
            self.frame = currentFrame;
        } completion:^(BOOL finished) {
            
            [self performSelector:@selector(hide) withObject:nil afterDelay:SNACK_BAR_LONG_DURATION]; // Wait x seconds then disappear
        }];
    }
}

- (void)hide {
    
    // Hide Snack Bar
    if (self.frame.origin.y < WINDOW.frame.size.height) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect currentFrame = self.frame;
            currentFrame.origin.y += currentFrame.size.height;
            self.frame = currentFrame;
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
        }];

    }
}



#pragma mark View event handlers

- (void)didTapOnButtonAction:(id)button {
    [self hide];
    
    // Invoke completion handler
    if (self.completionHandler) {
        self.completionHandler();
    }
}

- (void)didSwipeRight:(UISwipeGestureRecognizer*)gestureRecognizer {
    
    if (self.swipeGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [self.swipeGestureRecognizer locationInView:self];
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect currentFrame = self.frame;
            currentFrame.origin.x += translation.x;
            self.frame = currentFrame;
        } completion:^(BOOL finished) {
        }];
    }
    else if (self.swipeGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect currentFrame = self.frame;
            currentFrame.origin.x += (WINDOW.frame.size.width - currentFrame.origin.x);
            self.frame = currentFrame;
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

@end
