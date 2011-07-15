

#import <CoreData/CoreData.h>


@interface Items :  NSManagedObject  
{
	NSString *Name,*model,*brand,*price,*quantity;
}

@property (nonatomic, retain) NSString * quantity;
@property (nonatomic, retain) NSString * brand;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSString * Name;
@property (nonatomic, retain) NSString * price;



@end



