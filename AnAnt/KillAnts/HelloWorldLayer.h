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
#import <GameKit/GameKit.h>

#import "GameCenterManager.h"

@class GameCenterManager;
@interface HelloWorldLayer : CCLayerColor<UIActionSheetDelegate, GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate, GameCenterManagerDelegate>
{
    GameCenterManager *gameCenterManager;
    NSMutableArray *_targets;
    NSMutableArray *_projectiles;
    NSMutableArray *_players;
    int _projectilesDestroyed;
    float speedtime;
    float numberOfDustPart;
    float verticalLimit;
    CCSprite *player;
    CCSprite *enemy;
    int totalScore;
    int level;
    NSString* currentLeaderBoard;
    BOOL sleeping;
    
}
@property (nonatomic, retain) NSString *currentLeaderBoard;
@property (nonatomic, retain) GameCenterManager *gameCenterManager;
// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
