//
//  Bird.h
//  Birds
//
//  Created by MacBookPro on 16/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Bird : NSManagedObject

@property (nonatomic, retain) NSNumber * age;
@property (nonatomic, retain) NSNumber * black;
@property (nonatomic, retain) NSNumber * blue;
@property (nonatomic, retain) NSNumber * brown;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * food;
@property (nonatomic, retain) NSNumber * green;
@property (nonatomic, retain) NSNumber * grey;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) NSString * latin;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * rarity;
@property (nonatomic, retain) NSNumber * red;
@property (nonatomic, retain) NSNumber * sex;
@property (nonatomic, retain) NSNumber * size;
@property (nonatomic, retain) NSNumber * spkl;
@property (nonatomic, retain) NSNumber * version;
@property (nonatomic, retain) NSString * whenwhere;
@property (nonatomic, retain) NSNumber * white;
@property (nonatomic, retain) NSNumber * yellow;

@end
