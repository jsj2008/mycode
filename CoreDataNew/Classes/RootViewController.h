

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DetailViewController.h"
#import "AddViewController.h"

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate,UISearchBarDelegate ,UISearchDisplayDelegate>{
	
@private
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
	NSManagedObjectContext *addingManagedObjectContext;	    
	Items *selectedObject;
	IBOutlet UISearchBar *mySearchBar;
	//IBOutlet UITableView *tableView;
	NSMutableArray *filteredListContent,*listContent;
	BOOL searchWasActive,dataFound;
}

@property (nonatomic, retain) Items *selectedObject;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *addingManagedObjectContext;	
@property (nonatomic, retain) IBOutlet UISearchBar *mySearchBar;
@property (nonatomic, retain) NSMutableArray *filteredListContent;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSMutableArray *listContent;

@property (nonatomic) BOOL searchWasActive,dataFound;

@end
