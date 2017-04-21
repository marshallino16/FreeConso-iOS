//
//  ViewHelper.h
//  Free
//
//  Created by Junior on 19/09/16.
//  Copyright © 2016 GENyUS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewHelper2 : NSObject

+ (void)configureNavigationBarWithNavigationController:(UINavigationController *)navigationController;
+ (void)generateShadowBoxWithView:(UIView *)view radius:(CGFloat)radius offsetWidth:(CGFloat)offsetWidth offsetHeight:(CGFloat)offsetHeight opacity:(CGFloat)opacity color:(UIColor *)color;
+ (CGFloat)widthForAttributedString:(NSAttributedString *)attributedString constrainedToHeight:(CGFloat)height;
+ (CGFloat)heightForAttributedString:(NSAttributedString *)attributedString constrainedToWidth:(CGFloat)width;
+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment;

@end
