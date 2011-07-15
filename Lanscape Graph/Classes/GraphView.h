//
//  GraphView.h
//  iJumpPrototype
//
//  Created by Seb Kade on 6/05/10.
//  Copyright 2010 SKADE Development. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GraphView : UIView {

}

-(void) addPoint:(float )point;
-(void) reset;
-(void) collectionFinished;
-(void) createTestData;
-(void) calculateDistance;

@end
