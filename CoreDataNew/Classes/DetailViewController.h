

#import <UIKit/UIKit.h>
#import "Items.h"

@interface DetailViewController : UIViewController {
	IBOutlet UILabel *nameLabel,*modelLabel,*brandLabel,*priceLabel,*quantityLabel;
	Items *itemDetail;
	NSString *iName;
}
@property (nonatomic,retain) IBOutlet UILabel *nameLabel,*modelLabel,*brandLabel,*priceLabel,*quantityLabel;
@property (nonatomic,retain) Items *itemDetail;
@property (nonatomic, retain) NSString *iName;
@end
