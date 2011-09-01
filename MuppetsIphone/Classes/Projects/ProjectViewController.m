//
//  MupperBuilderViewController.m
//  Muppets
//
//  Created by Gaurav Sharma on 6/14/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "ProjectViewController.h"
#import "MuppetBuilderViewController.h"
#import "CanvasObjectBackground.h"
#import "TouchImageView.h"

@implementation ProjectViewController

@synthesize save_btn;
@synthesize save_picture_btn;
@synthesize canvasViewController;
@synthesize canvasContainer;

@synthesize canvasToolBarContainer;

- (void)loadProject:(Project *) project {
    [self view];
   
    [canvasViewController loadProject:project];
}
- (void)loadImage:(UIImage *)myImage
{
    [self view];
 
    [canvasViewController loadImage:myImage];
}
- (IBAction)saveProject:(id)sender {
    //[canvasViewController saveProject];
}



- (IBAction)shareProject:(id)sender {
   // [canvasViewController share];
}


- (id)init
{
    self = [super initWithNibName:@"ProjectView" bundle:nil];
    if (self) {
    }
    return self;
}
- (IBAction)addMuppet:(UIButton *)sender
{   
    for(TouchImageView *t  in [canvasViewController.canvas subviews])
    {
        if([t respondsToSelector:@selector(setSelected:)])
         [t setSelected:NO];
    }
    
    [arrayOfSelected removeAllObjects];
    muppetControl          = [MuppetView new];
    muppetControl._delegate=self;
    [self.navigationController pushViewController:muppetControl animated:YES];
    [muppetControl release]; 
}
- (IBAction)addCharacter:(UIButton *)sender
{  
    
    for(TouchImageView *t  in [canvasViewController.canvas subviews])
    {
        if([t respondsToSelector:@selector(setSelected:)])
        [t setSelected:NO];
    }
    [arrayOfSelected removeAllObjects];
    characterControl     = [CharacterView new];
     characterControl._delegate=self;
    [self.navigationController pushViewController:characterControl animated:YES];
    [characterControl release];   
}
- (IBAction)addBackground:(UIButton *)sender
{   NSLog(@"button");
    
}
- (IBAction)addStamp:(UIButton *)sender
{
    NSLog(@"button");   
}
- (IBAction)addSpeech:(UIButton *)sender
{
    NSLog(@"button");
}


- (void)characterSelected:(NSString * )name
{
    UIImage *image = [UIImage imageNamed:name];
	CGRect imageRect = CGRectMake(50.0, 50.0, 50, 50);
    TouchImageView *_touchImageView = [[TouchImageView alloc] initWithFrame:imageRect];
    _touchImageView.image = image;
     _touchImageView.clipsToBounds=YES;
    _touchImageView.tag = tagCount++;
    [_touchImageView.layer setBorderColor:[UIColor yellowColor].CGColor];
    [_touchImageView.layer setBorderWidth:0.0];
    UITapGestureRecognizer *glee = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
    [_touchImageView addGestureRecognizer:glee];
   //  glee.view.tag = tagCount;
    [glee release];
    [characterTags setObject:_touchImageView forKey:[NSString stringWithFormat:@"%d",tagCount]];
    [canvasViewController.canvas addSubview:_touchImageView];
   

}

- (void)muppetSelected:(NSString * )name
{
    UIImage *image = [UIImage imageNamed:name];
	CGRect imageRect = CGRectMake(50.0, 50.0, 50, 50);
    TouchImageView *_touchImageView = [[TouchImageView alloc] initWithFrame:imageRect];
    _touchImageView.clipsToBounds=YES;
    _touchImageView.image = image;
    _touchImageView.tag = tagCount++;
    [_touchImageView.layer setBorderColor:[UIColor yellowColor].CGColor];
    [_touchImageView.layer setBorderWidth:0.0];
    UITapGestureRecognizer *glee = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
   // glee.view.tag = tagCount;
    [_touchImageView addGestureRecognizer:glee];
    [glee release];
   
    [characterTags setObject:_touchImageView forKey:[NSString stringWithFormat:@"%d",tagCount]];
    [canvasViewController.canvas addSubview:_touchImageView];    
}

-(void)onTap:(UITapGestureRecognizer *)gesture
{
   
    
    for(TouchImageView *t  in [canvasViewController.canvas subviews])
    {
        if(gesture.view.tag == t.tag)
        {
            if (![t isSelected]) 
            {
                 [t setSelected:YES];
                [t showSelection];
               
               // [t.layer setBorderWidth:2.0];
                [arrayOfSelected addObject:[NSNumber numberWithInt:t.tag]];
 
            }
            else  {
               // [t.layer setBorderWidth:0.0];
                  [t setSelected:NO];
                [arrayOfSelected removeObject:[NSNumber numberWithInt:t.tag]];
            }            
        }
    }
    if([arrayOfSelected count]==0)
     canvasObjectLayerControl.hidden = YES;
     else
     canvasObjectLayerControl.hidden = NO;
    

}

-(void)showSelection:(TouchImageView *)t
{
    [self layoutSubviews:t];
    if (![selection actionForKey:@"linePhase"])
    {
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
    CGPathAddRect(path, NULL, t.bounds);
    [selection setPath:path];
    CGPathRelease(path);
}
- (void)layoutSubviews:(TouchImageView *)t
{
           
        selection                   = [[CAShapeLayer layer] retain];
        selection.fillColor         = [[UIColor clearColor] CGColor];
        selection.strokeColor       = [[UIColor yellowColor] CGColor];
        selection.lineWidth         = 2.0f;
        selection.lineJoin          = kCALineJoinRound;
        selection.lineDashPattern   = [NSArray arrayWithObjects:[NSNumber numberWithInt:10],[NSNumber numberWithInt:10], nil];
        selection.position          = CGPointMake(0, 0);
        selection.hidden            = YES;
        
        [t.layer addSublayer:selection];
    
}

- (IBAction)moveForward:(id)sender
{
    for(TouchImageView *t  in [canvasViewController.canvas subviews])
    {
        for(int i=0;i<[arrayOfSelected count];i++)
        {
            if(t.tag == [[arrayOfSelected objectAtIndex:i] intValue])
                 [canvasViewController.canvas bringSubviewToFront:t];
               
        }
    }

}
- (IBAction)moveBackward:(id)sender{
    for(TouchImageView *t  in [canvasViewController.canvas subviews])
    {
        for(int i=0;i<[arrayOfSelected count];i++)
        {
            if(t.tag == [[arrayOfSelected objectAtIndex:i] intValue])
                 [canvasViewController.canvas sendSubviewToBack:t];
        }
    }
}
- (IBAction)remove:(id)sender{
    for(TouchImageView *t  in [canvasViewController.canvas subviews])
    {
        for(int i=0;i<[arrayOfSelected count];i++)
        {
            if(t.tag == [[arrayOfSelected objectAtIndex:i] intValue])
                [t removeFromSuperview];
            [arrayOfSelected removeObject:[NSNumber numberWithInt:t.tag]];
        }
    }

}

- (void)dealloc
{
    [canvasViewController release];
 //   [canvasToolBarViewController release];
    [canvasToolBarContainer release];
    [canvasContainer release];
    [save_btn release];
    [save_picture_btn release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) loadMuppetBuilder:(NSNotification *) notification {
    muppetBuilder = [[MuppetBuilderViewController alloc] init];
    [muppetBuilder setCanvasObjectMuppet:[notification object]];
    [muppetBuilder loadMuppet];
    [muppetBuilder.background setImage:[self.view captureImage]];
    muppetBuilder.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:muppetBuilder animated:YES];
    
    [muppetBuilder release];
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    arrayOfSelected = [[NSMutableArray alloc] init];
    tagCount = 1;
    canvasViewController = [CanvasViewController new];
    characterTags = [[NSMutableDictionary alloc] init];
    [canvasContainer addSubview:canvasViewController.view];
    canvasViewController.view.frame = canvasContainer.bounds;
    canvasViewController.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleHeight;
    canvasViewController.canvas.clipsToBounds=YES;

    [canvasViewController.canvas addSubview:canvasObjectLayerControl];
    canvasObjectLayerControl.hidden = YES; 
    canvasObjectLayerControl.center = CGPointMake(50, 50);
    
      
    [save_btn applyTheme];
    [save_picture_btn applyTheme];
    
    
}

- (void)viewDidUnload
{
    [self setCanvasToolBarContainer:nil];
    [self setCanvasContainer:nil];
    [self setSave_btn:nil];
    [self setSave_picture_btn:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)gotoHome:(id)sender{
    [self.navigationController popToRootViewControllerUsingTransition:kCATransitionFade];
}

- (IBAction)gotoGrid:(id)sender{
    [self.navigationController popViewControllerUsingTransition:kCATransitionFade];
}
@end
