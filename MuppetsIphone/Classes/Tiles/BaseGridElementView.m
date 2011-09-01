//
//  BaseGridElement.m
//  Muppets
//
//  Created by Gaurav Sharma on 7/20/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "BaseGridElementView.h"


@implementation BaseGridElementView
@synthesize image;
@synthesize backgroundImage;
@synthesize label;
@synthesize delegate;
@synthesize data;
@synthesize selected;

+ (id)new{
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"BaseGridElementView"
                                                      owner:self
                                                    options:nil];    
    return [[nibViews objectAtIndex:0] retain];
}

- (void)layoutSubviews{
    if (!_gestureAdded){
        _gestureAdded = YES;

        UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [singleTapRecognizer setDelegate:self];
        [singleTapRecognizer setNumberOfTapsRequired:1];
        [self addGestureRecognizer:singleTapRecognizer];
        [singleTapRecognizer release];
        
        UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapped:)];
        [doubleTapRecognizer setDelegate:self];
        [doubleTapRecognizer setNumberOfTapsRequired:2];
        [self addGestureRecognizer:doubleTapRecognizer];
        [doubleTapRecognizer release];
        
        UILongPressGestureRecognizer *holdGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(itemHeld:)];
        [holdGestureRecognizer setDelegate:self];
        [holdGestureRecognizer setMinimumPressDuration:1.0f];
        [self addGestureRecognizer:holdGestureRecognizer];
        [holdGestureRecognizer release];
        
        selection                   = [[CAShapeLayer layer] retain];
        selection.fillColor         = [[UIColor clearColor] CGColor];
        selection.strokeColor       = [[UIColor yellowColor] CGColor];
        selection.lineWidth         = 2.0f;
        selection.lineJoin          = kCALineJoinRound;
        selection.lineDashPattern   = [NSArray arrayWithObjects:[NSNumber numberWithInt:10],[NSNumber numberWithInt:10], nil];
        selection.position          = CGPointMake(0, 0);
        selection.hidden            = YES;
        
        [[self layer] addSublayer:selection];
    }
}

-(void)showSelection {
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

- (void)setSelected:(BOOL)isselected{
    selected = isselected;
    if (selected) {
        [self showSelection];
    }
    selection.hidden = !isselected;
}

- (void)tapped:(UITapGestureRecognizer *)gesture{
    if ([delegate respondsToSelector:@selector(gridItemSingleTapped:)]) {
        [delegate gridItemSingleTapped:self];
    }
}

- (void)doubleTapped:(UITapGestureRecognizer *)gesture{
    if ([delegate respondsToSelector:@selector(gridItemDoubleTapped:)]) {
        [delegate gridItemDoubleTapped:self];
    }
}

- (void)itemHeld:(UILongPressGestureRecognizer *)gesture{
    if ([delegate respondsToSelector:@selector(gridItemlongPressed:)]) {
        [delegate gridItemlongPressed:self];
    }
}

- (void)setData:(NSDictionary *)somedata{
    if (data) {
        [data release], data = nil;
    }
    data = [somedata retain];
}

- (void)hideLabel{
    label.hidden = YES;
    self.bounds  = backgroundImage.bounds;
//    image.frame = self.bounds;
}

- (void)dealloc
{
    [image release];
    [label release];
    [data release];
    //[delegate release];
    [backgroundImage release];
    [super dealloc];
}

@end
