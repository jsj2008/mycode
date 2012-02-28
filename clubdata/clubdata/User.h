//
//  User.h
//  clubdata
//
//  Created by MacBookPro on 28/02/12.
//  Copyright (c) 2012 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * bbm;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) NSNumber * color;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * fname;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * lname;
@property (nonatomic, retain) NSString * mobile;

@end
