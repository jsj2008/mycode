//
//  FirstViewController_iPad.h
//  UniversalApp
//
//  Created by Santosh B on 18/03/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewController_iPad : UIViewController {
    
    UITableView *listTableView;
}
@property (nonatomic, retain) IBOutlet UITableView *listTableView;


- (void)my;
@end
