//
//  Message.h
//  SMS Bubbles
//
//  Created by Ayush Goel on 12/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Message : NSObject {
	int  id1;
	int pos;
	NSString *text;
	NSString *image;

}

@property(nonatomic) int id1;
@property(nonatomic) int pos;
@property(nonatomic,retain) NSString *text;
@property(nonatomic,retain) NSString *image;
@end
