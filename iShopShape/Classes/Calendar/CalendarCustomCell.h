//
//  CustomCell.h
//  iShopShape
//
//  Created by Ayush on 20/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CalendarCustomCell : UITableViewCell 
{

	UILabel *titlename;
	UILabel *description;
	UILabel *startdate;
	UILabel *enddate;

}
@property(nonatomic,assign)UILabel *titlename;
@property(nonatomic,assign)UILabel *description;
@property(nonatomic,assign)UILabel *startdate;
@property(nonatomic,assign)UILabel *enddate;

@end
