//
//  HelloWorldLayer.m
//  Cocos2DSimpleGame
//
//  Created by Manish on 21/07/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"
#import "GameOverScene.h"
// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	
	CCScene *scene = [CCScene node];
	
	
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	
	[scene addChild: layer];
	
	
	return scene;
}





-(void)addTarget {
    
    CCSprite *target = [CCSprite spriteWithFile:@"ant.png" 
                                           rect:CGRectMake(0, 0, 27, 40)]; 
    

    CGSize winSize = [[CCDirector sharedDirector] winSize];
    int minY = target.contentSize.height/2;
    int maxY = winSize.height - target.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    target.position = ccp(winSize.width + (target.contentSize.width/2), actualY);
    [self addChild:target];
    
 
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random() % rangeDuration) + minDuration;
    
    // Create the actions
    id actionMove = [CCMoveTo actionWithDuration:actualDuration 
                                        position:ccp(-target.contentSize.width/2, actualY)];
    id actionMoveDone = [CCCallFuncN actionWithTarget:self 
                                             selector:@selector(spriteMoveFinished:)];
    [target runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
    target.tag = 1;
    [_targets addObject:target];
}
-(id) init
{
    if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
        _targets = [[NSMutableArray alloc] init];
        _projectiles = [[NSMutableArray alloc] init];
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        player = [CCSprite spriteWithFile:@"man.png" 
                                               rect:CGRectMake(0, 0, 27, 40)];
        player.position = ccp(player.contentSize.width/2, winSize.height/2);
        [self addChild:player];	
        self.isTouchEnabled = YES;
        [self schedule:@selector(gameLogic:) interval:3.0];
        
    }
   
    return self;
}
-(void)gameLogic:(ccTime)dt 
{
    [self addTarget];
}


-(void)spriteMoveFinished:(id)sender 
{
    CCSprite *sprite = (CCSprite *)sender;
   // [self removeChild:sprite cleanup:YES];
    if (sprite.tag == 1)
    { 
        NSLog(@"location ant== %f",sprite.position.y);
        NSLog(@"player location== %f",player.position.y);
    
        if((player.position.y<=sprite.position.y+15)&&(player.position.y>=sprite.position.y-15))
           NSLog(@"main jeet gayaa");
        else 
        {
         NSLog(@"You looser");
            [self removeChild:sprite cleanup:YES];
        [_targets removeObject:sprite];
         GameOverScene *gameOverScene = [GameOverScene node];
        [gameOverScene.layer.label setString:@"You Lose :["];
        [[CCDirector sharedDirector] replaceScene:gameOverScene];
        }
        
    } 
    else if (sprite.tag == 3) { // projectile
        NSLog(@"do nothing");
    }
    
    
}


- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Choose one of the touches to work with
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
 //    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
   
    player.tag=0;
    int RealX =player.position.x;
    int RealY = location.y;
    CGPoint realDest = ccp(RealX, RealY);
    [player runAction:[CCSequence actions:
                           [CCMoveTo actionWithDuration:0.2 position:realDest],
                           [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                           nil]];

    /*
    CCSprite *projectile = [CCSprite spriteWithFile:@"fire.png" 
                                               rect:CGRectMake(0, 0, 20, 20)];
    projectile.position = ccp(20, winSize.height/2);
    
    // Determine offset of location to projectile
    int offX = location.x - projectile.position.x;
    int offY = location.y - projectile.position.y;
    
    // Bail out if we are shooting down or backwards
    if (offX <= 0) return;
    
    // Ok to add now - we've double checked position
    [self addChild:projectile];
    
    // Determine where we wish to shoot the projectile to
    int realX = winSize.width + (projectile.contentSize.width/2);
    float ratio = (float) offY / (float) offX;
    int realY = (realX * ratio) + projectile.position.y;
    CGPoint realDest = ccp(realX, realY);
    
    // Determine the length of how far we're shooting
    int offRealX = realX - projectile.position.x;
    int offRealY = realY - projectile.position.y;
    float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
    float velocity = 480/1; // 480pixels/1sec
    float realMoveDuration = length/velocity;
    
    // Move projectile to actual endpoint
    [projectile runAction:[CCSequence actions:
                           [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
                           [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                           nil]];
    projectile.tag = 2;
    [_projectiles addObject:projectile];*/
    
}

- (void) dealloc
{
    
    [_targets release];
    _targets = nil;
    [_projectiles release];
    _projectiles = nil;
	[super dealloc];
}
@end
