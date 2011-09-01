//
//  Physics.m
//  Muppets
//
//  Created by Gaurav Sharma on 7/4/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "Physics.h"

#define	kGravity -1000

static Physics *shared=nil;

@interface Physics (private)

- (void)load;

@end

@implementation Physics

@synthesize rootView;

+ (Physics*)shared{
	@synchronized(shared){
		if (!shared) {
			shared = [[Physics alloc] init];
			[shared load];
		}
	}
	return shared;
}

- (void)load{
    cpInitChipmunk();
    space           = cpSpaceNew();
    space->gravity  = cpv(0, kGravity);
	gameTimer       = [[NSTimer scheduledTimerWithTimeInterval:1.0f/60.0f target:self selector:@selector(gameTimerTick:) userInfo:nil repeats:YES] retain];
}

void updateShape(void *ptr, void* unused) {
	// Get our shape
	cpShape *shape		= (cpShape*)ptr;
	UIView *targetView	= shape->data;
	
	// Make sure everything is as expected or tip & exit
	if(shape == nil || shape->body == nil || targetView == nil) {
		// NSLog(@"Unexpected shape please debug here...");
		return;
	}
	
	// Lastly checks if the object is an UIView of any kind
	// and update its position accordingly
	if([targetView isKindOfClass:[UIView class]]) {		
        CGPoint _center = CGPointMake(shape->body->p.x, -shape->body->p.y);
        _center         = [[Physics shared].rootView convertPoint:_center toView:targetView.superview];
        [targetView setCenter:_center];
	}
	else {
		// NSLog(@"The shape data wasn't updateable using this code.");
	}
}

- (void)gameTimerTick:(NSTimer *)timer {
    if(gameTimerDisabled)
        return;
	// Tell Chipmunk to take another "step" in the simulation
	cpSpaceStep(space, 1.0f/60.0f);
	cpSpaceHashEach(space->activeShapes, &updateShape, nil);
}

- (void)addPhysicalObject:(UIView *)viewObject{
	cpBody *body = cpBodyNew(1.0, 5000.0);

	body->p = cpv(viewObject.center.x, - viewObject.center.y);

	// Add the body to the space
    cpSpaceAddBody(space, body);

	// Create our shape associated with the body
	cpShape *shape;
    cpVect verts[]	= { cpv(0.0, 0.0), cpv(viewObject.frame.size.width, 0.0), cpv(viewObject.frame.size.width, -viewObject.frame.size.height), cpv(0.0, -viewObject.frame.size.height) };
    shape			= cpPolyShapeNew(body, 4, verts, cpv(-viewObject.frame.size.width / 2, viewObject.frame.size.height / 2));

	shape->e				= 0.2;					// Elasticity
	shape->u				= 0.7;                  // Friction
	shape->data				= viewObject;			// Associate 
	shape->collision_type	= 1;					// Collisions are grouped by types
    
	// Add the shape to out space
	cpSpaceAddShape(space, shape);
}


@end
