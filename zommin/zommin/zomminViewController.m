//
//  zomminViewController.m
//  zommin
//
//  Created by Ayush Goel on 18/07/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "zomminViewController.h"

@implementation zomminViewController

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    imagescroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,768,950)];
   // [imagescroll setBackgroundColor:[UIColor grayColor]];
    imagescroll.contentSize=CGSizeMake(768,950);
    [self.view addSubview:imagescroll];
    [imagescroll release];
    
    mySlider=[[UISlider alloc]initWithFrame:CGRectMake(550,980,200, 20)];
    [self.view addSubview:mySlider];
    [mySlider release];
    
    mySlider.enabled=YES;
    mySlider.minimumValue=1;
    mySlider.maximumValue=2;
    mySlider.continuous = YES;
    [mySlider addTarget:self action:@selector(sliderMove:) forControlEvents:UIControlEventValueChanged];
  //  [mySlider addTarget:self action:@selector(sliderMove:) forControlEvents:UIControlEventTouchUpInside];
    
    
    imageArray=[[NSMutableArray alloc]init];
    
    for(int i=0;i<3;i++)
    {
        for(int j=0;j<3;j++)
        {
            myView=[[UIImageView alloc]initWithFrame:CGRectMake(20+j*250,40+i*250,200,200)];
        //    NSLog(@"origin x== %d",20+j*250);
            myView.image=[UIImage imageNamed:@"a1.jpeg"];
            [imagescroll addSubview:myView];
            [imageArray addObject:myView];
            [myView release];
            
        }
    }
    myView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,0,0)];
    [imageArray addObject:myView];
    [super viewDidLoad];
}
float value=0;


- (void) sliderMove:(UISlider*) theSlider 
{
 
    imagescroll.contentSize=CGSizeMake(768,(2000*theSlider.value));
    
    value=(float)theSlider.value;
    UIImage *tempImage=[UIImage imageNamed:@"a1.jpeg"];
 
    int rows=0,columns=0;
    NSArray *tempArray=[NSArray arrayWithArray:imageArray];
   
    UIImageView *temp=[imageArray objectAtIndex:0];
    CGRect frameRect = temp.frame;
    
    int count=[imageArray count]-1;
   
    if( frameRect.size.width<210)
    {
        columns=3; 
        rows=count/columns;
        int remainder=count-rows*columns;
        rows=rows+remainder;
    }
    
    else if( (frameRect.size.width>=210)&&(frameRect.size.width<=320))
    {
        columns=2; 
        rows=count/2;
        int remainder=count-rows*columns;
        rows=rows+remainder;
    }
    else
    {
        columns=1;
        rows=count;
    }
    

  
      for(int i=0;i<rows;i++)
       {
          for(int j=0;j<columns;j++)
           {
              UIImageView *temp=[tempArray objectAtIndex:i*columns+j];
              CGRect frameRect = temp.frame;
              frameRect.size.width= tempImage.size.width*(value);
              frameRect.size.height= tempImage.size.height*(value);
              frameRect.origin.x=(frameRect.size.width+50)*j+20;
              frameRect.origin.y=(frameRect.size.height+50)*i+40;
              temp.frame = frameRect;
               CGPoint center = temp.center;
               temp.center=CGPointMake(center.x+(3-columns)*70,center.y);
           }
       }
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
