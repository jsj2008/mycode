//
//  HomeViewController.h
//  MuppetsIphone
//
//  Created by Manish on 27/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBaseViewController.h"


@interface HomeViewController : UIBaseViewController {
    UIButton *charactersButton;
    UIButton *occasionsButton;
    UIButton *projectsButton;
    UIButton *muppetMakerButton;
}
@property (nonatomic, retain) IBOutlet UIButton *charactersButton;
@property (nonatomic, retain) IBOutlet UIButton *occasionsButton;
@property (nonatomic, retain) IBOutlet UIButton *projectsButton;
@property (nonatomic, retain) IBOutlet UIButton *muppetMakerButton;

- (IBAction)showOccasions:(id)sender;
- (IBAction)showCharacters:(id)sender;
- (IBAction)showProjects:(id)sender;
- (IBAction)showMuppetMaker:(id)sender;

@end
