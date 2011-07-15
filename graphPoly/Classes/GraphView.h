//
//  GraphView.h
//  graphTest
//
//  Created by Yogesh Bhople on 17/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GraphView : UIView {

	NSMutableArray* rawDataArray;
	NSString* countryName;
	NSInteger	countryRating;
	
	//Temporary variables
	int xAxisYpos;
@public
	NSMutableArray* secondGraphArray;
	int flg;
}

@property (assign) NSMutableArray* secondGraphArray;

//- (id)initWithFrame:(CGRect)frame graphdata:(NSMutableArray*) dataArray CountryName:(NSString*) cName Rating:(NSInteger) rating;
- (id)initWithFrame:(CGRect)frame graphdata:(NSMutableArray*) dataArray CountryName:(NSString*) cName Rating:(NSInteger) rating secongraph:(NSMutableArray*) secPointArray;

-(void) DrawBackground;
-(void) DrawCountryName;
-(void) DrawRating;
- (CGSize) getSize:(NSString*) string;

-(void) DrawGraphAxis:(CGRect)rect;
-(void) DrawGraphShadow:(CGPoint[]) graphPosArray shadowcolor:(UIColor*) color;
- (void) CalculateActualPoints:(CGPoint[]) monthImagePosArray starposition:(CGPoint[]) starImagePosArray;
-(void) DrawGraph:(CGPoint[]) graphPosArray graphcolor:(UIColor*) color;

@end
