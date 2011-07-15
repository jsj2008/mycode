//
//  Product.m
//  iShopShape
//
//  Created by Santosh B on 05/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import "Product.h"


@implementation Product
@synthesize thumbnailImageName, productName, productCode, quantity, hotspotNumber,xCoordinater, yCoordinater;

- (void)dealloc
{
	NSLog(@"Product ----------------- Release");
	[thumbnailImageName release];
	[productName release];
	[productCode release];
	[super dealloc];
}
@end
