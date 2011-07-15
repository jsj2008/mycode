//
//  SearchTable.h
//  TestHarmony
//
//  Created by Ayush Goel on 30/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SearchDelegate
- (void) Selected ;
@end

@interface SearchTable : UITableViewController 
{
    id<SearchDelegate> _delegate;
    
}

@property (nonatomic, assign) id<SearchDelegate> delegate;

@end
