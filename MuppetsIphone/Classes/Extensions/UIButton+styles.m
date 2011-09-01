//
//  UIButton+styles.m
//  Muppets
//
//  Created by Gaurav Sharma on 7/20/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "UIButton+styles.h"

#define kThemeCornerRadius 10


@implementation UIButton (UIButton_styles)

- (void)_applyThemeWithImages:(UIImage *)image andSelectedImage:(UIImage *)selectedImage{
    [self setBackgroundImage:image forState:UIControlStateNormal];
    [self setBackgroundImage:selectedImage forState:UIControlStateSelected];
    [self setBackgroundImage:selectedImage forState:UIControlStateHighlighted];
    [self setBackgroundImage:image forState:UIControlStateDisabled];
    
    [self setTitleColor:UIColorFromRGB(0xFCDDBD) forState:UIControlStateNormal];
    [self setTitleColor:UIColorFromRGB(0xFCDDBD) forState:UIControlStateSelected];
    [self setTitleColor:UIColorFromRGB(0xFCDDBD) forState:UIControlStateHighlighted];
    [self setTitleColor:UIColorFromRGB(0xAAAAAA) forState:UIControlStateDisabled];
}

- (void)applyThemeForLeftButton{
    UIImage *_bgN  = [[UIImage imageNamed:@"tab_bar_button-left.png"] stretchableImageWithLeftCapWidth:kThemeCornerRadius topCapHeight:kThemeCornerRadius];
    UIImage *_bgS = [[UIImage imageNamed:@"tab_bar_button-left-selected.png"] stretchableImageWithLeftCapWidth:kThemeCornerRadius topCapHeight:kThemeCornerRadius];
    [self _applyThemeWithImages:_bgN andSelectedImage:_bgS];
}

- (void)applyThemeForRightButton{
    UIImage *_bgN  = [[UIImage imageNamed:@"tab_bar_button-right.png"] stretchableImageWithLeftCapWidth:kThemeCornerRadius topCapHeight:kThemeCornerRadius];
    UIImage *_bgS = [[UIImage imageNamed:@"tab_bar_button-right-selected.png"] stretchableImageWithLeftCapWidth:kThemeCornerRadius topCapHeight:kThemeCornerRadius];
    [self _applyThemeWithImages:_bgN andSelectedImage:_bgS];
}

- (void)applyThemeForMiddleButton{
    UIImage *_bgN  = [[UIImage imageNamed:@"tab_bar_button-middle.png"] stretchableImageWithLeftCapWidth:kThemeCornerRadius topCapHeight:kThemeCornerRadius];
    UIImage *_bgS = [[UIImage imageNamed:@"tab_bar_button-middle-selected.png"] stretchableImageWithLeftCapWidth:kThemeCornerRadius topCapHeight:kThemeCornerRadius];
    [self _applyThemeWithImages:_bgN andSelectedImage:_bgS];
}

- (void)applyTheme{
    UIImage *_bgN  = [[UIImage imageNamed:@"tab_bar_button.png"] stretchableImageWithLeftCapWidth:kThemeCornerRadius topCapHeight:kThemeCornerRadius];
    UIImage *_bgS = [[UIImage imageNamed:@"tab_bar_button-selected.png"] stretchableImageWithLeftCapWidth:kThemeCornerRadius topCapHeight:kThemeCornerRadius];
    [self _applyThemeWithImages:_bgN andSelectedImage:_bgS];
}

- (void)applyBackButtonTheme{
    UIImage *_bgN  = [[UIImage imageNamed:@"back_button.png"] stretchableImageWithLeftCapWidth:20.0f topCapHeight:2];
    UIImage *_bgS = [[UIImage imageNamed:@"back_button-selected.png"] stretchableImageWithLeftCapWidth:20.0f topCapHeight:2];
    [self _applyThemeWithImages:_bgN andSelectedImage:_bgS];
}

@end
