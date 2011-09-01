//
//  CharacterView.h
//  MuppetsIphone
//
//  Created by Ayush Goel on 03/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseViewController.h"
@protocol CharacterimageDelegate
- (void)characterSelected:(NSString * )name;
@end



@interface CharacterView : UIBaseViewController 
{
    UITableView *tableView;
    NSDictionary *project ;
     id<CharacterimageDelegate> _delegate;
}
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) id<CharacterimageDelegate> _delegate;
-(IBAction)close;
@end
