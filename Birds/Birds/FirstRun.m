//
//  FirstRun.m
//  Birds
//
//  Created by MacBookPro on 16/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FirstRun.h"

@implementation FirstRun
- (id)init
{
    self = [super init];
    if (self) {
      context = [[AppDelegate getAppDelegate] managedObjectContext];
    }
    
    return self;
}

-(void) loadBirds
{
  Bird  *Type = [NSEntityDescription insertNewObjectForEntityForName:@"Bird" inManagedObjectContext:context];
  Type.id=[NSNumber numberWithInt:45];
  Type.name=@"Blackbird";
  Type.version=[NSNumber numberWithInt:0];
  Type.sex=[NSNumber numberWithInt:0]; //Female=0/Male=1
  Type.age=[NSNumber numberWithInt:0];
  Type.desc=@"You will most likely hear a blackbird before you see it. It sings a varied melody almost constantly. Watch out for it's nests in bushes with their distinctive pale blue speckled eggs.";
  Type.size=[NSNumber numberWithInt:12];
  Type.white=[NSNumber numberWithInt:0];
  Type.black=[NSNumber numberWithInt:0];
  Type.brown=[NSNumber numberWithInt:1];
  Type.black=[NSNumber numberWithInt:0];
  Type.red=[NSNumber numberWithInt:-1];
  Type.green=[NSNumber numberWithInt:-1];
  Type.grey=[NSNumber numberWithInt:-1];
  Type.yellow=[NSNumber numberWithInt:-1];
  Type.blue=[NSNumber numberWithInt:-1];
  Type.spkl=[NSNumber numberWithInt:1];
  Type.food=@"";
  Type.whenwhere=@"Across most of the UK all year round.";
  Type.latin=@"Turdus merula";
    Type.rarity=@"Common";
    Type.category=@"A";
    Type.imageName=@"BlackbirdF_i.jpg";
}

-(NSArray *) loadAllBirds
{

 fetchRequest = [[NSFetchRequest alloc] init];
 entity = [NSEntityDescription entityForName:@"Bird"
                     inManagedObjectContext:context];
 sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"id"
                                              ascending:NO] ;

 sortDescriptors = [NSArray arrayWithObject: sortDescriptor];
 [fetchRequest setSortDescriptors:sortDescriptors];
 [fetchRequest setEntity:entity];
 NSError *error;
 fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
 return fetchedObjects;
}
@end
