//
//  flatteningViewController.h
//  flattening
//
//  Created by Ayush Goel on 13/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface flatteningViewController : UIViewController {
    UIImageView *mainView;
    UIImageView *firstview;
    UIImageView *secondview;
    UIImage *newImage;
    NSMutableDictionary *dict;
    
    
}
-(void) save;
@end
