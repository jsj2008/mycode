

#import "AddViewController.h"


@implementation AddViewController

@synthesize delegate;
@synthesize scrollView;
@synthesize nameField,modelField,brandField,priceField,quantityField,newItem;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
 // Custom initialization
 }
 return self;
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"New Item";
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem
											   alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
											  target:self action:@selector(cancel:)] autorelease];
	self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem
												alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
											   target:self action:@selector(save:)] autorelease];
	self.editing = YES;
	
}

- (void)viewWillAppear: (BOOL)animated {
	[super viewWillAppear:animated];
	// Registering for keyboard events.
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:)name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:)name:UIKeyboardDidHideNotification object:nil];
	// Initially the keyboard is hidden, so reset our variable.
	keyboardVisible = NO;
	
}

- (void)viewWillDisappear:(BOOL)animated {
	// Unregistering for keyboard events.
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)keyboardDidShow:(NSNotification *)notif {
	if (keyboardVisible) {
		// Keyboard is already visible. Ignoring notification.
		return;
	}
	// Resizing smaller for keyboard.
	NSDictionary* info = [notif userInfo];
	NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
	CGSize keyboardSize = [aValue CGRectValue].size;
	CGRect viewFrame = self.view.frame;
	viewFrame.size.height -= keyboardSize.height;
	[scrollView setFrame:CGRectMake(0, 0, 320, 200)];
	[scrollView setContentSize:CGSizeMake(320,400)];
	keyboardVisible = YES;	
}
- (void)keyboardDidHide:(NSNotification *)notif {
	if (!keyboardVisible) {
		// Keyboard already hidden. Ignoring notification.
		return;
	}
	// Resizing bigger with no keyboard 
	NSDictionary* info = [notif userInfo];
	NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
	CGSize keyboardSize = [aValue CGRectValue].size;
	CGRect viewFrame = self.view.frame;
	viewFrame.size.height += keyboardSize.height;
	scrollView.frame = CGRectMake(viewFrame.origin.x,viewFrame.origin.y,viewFrame.size.width,
								  viewFrame.size.height);
	keyboardVisible = NO;	
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


- (IBAction)cancel:(id)sender {
	[self dismissModalViewControllerAnimated:YES];
}

- (IBAction)save:(id)sender {
	// Save Button Pressed.
	if (delegate) {
		NSString *newItemName = [NSString stringWithFormat:@"%@",nameField.text];
		[newItem setName:newItemName];
		[newItem setModel:modelField.text];
		[newItem setBrand:brandField.text];
		[newItem setPrice:priceField.text];
		[newItem setQuantity:quantityField.text];
		[delegate addViewController:self didFinishWithSave:YES itemToBeAdded:newItem];
		[newItem release];
		
	}
	
}

@end
