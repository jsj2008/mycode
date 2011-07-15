//
//  BlogAppViewController.h
//  BlogApp
//
//  Created by Ayush Goel on 11/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlogAppViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *myTable; 
    NSMutableDictionary *result;
    UITextField *blogView;
    NSArray *keyArray;
    int selected;
    int first;
    UIButton *save;
}

@end
