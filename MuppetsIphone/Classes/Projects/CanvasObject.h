//
//  CanvasObject.h
//  Muppets
//
//  Created by Achal Aggarwal on 04/07/11.
//  Copyright 2011 NA. All rights reserved.
//
//  Base canvas object which has all the UIGestureRecognizer based controls in it.
#import <UIKit/UIKit.h>

#define OBJECT_TYPE [NSArray arrayWithObjects:@"Photo", @"Background", @"Text", @"Muppet", @"Stamp", @"Character", nil]

typedef enum {
    CanvasObjectTypePhoto=0,
    CanvasObjectTypeBackground,
    CanvasObjectTypeText,
    CanvasObjectTypeMuppet,
    CanvasObjectTypeStamp,
    CanvasObjectTypeCharacter
} CanvasObjectType;

@interface CanvasObject : UIView <UIGestureRecognizerDelegate> {
    
    CanvasObjectType type;
    NSUInteger zindex;
    
    CGFloat lastScale;
	CGFloat lastRotation;  
	CGFloat firstX;
	CGFloat firstY;
    
    CGFloat rotation;
    CGFloat scale;
    
    NSDictionary *content;
    NSString *projectPath;
    
    CAShapeLayer *selection;
}

@property(nonatomic, assign) NSUInteger zindex;

+(id) objectWithDictionary:(NSDictionary *) dictionary andPath:(NSString *) path;;
-(id) initWithDictionary:(NSDictionary *) dictionary andPath:(NSString *) path;;
-(void) autoresize;
- (void) setupAfterCanvas;

- (NSMutableDictionary *) serialize; //override this method in subclasses to serialize the data, this is just a NSDictionary serialized into JSON
- (NSDictionary *) file; //returns an array of dictionary, which has the key as the filename, and the value as NSData to be saved in the project folder.


@end
