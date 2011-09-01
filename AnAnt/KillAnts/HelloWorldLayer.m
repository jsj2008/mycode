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
#import "AppSpecificValues.h"
#import "GameCenterManager.h"
#import "GameStartLayer.h"

// HelloWorldLayer implementation

@implementation HelloWorldLayer
@synthesize gameCenterManager;
@synthesize currentLeaderBoard;
+(CCScene *) scene
{
	
	CCScene *scene = [CCScene node];
	
	
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
    [scene addChild: layer];
	
	
	return scene;
}


-(void)spriteMoveFinished:(id)sender {
    CCSprite *sprite = (CCSprite *)sender;
    if(sprite.tag == 3)
    {
        NSLog(@"sprite for player");
        return;
    }
    [self removeChild:sprite cleanup:YES];
    if (sprite.tag == 1) { // target
        [_targets removeObject:sprite];
        GameOverScene *gameOverScene = [GameOverScene node];
        [gameOverScene.layer.label setString:@"You Lose :["];
        [[CCDirector sharedDirector] replaceScene:gameOverScene];

    } else if (sprite.tag == 2) { // projectile
        [_projectiles removeObject:sprite];
    }
    
    
}
-(void)addTarget {
    
    CCSprite *target = [CCSprite spriteWithFile:@"ant.png" 
                                           rect:CGRectMake(0, 0, 27, 40)]; 
    
    // Determine where to spawn the target along the Y axis
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    int minX = target.contentSize.width/2;
    int maxX = winSize.width - target.contentSize.width/2;
    int rangeX = maxX - minX;
    int actualX = (arc4random() % rangeX) + minX;
    
    
    
    
    // Create the target slightly off-screen along the right edge,
    // and along a random position along the Y axis as calculated above
    target.position = ccp( actualX,winSize.height + (target.contentSize.height/2));
    
     //  id eactionMove = [CCMoveTo actionWithDuration:actualDuration 
   //                                     position:ccp(actualY,enemy.position.y)];
    id FadeinAction = [CCFadeIn actionWithDuration:0.5];
    //[target runAction:[CCSequence actions:FadeinAction, nil]];
   // [enemy runAction:[CCSequence actions:eactionMove, nil, nil]];
    id placeTargetAction = [CCPlace actionWithPosition:target.position];
    id actionMove = [CCMoveTo actionWithDuration:0 
                                        position:ccp(actualX,winSize.height - (target.contentSize.height))];
    
    [self addChild:target];
    
    [target runAction:[CCSequence actions:placeTargetAction,actionMove,FadeinAction, nil]];
   

    [self performSelector:@selector(move:) withObject:target afterDelay:1];
    // Determine speed of the target
    
   
}
-(void)move:(id)sender
{
    CCSprite *target = sender;
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    int minY = target.contentSize.width/2;
    int maxY = winSize.width - target.contentSize.width/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    
    int minDuration = 2.0;
    int maxDuration = 4.0;
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = 0.5;
    actualDuration = (arc4random() % rangeDuration) + minDuration+speedtime;
    // Create the actions
   
    id actionMove = [CCMoveTo actionWithDuration:actualDuration 
                                        position:ccp(actualY,-target.contentSize.height/2)];
    id actionMoveDone = [CCCallFuncN actionWithTarget:self 
                                             selector:@selector(spriteMoveFinished:)];
    [target runAction:[CCSequence actions:actionMove, actionMoveDone, nil]];
    target.tag = 1;
    [_targets addObject:target];
}
-(id) init
{
    self.currentLeaderBoard = kLeaderboardID;
    if ([GameCenterManager isGameCenterAvailable]) {
        
        self.gameCenterManager = [[[GameCenterManager alloc] init] autorelease];
        [self.gameCenterManager setDelegate:self];
        [self.gameCenterManager authenticateLocalUser];
        
        
        
    } else {
        
        // The current device does not support Game Center.
        UIAlertView *alertNoGC = [[UIAlertView alloc] initWithTitle:@"NO GameCenter" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertNoGC show];
        [alertNoGC release];
        
    }
    if( (self=[super initWithColor:ccc4(255,255,255,255)] )) {
        sleeping = NO;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCMenuItem *pauseMenuItem = [CCMenuItemImage 
                                    itemFromNormalImage:@"pause.png" selectedImage:@"pause-selected.png" 
                                    target:self selector:@selector(pauseButtonTapped:)];
        pauseMenuItem.position = ccp(winSize.width-30, winSize.height-30);
        CCMenu *starMenu = [CCMenu menuWithItems:pauseMenuItem, nil];
        starMenu.position = CGPointZero;
        [self addChild:starMenu];

        _targets = [[NSMutableArray alloc] init];
        _projectiles = [[NSMutableArray alloc] init];
        _players = [[NSMutableArray alloc] init];
        numberOfDustPart = 4.0;
        speedtime=4.0;
        verticalLimit = 3.0;
        level = 1;
        totalScore = 0;
        
        player = [CCSprite spriteWithFile:@"man.png" 
                                               rect:CGRectMake(0, 0, 27, 40)];
        player.position = ccp(winSize.width/2, winSize.height/3);
        
        //enemy = [CCSprite spriteWithFile:@"man.png" 
        //                             rect:CGRectMake(0, 0, 27, 40)];
        //enemy.position = ccp(winSize.width/2, winSize.height -20);
        [self addChild:player];	
        //[self addChild:enemy];
        self.isTouchEnabled = YES;
      //  [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background-music-aac.caf"];
       // [[SimpleAudioEngine sharedEngine] playEffect:@"pew-pew-lei.caf"];
        [self schedule:@selector(update:)];
        //[self schedule:@selector(gameLogic:) interval:1.0];
        [self performSelector:@selector(gameLogic:)];
    }
   
    
    return self;
}
- (void)pauseButtonTapped:(id)sender {
    
    NSLog(@"pauseButtonTapped");
    if(sleeping)
    {
        sleeping = NO;
        
       [[CCDirector sharedDirector] resume];
    }
    else
    {
        sleeping = YES;

        [[CCDirector sharedDirector] pause];
        UIAlertView* dialog = [[UIAlertView alloc] init];
        [dialog setDelegate:self];
        [dialog setTitle:@"Dust Fairy"];
        [dialog setMessage:@"Your game record or equipment will be lost. \nDo you want to exit?"];
        [dialog addButtonWithTitle:@"Yes"];
        [dialog addButtonWithTitle:@"No"];
        [dialog show];
        [dialog release];
        
        
    }
    
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
       [[CCDirector sharedDirector] replaceScene:[GameStartLayer scene]];
    else
    {
        sleeping = NO;
        
        [[CCDirector sharedDirector] resume];
    }
}
-(void)gameLogic:(ccTime)dt {
   
    [self addTarget];
    [self performSelector:@selector(gameLogic:) withObject:nil afterDelay:numberOfDustPart];
}
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Choose one of the touches to work with
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    int realX = location.x;
    
    int realY = location.y;
    if(realY>=winSize.height/3)
        realY=winSize.height/3;
    NSLog(@"realy== %d",realY);
    CGPoint realDest = ccp(realX, realY);
    
    player.tag =3;

    [player runAction:[CCSequence actions:
                       [CCMoveTo actionWithDuration:0.5 position:realDest],
                       [CCCallFuncN actionWithTarget:self selector:@selector(spriteMoveFinished:)],
                       nil]];
    
    [_players addObject:player];
   
    
}
- (void) achievementSubmitted: (GKAchievement*) ach error:(NSError*) error;
{
    
    if((error == NULL) && (ach != NULL))
    {
        if (ach.percentComplete == 100.0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Achievement Earned!"
                                                            message:(@"%@",ach.identifier)
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
    }
    else
    {
        // Achievement Submission Failed.
        
    }
    
}
- (void) checkAchievements
{
    NSString* identifier = NULL;
    double percentComplete = 0;
    switch(totalScore)
    {
        case 10:
        {
            identifier= kAchievementGotOneThousand;
            percentComplete= 100.0;
            break;
        }
                 
    }
    if(identifier!= NULL)
    {
        [self.gameCenterManager submitAchievement: identifier percentComplete: percentComplete];
    }
}
- (void)update:(ccTime)dt {
       
    for (CCSprite *player in _players) {
        CGRect playerRect = CGRectMake(
                                           player.position.x - (player.contentSize.width/2), 
                                           player.position.y - (player.contentSize.height/2), 
                                           player.contentSize.width, 
                                           player.contentSize.height);
        
        NSMutableArray *targetsToDelete = [[NSMutableArray alloc] init];
        for (CCSprite *target in _targets) {
            CGRect targetRect = CGRectMake(
                                           target.position.x - (target.contentSize.width/2), 
                                           target.position.y - (target.contentSize.height/2), 
                                           target.contentSize.width, 
                                           target.contentSize.height);
            
            if (CGRectIntersectsRect(playerRect, targetRect)) {
                [targetsToDelete addObject:target];				
            }						
        }
        
        for (CCSprite *target in targetsToDelete) {
            [_targets removeObject:target];
            [self removeChild:target cleanup:YES];	
            _projectilesDestroyed++;
            totalScore+=level;
            if (_projectilesDestroyed > 3) {
                level++;
                _projectilesDestroyed = 0;
                speedtime-=0.3;
                numberOfDustPart-=0.3;
                verticalLimit+=0.3;
                if(speedtime <=0 || numberOfDustPart <=0)
                {
                GameOverScene *gameOverScene = [GameOverScene node];
                [gameOverScene.layer.label setString:[NSString stringWithFormat:@"You Win! Your Score is %d",_projectilesDestroyed]];
                _projectilesDestroyed = 0;
                [[CCDirector sharedDirector] replaceScene:gameOverScene];
                    speedtime = 4.0f;
                    numberOfDustPart = 4.0f;
                    verticalLimit = 3.0f;
                }
            }
        }
        
            [targetsToDelete release];
    }
    
   
}

- (void) dealloc
{
     [currentLeaderBoard release];
    [gameCenterManager release];
    [_targets release];
    _targets = nil;
    [_projectiles release];
    _projectiles = nil;
	[super dealloc];
}
@end
