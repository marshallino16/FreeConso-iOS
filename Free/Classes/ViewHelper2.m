//
//  ViewHelper.m
//  Tisseo
//
//  Created by Junior on 19/09/16.
//  Copyright © 2016 GENyUS. All rights reserved.
//

#import "ViewHelper2.h"

@implementation ViewHelper2

+ (void)configureNavigationBarWithNavigationController:(UINavigationController *)navigationController {
    NSAssert(navigationController, @"Root navigation controller cannot be nil!");
    
    //Set custom colors
    UINavigationBar *bar = [navigationController navigationBar];
    [bar setTranslucent:NO];
    [bar setClipsToBounds:NO];
    [bar setBarStyle:UIBarStyleBlack];
    [bar setTintColor:[UIColor whiteColor]];
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [bar setBarTintColor:RGB(210, 64, 85)];
    [bar setBackgroundImage:[[UIImage alloc] init]
             forBarPosition:UIBarPositionAny
                 barMetrics:UIBarMetricsDefault];
    
    [bar setShadowImage:[[UIImage alloc] init]];
    [bar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [bar setShadowImage:[UIImage new]];
    
    UIBarButtonItem *barButton = [navigationController editButtonItem];
    [barButton setTintColor:[UIColor whiteColor]];
}

+ (void)generateShadowBoxWithView:(UIView *)view radius:(CGFloat)radius offsetWidth:(CGFloat)offsetWidth offsetHeight:(CGFloat)offsetHeight opacity:(CGFloat)opacity color:(UIColor *)color {
    [view.layer setCornerRadius:radius];
    [view.layer setMasksToBounds:NO];
    [view.layer setShadowColor:[color CGColor]];
    [view.layer setShadowOffset:CGSizeMake(offsetWidth, offsetHeight)];
    [view.layer setShadowOpacity:opacity];
}

+ (CGFloat)widthForAttributedString:(NSAttributedString *)attributedString constrainedToHeight:(CGFloat)height {
    NSTextStorage *textStorage      = [[NSTextStorage alloc] initWithAttributedString:attributedString];
    NSTextContainer *textContainer  = [[NSTextContainer alloc] initWithSize:CGSizeMake(CGFLOAT_MAX, height)];
    NSLayoutManager *layoutManager  = [[NSLayoutManager alloc] init];
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    [layoutManager glyphRangeForTextContainer:textContainer];
    return [layoutManager usedRectForTextContainer:textContainer].size.width;
    
    // Old method: < iOS 10.0
    // ----------------------
    
    /*CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString);
     CGSize targetSize = CGSizeMake(CGFLOAT_MAX, height);
     CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, [attributedString length]), NULL, targetSize, NULL);
     CFRelease(framesetter);
     return size.width;*/
}

+ (CGFloat)heightForAttributedString:(NSAttributedString *)attributedString constrainedToWidth:(CGFloat)width {
    NSTextStorage *textStorage      = [[NSTextStorage alloc] initWithAttributedString:attributedString];
    NSTextContainer *textContainer  = [[NSTextContainer alloc] initWithSize:CGSizeMake(width, CGFLOAT_MAX)];
    NSLayoutManager *layoutManager  = [[NSLayoutManager alloc] init];
    [layoutManager addTextContainer:textContainer];
    [textStorage addLayoutManager:layoutManager];
    [layoutManager glyphRangeForTextContainer:textContainer];
    return [layoutManager usedRectForTextContainer:textContainer].size.height;
    
    // Old method: < iOS 10.0
    // ----------------------
    
    /*CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attributedString);
     CGSize targetSize = CGSizeMake(width, CGFLOAT_MAX);
     CGSize size = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, [attributedString length]), NULL, targetSize, NULL);
     CFRelease(framesetter);
     return size.height;*/
}

+ (NSMutableAttributedString *)attributedStringWithString:(NSString *)string font:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment {
    // Build paragraph style
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.alignment = alignment;
    
    // Build attributed string
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttribute:NSForegroundColorAttributeName    value:color            range:NSMakeRange(0, string.length)];
    [attributedString addAttribute:NSFontAttributeName               value:font             range:NSMakeRange(0, string.length)];
    [attributedString addAttribute:NSParagraphStyleAttributeName     value:paragraphStyle   range:NSMakeRange(0, string.length)];
    
    return attributedString;
}

@end
