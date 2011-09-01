//
//  BaseDataProvider.h
//  Muppets
//
//  Created by Gaurav Sharma on 6/24/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BaseDataProvider : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    NSArray *data;
    UITableView *tableView;
    UIView *rootView;
}

@property (nonatomic, retain) NSArray *data;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, assign) UIView *rootView;

@end
