//
//  MainViewController.h
//  PortraitGraph
//
//  Created by Seb Kade on 6/05/10.
//  Copyright 2010 SKADE Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphView.h"

@interface MainViewController : UIViewController {
	GraphView *myGraph;
}

@property (nonatomic, retain) GraphView *myGraph;

-(id) initWithFrame:(CGRect )frame;

@end
