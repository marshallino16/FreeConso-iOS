//
//  LoginController.m
//  Free
//
//  Created by Anthony Fernandez on 30/03/2017.
//  Copyright © 2017 GENyUS. All rights reserved.
//

#import "LoginController.h"
#import "ViewHelper2.h"
#import "ConsoController.h"
#import "StoredDataManager.h"
#import "ConsoManager.h"
#import "SnackBarView.h"


// Frameworks
// ----------

#import <SVProgressHUD/SVProgressHUD.h>





#pragma mark - Login Controller: Private Interface

@interface LoginController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UIView *headerView;
@property (nonatomic, weak) IBOutlet UIButton *connectButton;
@property (nonatomic, weak) IBOutlet UIButton *connectOtherAccountButton;
@property (nonatomic, weak) IBOutlet UIImageView *freeImageView;

@property (nonatomic, weak) IBOutlet UIView *connectionView;
@property (nonatomic, weak) IBOutlet UITextField *loginTextField;
@property (nonatomic, weak) IBOutlet UITextField *passwordTextField;

@property (assign) BOOL hasConnectedAnAccount;

@end




#pragma mark - Login Controller: Implementation

@implementation LoginController


#pragma mark Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    self.hasConnectedAnAccount = NO;
    
    //Create shadow path
    [ViewHelper2 generateShadowBoxWithView:self.connectionView radius:2.0f offsetWidth:0.0f offsetHeight:-1.0f opacity:0.4f color:RGB(208, 208, 209)];
    self.connectionView.layer.borderWidth = 0.3f;
    self.connectionView.layer.borderColor = [RGB(205, 205, 211) CGColor];
    self.connectButton.layer.cornerRadius = 3.0f;
    
    // Add bottom borders
    CALayer *bottomBorder1 = [CALayer layer];
    bottomBorder1.frame = CGRectMake(0.0f, 37.0f, 247.0f, 1.0f);
    bottomBorder1.backgroundColor = RGB(210, 64, 85).CGColor;
    
    CALayer *bottomBorder2 = [CALayer layer];
    bottomBorder2.frame = CGRectMake(0.0f, 37.0f, 247.0f, 1.0f);
    bottomBorder2.backgroundColor = RGB(210, 64, 85).CGColor;
    
    [self.loginTextField.layer addSublayer:bottomBorder1];
    [self.passwordTextField.layer addSublayer:bottomBorder2];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([[StoredDataManager sharedManager] hasConnectedOneAccount]) {
        NSString *connectedAccountFullname = [[StoredDataManager sharedManager] connectedAccountFullname];
        [self.connectButton setTitle:[NSString stringWithFormat:@"Continue as %@", connectedAccountFullname] forState:UIControlStateNormal];
        
        self.hasConnectedAnAccount = YES;
        self.connectOtherAccountButton.hidden = NO;
    }
    else {
        self.hasConnectedAnAccount = NO;
        self.connectOtherAccountButton.hidden = YES;
        [UIView animateWithDuration:0.4 animations:^{
            self.connectionView.alpha = 1.0f;
        }];
    }
    
    // Status bar color
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Status bar color
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;;
}

- (void)viewDidLayoutSubviews {
    // Connect button
    NSAttributedString *attributedNumberOfPrints = [ViewHelper2 attributedStringWithString:self.connectButton.titleLabel.text font:self.connectButton.titleLabel.font color:self.connectButton.currentTitleColor alignment:NSTextAlignmentCenter];
    CGFloat numberOfPrintsWidth = [ViewHelper2 widthForAttributedString:attributedNumberOfPrints constrainedToHeight:41];
    CGRect buttonFrame = self.connectButton.frame;
    buttonFrame.size.width = numberOfPrintsWidth + 16;
    buttonFrame.origin.y = ( self.headerView.frame.size.height - (buttonFrame.size.height / 2) );
    buttonFrame.origin.x = ( (self.headerView.frame.size.width / 2) - ((numberOfPrintsWidth + 16) / 2) );
    
    self.connectButton.frame = buttonFrame;
    [self.connectButton layoutIfNeeded];
    
    // Free image
    CGRect imageFrame = self.freeImageView.frame;
    imageFrame.origin.y = ( self.connectionView.frame.origin.y - imageFrame.size.height - 16 );
    
    self.freeImageView.layer.cornerRadius = (imageFrame.size.width / 2);
    self.freeImageView.frame = imageFrame;
    [self.freeImageView layoutIfNeeded];
}



#pragma mark - Event

- (IBAction)didTapOnConnectButton:(id)sender {
    
    // Preliminary check
    if (!self.hasConnectedAnAccount) {
        if (self.loginTextField.text.length == 0) {
            [self showError];
            return;
        }
        if (self.passwordTextField.text.length == 0) {
            [self showError];
            return;
        }
    }
    
    // Is already connected?
    NSString *login = nil;
    NSString *password = nil;
    if (self.hasConnectedAnAccount) {
        login = [[StoredDataManager sharedManager] connectedAccountLogin];
        password = [[StoredDataManager sharedManager] connectedAccountPassword];
    }
    else {
        login = self.loginTextField.text;
        password = self.passwordTextField.text;
    }
    
    [SVProgressHUD show];
    __weak LoginController *selfie = self;
    [[ConsoManager sharedManager] fetchAllConsoInfosWithCompletionHandler:^(id result, NSError *error) {
        
        if (error) {
            [selfie showError];
        }
        else if (result) {
            
            [SVProgressHUD dismiss];
            
            // Store data
            NSString *fullname = ((Conso *)result).fullname;
            [[StoredDataManager sharedManager] storedAccountLogin:login];
            [[StoredDataManager sharedManager] storedAccountPassword:password];
            [[StoredDataManager sharedManager] storedAccountFullname:(NNIL(fullname))];
            
            // Go to conso controller
            selfie.navigationController.navigationBar.hidden = NO;
            ConsoController *conso = [[ConsoController alloc] initWithConso:result];
            [selfie.navigationController pushViewController:conso animated:YES];
        }
        
    } login:login password:password];
}

- (IBAction)didTapOnConnectAnotherAccountButton:(id)sender {
    self.hasConnectedAnAccount = NO;
    self.connectOtherAccountButton.hidden = YES;
    [self.connectButton setTitle:@"CONNECT" forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        self.connectionView.alpha = 1.0f;
    }];
}


#pragma mark UITextView Delegate Implementation

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if([string isEqualToString:@"\n"]) {
        
        NSInteger nextTag = textField.tag + 1;
        // Try to find next responder
        UIResponder* nextResponder = [self.connectionView viewWithTag:nextTag];
        if (nextResponder) {
            // Found next responder, so set it.
            [nextResponder becomeFirstResponder];
        } else {
            // Not found, so remove keyboard.
            [textField resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}




#pragma mark Private methods 

- (void)showError {
    
    // Shake login view
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.1];
    [shake setRepeatCount:3];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint:CGPointMake(self.connectionView.center.x - 7, self.connectionView.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint:CGPointMake(self.connectionView.center.x + 7, self.connectionView.center.y)]];
    [self.connectionView.layer addAnimation:shake forKey:@"position"];
    
    // Display error
    [SnackBarView snackBarWithTitle:@"OOps, identifiants incorrects" action:@"EDITER" completionHandler:^{
       // Nothing to do yet
    }];
}


@end
