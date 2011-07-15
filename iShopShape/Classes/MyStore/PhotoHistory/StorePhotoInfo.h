//
//  StoreInfo.h
//  Community
//
//  Created by sujeet on 20/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StorePhotoInfo : NSObject {
	
	NSString *storeName;
	NSMutableArray *photohistoryArray;	//arry of storeimageobj

}
@property(nonatomic,retain) NSString *storeName;
@property (nonatomic, retain)NSMutableArray *photohistoryArray;

-(id)initWithStoreName:(NSString *)storename withPhotoHistory:(NSMutableArray *)photohistory;

@end
