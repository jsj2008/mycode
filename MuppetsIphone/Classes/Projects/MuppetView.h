//
//  MuppetView.h
//  MuppetsIphone
//
//  Created by Ayush Goel on 03/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseViewController.h"

@protocol MuppetimageDelegate
- (void)muppetSelected:(NSString * )name;
@end

@interface MuppetView : UIBaseViewController {
        UITableView *tableView;
        NSDictionary *project ;
     id<MuppetimageDelegate> _delegate;
}
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) id<MuppetimageDelegate> _delegate;
-(IBAction)close;
@end
