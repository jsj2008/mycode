//
//  macros.h
//  Muppets
//
//  Created by Gaurav Sharma on 6/13/11.
//  Copyright 2011 Sequence All rights reserved.
//


#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

// ALog always displays output regardless of the DEBUG setting
#define ALog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

#define IS_NULL(x)	((nil == x) || ([x isEqual: [NSNull null]]))

#define kSupportedOrientations (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)

#ifdef BASIC
#define isBasicApp() YES
#define isPremiumApp() NO
#else
#define isBasicApp() NO
#define isPremiumApp() YES
#endif

#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(x) (x) * 180/M_PI

#ifdef NO_ANIMATIONS
#define animationsDisabled() YES
#else
#define animationsDisabled() NO
#endif

#define UIColorFromRGB(rgbValue) [UIColor \
    colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
    green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
    blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
