//
//  SplashScreenMoviePlayer.h
//  Muppets
//
//  Created by Gaurav Sharma on 7/13/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface SplashScreenMoviePlayer : UIViewController {
    MPMoviePlayerController *mp;
    NSURL *movieURL;
    id delegate;
}

@property (nonatomic, retain) id delegate;

- (id)initWithPath:(NSString *)moviePath;
- (void)readyPlayer;

@end
