//
//  CanvasObject.m
//  Muppets
//
//  Created by Achal Aggarwal on 04/07/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "CanvasObject.h"

@interface CanvasObject()

-(void) setup;
-(void) setupGestures;

@end

@implementation CanvasObject

@synthesize zindex;

-(void)showOverlay {
    if (![selection actionForKey:@"linePhase"]) {
        CABasicAnimation *dashAnimation;
        dashAnimation = [CABasicAnimation animationWithKeyPath:@"lineDashPhase"];
        [dashAnimation setFromValue:[NSNumber numberWithFloat:0.0f]];
        [dashAnimation setToValue:[NSNumber numberWithFloat:20.0f]];
        [dashAnimation setDuration:0.25f];
        [dashAnimation setRepeatCount:HUGE_VALF];
        [selection addAnimation:dashAnimation forKey:@"linePhase"];
    }
    
    [selection setBounds:CGRectMake(0, 0, 0, 0)];

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    [selection setPath:path];
    CGPathRelease(path);
}

-(void)tap:(id)sender {
    selection.hidden = !selection.hidden;
    
}

-(void)doubleTap:(id)sender {
}

-(void)scale:(id)sender {
    
    if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        lastScale = 1.0;
    }
    
    CGFloat _scale = 1.0 - (lastScale - [(UIPinchGestureRecognizer*)sender scale]);
    
    CGAffineTransform _currentTransform = self.transform;
    CGAffineTransform _newTransform = CGAffineTransformScale(_currentTransform, _scale, _scale);
    
    [self setTransform:_newTransform];
    
    lastScale = [(UIPinchGestureRecognizer*)sender scale];
}

-(void)rotate:(id)sender {
    if([(UIRotationGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {
        lastRotation = 0.0;
        return;
    }
    
    CGFloat _rotation = 0.0 - (lastRotation - [(UIRotationGestureRecognizer*)sender rotation]);
    
    CGAffineTransform _newTransform = CGAffineTransformRotate(self.transform,_rotation);
    
    [self setTransform:_newTransform];
    
    lastRotation = [(UIRotationGestureRecognizer*)sender rotation];
}


-(void)move:(id)sender {
    
    CGPoint _translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.superview];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        firstX = [self center].x;
        firstY = [self center].y;
    }
    
    _translatedPoint = CGPointMake(firstX+_translatedPoint.x, firstY+_translatedPoint.y);
    
    [self setCenter:_translatedPoint];
}

-(id) init {
    self = [super init];
    
    if (!selection) {
        selection                   = [[CAShapeLayer layer] retain];
        selection.fillColor         = [[UIColor clearColor] CGColor];
        selection.strokeColor       = [[UIColor yellowColor] CGColor];
        selection.lineWidth         = 5.0f;
        selection.lineJoin          = kCALineJoinRound;
        selection.lineDashPattern   = [NSArray arrayWithObjects:[NSNumber numberWithInt:10],[NSNumber numberWithInt:10], nil];
        selection.position          = CGPointMake(0, 0);
        selection.hidden            = YES;
    }
    
    [[self layer] addSublayer:selection];
    [self setupGestures];
    return self;
}

-(id) initWithDictionary:(NSDictionary *) dictionary andPath:(NSString *) path{
    self = [self init];
    if (self) {        
        type = [OBJECT_TYPE indexOfObject:[dictionary objectForKey:@"type"]];
        zindex = [[dictionary valueForKey:@"z-index"] intValue];
      
        firstX = [[[dictionary objectForKey:@"center"] valueForKey:@"x"] floatValue];
        firstY = [[[dictionary objectForKey:@"center"] valueForKey:@"y"] floatValue];
      //  NSLog(@"center == %f %f",firstX,firstY);
        self.center = CGPointMake(firstX, firstY);
        content = [dictionary objectForKey:@"content"];
     //   NSLog(@"dictonaryyyy================count---====== == %@  %d",dictionary,[dictionary count]);
        
        scale = [[dictionary valueForKey:@"scale"] floatValue]-0.1;
        rotation = [[dictionary valueForKey:@"rotation"] floatValue];
        projectPath = path;
    }
    [self setup];
    return self;
}

-(void) setup {
    //Please over ride this method to customize the view
}

- (void) setupAfterCanvas {
    //Please over ride this method to customize the view
}

-(void) autoresize {
    float _width = 0.0f;
    float _height = 0.0f;
    
    [self setBackgroundColor:[UIColor clearColor]];
    
    for (UIView *obj in [self subviews]) {
        
        [obj setBackgroundColor:[UIColor clearColor]];
        
        if (obj.frame.origin.x + obj.frame.size.width > _width) {
            _width = obj.frame.origin.x + obj.frame.size.width;
        }
        if (obj.frame.origin.y + obj.frame.size.height > _height) {
            _height = obj.frame.origin.y + obj.frame.size.height;
        }
    }
    [self setBounds:CGRectMake(0, 0, _width, _height)];
    [self layoutSubviews];
    
    CGAffineTransform t = CGAffineTransformMakeScale(scale, scale);
    t = CGAffineTransformRotate(t, degreesToRadian(rotation));
    self.transform = t;
}

-(void) setupGestures {
    UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [singleTapRecognizer setDelegate:self];
    [singleTapRecognizer setNumberOfTapsRequired:1];
    [self addGestureRecognizer:singleTapRecognizer];
    [singleTapRecognizer release];
    
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTap:)];
    [doubleTapRecognizer setDelegate:self];
    [doubleTapRecognizer setNumberOfTapsRequired:2];
    [self addGestureRecognizer:doubleTapRecognizer];
    [doubleTapRecognizer release];
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)];
    [pinchRecognizer setDelegate:self];
    [self addGestureRecognizer:pinchRecognizer];
    [pinchRecognizer release];
    
    UIRotationGestureRecognizer *rotationRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    [rotationRecognizer setDelegate:self];
    [self addGestureRecognizer:rotationRecognizer];
    [rotationRecognizer release];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    [self addGestureRecognizer:panRecognizer];
    [panRecognizer release];
}

#pragma mark Serialize and Save methods

- (NSMutableDictionary *) serialize {
    NSMutableDictionary *_dictionary = [[NSMutableDictionary alloc] init];
    [_dictionary setObject:[OBJECT_TYPE objectAtIndex:type] forKey:@"type"];
    [_dictionary setObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithFloat:self.center.x], [NSNumber numberWithFloat:self.center.y], nil] 
                                                       forKeys:[NSArray arrayWithObjects:@"x", @"y", nil]] 
                    forKey:@"center"];
    CGFloat radians = atan2f(self.transform.b, self.transform.a); 
    CGFloat degrees = radians * (180 / M_PI);
    [_dictionary setObject:[NSNumber numberWithFloat:degrees] forKey:@"rotation"];
    [_dictionary setObject:[NSNumber numberWithFloat:self.transform.a] forKey:@"scale"];
    return _dictionary;
}

- (NSDictionary *) file {
    return nil;
}

#pragma mark Gesture Recognizer

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    [[self superview] bringSubviewToFront:self];
    [self showOverlay];
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return YES;
}

- (void)dealloc
{
    [super dealloc];
}

#pragma mark Class Methods

+(id) objectWithDictionary:(NSDictionary *) dictionary andPath:(NSString *) path{
    id _obj = nil;
    Class _class = NSClassFromString([NSStringFromClass([self class]) stringByAppendingString:[dictionary objectForKey:@"type"]]);
    _obj = [[_class alloc] initWithDictionary:dictionary andPath:path];
    return _obj;
}

@end
