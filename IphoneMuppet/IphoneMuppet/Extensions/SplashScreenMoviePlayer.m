//
//  SplashScreenMoviePlayer.m
//  Muppets
//
//  Created by Gaurav Sharma on 7/13/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "SplashScreenMoviePlayer.h"


@implementation SplashScreenMoviePlayer

@synthesize delegate;

/*---------------------------------------------------------------------------
 * 
 *--------------------------------------------------------------------------*/
- (id)initWithPath:(NSString *)moviePath
{
	// Initialize and create movie URL
    self = [super init];
    if (self)
    {
        movieURL = [NSURL fileURLWithPath:moviePath];    
        [movieURL retain];
    }
	return self;
}

/*---------------------------------------------------------------------------
 * For 3.2 and 4.x devices
 * For 3.1.x devices see moviePreloadDidFinish:
 *--------------------------------------------------------------------------*/
- (void) moviePlayerLoadStateChanged:(NSNotification*)notification 
{
	// Unless state is unknown, start playback
	if ([mp loadState] != MPMovieLoadStateUnknown)
    {
        // Remove observer
        [[NSNotificationCenter 	defaultCenter] 
         removeObserver:self
         name:MPMoviePlayerLoadStateDidChangeNotification 
         object:nil];
        
		// Set frame of movieplayer
		[[mp view] setFrame:self.view.bounds];
        
        // Add movie player as subview
        [[self view] addSubview:[mp view]];   
        
		// Play the movie
		[mp play];
	}
}

/*---------------------------------------------------------------------------
 * For 3.1.x devices
 * For 3.2 and 4.x see moviePlayerLoadStateChanged: 
 *--------------------------------------------------------------------------*/
- (void) moviePreloadDidFinish:(NSNotification*)notification 
{
	// Remove observer
	[[NSNotificationCenter 	defaultCenter] 
     removeObserver:self
     name:MPMoviePlayerContentPreloadDidFinishNotification
     object:nil];
    
	// Play the movie
 	[mp play];
}

/*---------------------------------------------------------------------------
 * 
 *--------------------------------------------------------------------------*/
- (void) moviePlayBackDidFinish:(NSNotification*)notification 
{    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
 	// Remove observer
    [[NSNotificationCenter 	defaultCenter] 
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification 
     object:nil];
    
    if ([delegate respondsToSelector:@selector(moviePlayBackDidFinish)]) {
        [delegate performSelector:@selector(moviePlayBackDidFinish)];
    }
}

/*---------------------------------------------------------------------------
 *
 *--------------------------------------------------------------------------*/
- (void) readyPlayer
{
 	mp =  [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    
    if ([mp respondsToSelector:@selector(loadState)]) 
    {
        // Set movie player layout
        [mp setControlStyle:MPMovieControlStyleNone];
        [mp setFullscreen:YES];
        
		// May help to reduce latency
		[mp prepareToPlay];
        
		// Register that the load state changed (movie is ready)
		[[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(moviePlayerLoadStateChanged:) 
                                                     name:MPMoviePlayerLoadStateDidChangeNotification 
                                                   object:nil];
	}  
    else
    {
        // Register to receive a notification when the movie is in memory and ready to play.
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(moviePreloadDidFinish:) 
                                                     name:MPMoviePlayerContentPreloadDidFinishNotification 
                                                   object:nil];
    }
    
    // Register to receive a notification when the movie has finished playing. 
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(moviePlayBackDidFinish:) 
                                                 name:MPMoviePlayerPlaybackDidFinishNotification 
                                               object:nil];
}

/*---------------------------------------------------------------------------
 * 
 *--------------------------------------------------------------------------*/
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return kSupportedOrientations;
}


/*---------------------------------------------------------------------------
 *  
 *--------------------------------------------------------------------------*/
- (void)dealloc 
{
//    [delegate release];
	[mp release];
    [movieURL release];
	[super dealloc];
}

@end
