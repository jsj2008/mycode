//
//  HelloWorldLayer.h
//  Cocos2DSimpleGame
//
//  Created by Manish on 21/07/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


#import "cocos2d.h"

// HelloWorldLayer
/*@interface HelloWorldLayer : CCLayer
{
}*/
@interface HelloWorldLayer : CCLayerColor
{
    CCSprite *player;
    NSMutableArray *_targets;
    NSMutableArray *_projectiles;
    int _projectilesDestroyed;
}
// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
