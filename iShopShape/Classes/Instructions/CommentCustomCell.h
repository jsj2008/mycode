//
//  CommentCustomCell.h
//  iShopShape
//
//  Created by Santosh B on 11/02/11.
//  Copyright 2011 Cybage. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CommentCustomCell : UITableViewCell 
{
	UILabel *commentTitle;
	UITextView *textView;
}

/**
 *	@functionName	: setCommentsData
 *	@parameters		: (NSString *)comments
 *	@return			: (void)
 *	@description	: set the content of the costum cell with comments details
 */
- (void) setCommentsData: (NSString *)comments;
@end
