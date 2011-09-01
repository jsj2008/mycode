//
//  FirstViewControllerDetails_iPhone.h
//  UniversalApp
//
//  Created by Santosh B on 22/03/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FirstViewControllerDetails_iPhone : UIViewController {
    
    UILabel *myTitle;
    UIView *myView;
}
@property (nonatomic, retain) IBOutlet UILabel *myTitle;
@property (nonatomic, retain) IBOutlet UIView *myView;

@end
