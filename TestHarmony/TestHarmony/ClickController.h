//
//  ColorPickerController.h
//  MathMonsters
//
//  Created by Ray Wenderlich on 5/3/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorPickerDelegate
- (void)colorSelected:(NSString * )name;
@end


@interface ClickController : UITableViewController {
   
    NSMutableArray *myarray;
    id<ColorPickerDelegate> _delegate;
     int count;
}

@property (nonatomic, retain) NSMutableArray *myarray;

@property (nonatomic, assign) id<ColorPickerDelegate> delegate;


@end
