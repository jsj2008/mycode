//
//  Guides.h
//  iShopShape
//
//  Created by Santosh B on 20/12/10.
//  Copyright 2010 Cybage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GuidesDetails.h"

@interface Guides : NSObject {
	NSString *guideTitle;
	NSString *guideSubTitle;
	UIImage  *guideImage;
	NSString *guideNotes;
	NSArray *guideDetailsArray;
}
@property (nonatomic, retain) NSString *guideTitle;
@property (nonatomic, retain) NSString *guideSubTitle;
@property (nonatomic, retain) NSString *guideNotes;
@property (nonatomic, retain) UIImage  *guideImage;
@property (nonatomic, retain) NSArray *guideDetailsArray;
@end
