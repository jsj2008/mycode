//
//  GridViewViewController.m
//  GridView
//
//  Created by Ayush on 11/05/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GridViewViewController.h"
#import "constant.h"
@implementation GridViewViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	[self.view setBackgroundColor:[UIColor blackColor]];
	buttonArray=[[NSMutableArray alloc]init];
	int norows=itemcount/3+1;
	int count=1;
	for(int row=0;row<norows;row++)
	{
		if(count>itemcount)
			break;
		for(int col=0;col<3;col++)
		{
			
			button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
			button.frame=CGRectMake(margin+100*col,margin+100*row,height,width);
			button.tag=count;
			[button setTitle:[NSString stringWithFormat:@"%d",count-1] forState:UIControlStateNormal];
			[button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
			[self.view addSubview:button];
			[buttonArray addObject:button];
			[button release];
			count++;
			if(count>itemcount)
				break;
		
		}
	}

}

-(void) onButtonClick:(id) sender
{
	UIButton *tempButton = (UIButton *)sender;
	int count=tempButton.tag-1;
	

	[UIButton beginAnimations:nil context:NULL];
	tempButton.hidden=YES;
	[UIButton setAnimationDuration:animationtime];
	[UIButton setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:tempButton cache:NO]; 
	[UIButton commitAnimations];
	
    int  currentButton=count;
	
	int lcol1=[self colNo:count];
	lcol1++;
	
	int firstMove=3-lcol1;
	
	if([buttonArray count]<=3)
	    firstMove=[buttonArray count]-1;
		
	if(count+firstMove>=[buttonArray count]-1)
		firstMove=[buttonArray count]-count-1;
	
	
	for(int iloop=count;iloop<count+firstMove;iloop++)
	{
		
	
		if(currentButton!=[buttonArray count])
		    [buttonArray replaceObjectAtIndex:iloop withObject:[buttonArray objectAtIndex:iloop+1]];
		
		
		tempButton=[buttonArray objectAtIndex:iloop];
		tempButton.tag=tempButton.tag-1;
		[UIView beginAnimations:nil context:NULL];
		[self setAnimation:iloop:0:tempButton];
		 currentButton++;
	}
		

	int looprun =([buttonArray count]-currentButton)/3;
	int lmod=([buttonArray count]-currentButton)%3;
	if(lmod!=0)
		looprun=looprun+1;
	
	count=count+firstMove;

	int zloop=0;
	int animationCounter=0;
	while(zloop<looprun)
	{
	
	  int ldiv=([buttonArray count]-1-currentButton)/3 ;
	  animationCounter++;
	  if(ldiv>=1)
	  {
		  
		for(int iloop=count;iloop<count+3;iloop++)
		{
			
		if(currentButton!=[buttonArray count])
		    [buttonArray replaceObjectAtIndex:iloop withObject:[buttonArray objectAtIndex:iloop+1]];
			
		 tempButton=[buttonArray objectAtIndex:iloop];
		 tempButton.tag=tempButton.tag-1;
		 [UIView beginAnimations:nil context:NULL];
		 [self setAnimation:iloop:animationCounter:tempButton];
		 currentButton++;
		}
		  count=count+3;
	  }
		
	else 
	{

		int remainingMove=[buttonArray count]-count-1;
		for(int iloop=count;iloop<count+remainingMove;iloop++)
		{
			if(currentButton!=[buttonArray count])
				[buttonArray replaceObjectAtIndex:iloop withObject:[buttonArray objectAtIndex:iloop+1]];
			
			tempButton=[buttonArray objectAtIndex:iloop];
			tempButton.tag=tempButton.tag-1;
			[UIView beginAnimations:nil context:NULL];
			[self setAnimation:iloop:animationCounter:tempButton];
			currentButton++;
		}
		
	}
		zloop++;
	}
		[buttonArray removeLastObject];
	
}


-(void) setAnimation :(int) position:(int) AnimationCounter:(UIButton *) tempButton
{
	
	int row=[self rowNo:position];
	int col=[self colNo:position];
	[UIView setAnimationDuration:animationtime+0.3];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDelay:delaytime+(0.3)*AnimationCounter];
	[UIView setAnimationTransition:UIViewAnimationTransitionNone forView:self.view cache:NO]; 
	tempButton.frame=CGRectMake(margin+100*col,margin+100*row,height,width);
	[UIView commitAnimations];
	
}




-(int)colNo:(int ) count
{
	
		return count%3;
	
}

-(int)rowNo:(int ) count
{

		return count/3;
}



/*
// Override to allow orientations other than the default portrait orientation.
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

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	[buttonArray release];
	[button release];
	[super dealloc];
}

@end
