//
//  GameStartLayer.m
//  KillAnt
//
//  Created by Vinsol on 03/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameStartLayer.h"
#import "HelloWorldLayer.h"
#import "GameCenterManager.h"
#import "AppSpecificValues.h"
@implementation GameStartLayer

+(CCScene *) scene
{
	
	CCScene *scene = [CCScene node];
	
	
	GameStartLayer *layer = [GameStartLayer node];
	
	
	[scene addChild: layer];
	
	
	return scene;
}

-(id) init
{
        if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCMenuItem *pauseMenuItem = [CCMenuItemImage 
                                     itemFromNormalImage:@"pause.png" selectedImage:@"pause-selected.png" 
                                     target:self selector:@selector(gameStartDone)];
        pauseMenuItem.position = ccp(winSize.width/2, winSize.height/2);
        CCMenu *starMenu = [CCMenu menuWithItems:pauseMenuItem, nil];
        starMenu.position = CGPointZero;
        [self addChild:starMenu];
}
    
    
    return self;
}

- (void)gameStartDone {
    
    [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer scene]];
    
}

@end
