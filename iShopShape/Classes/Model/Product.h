//
//  Product.h
//  iShopShape
//
//  Created by Santosh B on 05/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Product : NSObject {
	NSString *thumbnailImageName;
	NSString *productName;
	NSString *productCode;
	int quantity;
	int hotspotNumber;
	float xCoordinate;
	float yCoordinate;
}
@property (nonatomic, retain) NSString *thumbnailImageName;
@property (nonatomic, retain) NSString *productName;
@property (nonatomic, retain) NSString *productCode;
@property (nonatomic) int quantity;
@property (nonatomic) int hotspotNumber;
@property (nonatomic) float xCoordinater;
@property (nonatomic) float yCoordinater;
@end
