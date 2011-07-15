

#import "DetailViewController.h"
#import "Items.h"

@implementation DetailViewController

@synthesize nameLabel,modelLabel,brandLabel,priceLabel,quantityLabel,itemDetail,iName;





// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
    [super viewDidLoad];
	nameLabel.text = itemDetail.Name;
	modelLabel.text = itemDetail.model;
	brandLabel.text = itemDetail.brand;
	priceLabel.text = itemDetail.price;
	quantityLabel.text = itemDetail.quantity;
}


/*
 // Override to allßow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) viewWillAppear: (BOOL)animated {
	[super viewWillAppear:animated];
	
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[nameLabel release];
	[modelLabel release];
	[brandLabel release];
	[priceLabel release];
	[quantityLabel release];
	[itemDetail release];
    [super dealloc];
}


@end
