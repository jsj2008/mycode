//
//  FirstRun.h
//  Birds
//
//  Created by MacBookPro on 16/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Bird.h"

@interface FirstRun : NSObject
{
    NSManagedObjectContext *context;
    NSFetchRequest *fetchRequest;
    NSEntityDescription *entity;
    NSPredicate *predicate ;   
    NSArray *fetchedObjects;
    NSSortDescriptor * sortDescriptor;
    NSArray * sortDescriptors;
    

}

-(void) loadBirds;
-(NSArray *) loadAllBirds;

@end
