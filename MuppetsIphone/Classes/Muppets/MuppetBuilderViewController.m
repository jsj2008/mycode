//
//  MuppetBuilderViewController.m
//  Muppets
//
//  Created by Gaurav Sharma on 7/5/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "MuppetBuilderViewController.h"
#import "MuppetFeatureDataProvider.h"

@interface MuppetBuilderViewController (private)

- (void)loadMuppet;

@end


@implementation MuppetBuilderViewController
@synthesize body;
@synthesize face;
@synthesize hair;
@synthesize shirt;
@synthesize pant;
@synthesize mouth;

@synthesize background;

@synthesize faceImageName;
@synthesize hairImageName;
@synthesize shirtImageName;
@synthesize pantImageName;


@synthesize canvasObjectMuppet;

- (id)init {
    self = [super initWithNibName:@"MuppetBuilderView" bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [body release];
    [face release];
    [hair release];
    [shirt release];
    [pant release];
    [mouth release];
    
    [background release];
    
    [faceImageName release];
    [hairImageName release];
    [shirtImageName release];
    [pantImageName release];
    [super dealloc];
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
        
    if (!muppetFeatureDataProviderPopup) {
        muppetFeatureDataProvider = [MuppetFeatureDataProvider new];
        muppetFeatureDataProvider.delegate = self;
        UINavigationController *_navigationController = [[UINavigationController alloc] initWithRootViewController:muppetFeatureDataProvider];
        //[muppetFeatureDataProvider view];
        muppetFeatureDataProviderPopup = [[UIPopoverController alloc] initWithContentViewController:_navigationController];
    }
}

- (void)viewDidUnload
{
    [muppetFeatureDataProvider release];
    [muppetFeatureDataProviderPopup release];
    [self setBody:nil];
    [self setFace:nil];
    [self setHair:nil];
    [self setShirt:nil];
    [self setPant:nil];
    [self setMouth:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)loadMuppet{
    [self view];
    [shirt setImage:[UIImage imageNamed:[canvasObjectMuppet.muppet shirt]]];
    [hair setImage:[UIImage imageNamed:[canvasObjectMuppet.muppet head]]];
    [face setImage:[UIImage imageNamed:[canvasObjectMuppet.muppet eyes]]];
    [pant setImage:[UIImage imageNamed:[canvasObjectMuppet.muppet body]]];
    
    shirtImageName = [canvasObjectMuppet.muppet shirt];
    hairImageName  = [canvasObjectMuppet.muppet head];
    faceImageName  = [canvasObjectMuppet.muppet eyes];
    pantImageName  = [canvasObjectMuppet.muppet body];
    
    muppetView.transform = [canvasObjectMuppet transform];
    muppetView.center = [canvasObjectMuppet center];
}

- (IBAction)pickHair:(UIButton *)sender {
    [muppetFeatureDataProvider loadFeature:MuppetFeatureTypeHair];
    [muppetFeatureDataProviderPopup presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

- (IBAction)pickFace:(UIButton *)sender {
    [muppetFeatureDataProvider loadFeature:MuppetFeatureTypeFace];
    [muppetFeatureDataProviderPopup presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
}

- (IBAction)pickShirt:(UIButton *)sender {
    [muppetFeatureDataProviderPopup presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    [muppetFeatureDataProvider loadFeature:MuppetFeatureTypeShirt];
}

- (IBAction)pickPant:(UIButton *)sender {
    [muppetFeatureDataProviderPopup presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
    [muppetFeatureDataProvider loadFeature:MuppetFeatureTypePant];
}

- (void)featureChanged:(MuppetFeatureType)aFeatureType withResource:(NSString *)resourceName{
    switch (aFeatureType) {
        case MuppetFeatureTypeHair:
            hairImageName = resourceName;
            hair.image = [UIImage imageNamed:resourceName];
            break;
        case MuppetFeatureTypeFace:
            faceImageName = resourceName;
            face.image = [UIImage imageNamed:resourceName];
            break;    
        case MuppetFeatureTypeShirt:
            shirtImageName = resourceName;
            shirt.image = [UIImage imageNamed:resourceName];
            break;    
        case MuppetFeatureTypePant:
            pantImageName = resourceName;
            pant.image = [UIImage imageNamed:resourceName];
            break;    
    }
}

- (IBAction)done:(id)sender {
    Muppet *_muppet = [canvasObjectMuppet muppet];
    [_muppet setShirt:shirtImageName];
    [_muppet setHead:hairImageName];
    [_muppet setEyes:faceImageName];
    [_muppet setBody:pantImageName];
    [_muppet save];
    CGAffineTransform _t = canvasObjectMuppet.transform;
    [canvasObjectMuppet update];
    [canvasObjectMuppet setTransform:_t];
    [super dismissModalViewControllerAnimated:YES];
}

- (IBAction)cancel:(id)sender {
    [super dismissModalViewControllerAnimated:YES];
}
@end
