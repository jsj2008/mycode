

#import <UIKit/UIKit.h>

#import "RootViewController.h"
#import "Items.h"


@protocol AddViewControllerDelegate;


@interface AddViewController : UIViewController {
	
	id <AddViewControllerDelegate> delegate;
	
	BOOL keyboardVisible;
	
	IBOutlet UIScrollView *scrollView;
	IBOutlet UITextField *nameField,*modelField,*brandField,*priceField,*quantityField;
	
	Items *newItem;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, assign) id <AddViewControllerDelegate> delegate;
@property (nonatomic, retain) IBOutlet UITextField *nameField,*modelField,*brandField,*priceField,*quantityField;
@property (nonatomic, retain) Items *newItem;

- (void)keyboardDidShow: (NSNotification*) notif;
- (void)keyboardDidHide: (NSNotification*) notif;
- (IBAction)cancel:(id)sender;
- (IBAction)save: (id)sender;

@end

@protocol AddViewControllerDelegate
- (void)addViewController:(AddViewController *)controller didFinishWithSave:(BOOL)save itemToBeAdded:(Items*)addItem;
@end