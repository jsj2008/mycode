//
//  CanvasObjectMuppet.h
//  Muppets
//
//  Created by Achal Aggarwal on 04/07/11.
//  Copyright 2011 NA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CanvasObject.h"
#import "Muppet.h"

@interface CanvasObjectMuppet : CanvasObject {
    UIImageView *head;
    UIImageView *body;
    UIImageView *eyes;
    UIImageView *shirt;
    UIImageView *mouth;
    
    NSString *speech;
    
    Muppet *muppet;
    
    BOOL _mouthOpen;
    BOOL _speaking;
}

@property (nonatomic, retain) Muppet *muppet;
@property (nonatomic, retain) NSString *speech;

-(void) update;

- (void)startSpeaking;
- (void)stopSpeaking;


@end
