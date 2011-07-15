//
//  GuideDetailsScreen.h
//  iShopShape
//
//  Created by Santosh B on 19/01/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Guides.h"

@interface GuideDetailsScreen : UIViewController {
	IBOutlet UITableView *guideDetailsTable;
	Guides *guide;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil guides:(Guides*)aGuide;
@end
