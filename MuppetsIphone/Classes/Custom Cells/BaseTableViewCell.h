//
//  DraggableTableViewCell.h
//  Muppets
//
//  Created by Gaurav Sharma on 6/24/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell <UIGestureRecognizerDelegate> {
    UIImageView *imageView;
    UILabel *label;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UILabel *label;

- (void)setSourceData:(NSDictionary *)data;

@end
