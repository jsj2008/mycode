//
//  CostumImageView.h
//  Community
//
//  Created by sujeet on 20/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CostumImageTouchedDelegate

-(void)imageTouched:(int)myIndex;

@end


@interface CostumImageView :UIImageView {
	id <CostumImageTouchedDelegate> delegate;
	NSString *ImageName;
	int myIndex;
}

@property(nonatomic,retain)	NSString *ImageName;

@property (nonatomic,assign) id <CostumImageTouchedDelegate> delegate;

@property(nonatomic)int myIndex;

- (id)initWithFrame:(CGRect)frame withImageName:(NSString *)name andIndex:(int)indexno;

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event;

@end
