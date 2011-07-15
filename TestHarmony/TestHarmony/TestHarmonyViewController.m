//
//  TestHarmonyViewController.m
//  TestHarmony
//
//  Created by Ayush Goel on 22/06/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestHarmonyViewController.h"


@implementation TestHarmonyViewController

@synthesize colorPicker = _colorPicker;
@synthesize myPopover = myPopover;
@synthesize  mylabel;

- (void)dealloc
{  
    
    
    self.colorPicker = nil;
    self.myPopover = nil;
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
    [self setCustomViews];  
    [self setInfoView];
    [self setSocialView];
    [self setWebView];
    [self addButton];
    [self setting];
    [self setChilds];
    [super viewDidLoad];
    NSString *string = [[NSString alloc] initWithString:@"Leaker"];
    string=@"hiii";
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MyloadView:)];
    [labelBar addGestureRecognizer:tapGesture];
    [tapGesture release];
    
    UITapGestureRecognizer *favGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MytableView:)];
    [favImageView addGestureRecognizer:favGesture];
    [favGesture release];

    
    UITapGestureRecognizer *play1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onPlay:)];
    [play addGestureRecognizer:play1];
    [play1 release];
    
    UIPanGestureRecognizer *touch1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onTouchsurface1:)];
    [touchsurface1 addGestureRecognizer:touch1];
    [touch1 release];
    
    UIPanGestureRecognizer *touch2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onTouchsurface2:)];
    [touchsurface2 addGestureRecognizer:touch2];
    [touch2 release];

    UITapGestureRecognizer *mute1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onMute:)];
    [mute addGestureRecognizer:mute1];
    [mute1 release];
    
    
    UITapGestureRecognizer *glee = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onGlee:)];
    [thumb addGestureRecognizer:glee];
    [glee release];
}

-(void) setCustomViews
{
    topView=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,1024,140)];
    UIImage *imageTop=[UIImage imageNamed:@"top-evening.png"];
    topView.image=imageTop;
    [self.view addSubview:topView];
    
    backgroundImage=[[UIImageView alloc]initWithFrame:CGRectMake(0,190,1024,600)];
    UIImage *back=[UIImage imageNamed:@"background.png"];
    backgroundImage.image=back;
    [self.view addSubview:backgroundImage];
    
    labelBar=[[UIImageView alloc]initWithFrame:CGRectMake(0,140,2800,50)];
    UIImage *imageBar=[UIImage imageNamed:@"navbar.png"];
    labelBar.image=imageBar;
    [self.view addSubview:labelBar];
    
    lableHighlighBar=[[UIImageView alloc]initWithFrame:CGRectMake(390,140,230,57)];
    UIImage *HighLightBar=[UIImage imageNamed:@"navbar-highlight.png"];
    lableHighlighBar.image=HighLightBar;
    [self.view addSubview:lableHighlighBar];
    
    labelScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(390,140,330,50)];
    labelScroll.contentSize = CGSizeMake(1000,50);
    [labelScroll setBackgroundColor:[UIColor clearColor]];
    [labelScroll setClipsToBounds:NO];
    [self.view addSubview:labelScroll];
    
    
    
    rootScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(50,190,800,600)];
    rootScroll.contentSize = CGSizeMake(2400,600);
    [rootScroll setBackgroundColor:[UIColor clearColor]];
    [rootScroll setClipsToBounds:NO];
    
    sideScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(800,190,224,700)];
    sideScroll.contentSize = CGSizeMake(2700,700);
    [sideScroll setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:sideScroll];
    
    
    child1=[[UIScrollView alloc]initWithFrame:CGRectMake(0,0,900,1000)];
    [child1 setBackgroundColor:[UIColor clearColor]];
    child1.contentSize = CGSizeMake(900,1100);
    [rootScroll addSubview:child1];
    
    
    child2=[[UIScrollView alloc]initWithFrame:CGRectMake(800,0,900,1200)];
    [child2 setBackgroundColor:[UIColor clearColor]];
    child2.contentSize = CGSizeMake(900,1800);
    [rootScroll addSubview:child2];
    
    
    child3=[[UIScrollView alloc]initWithFrame:CGRectMake(1650,0,900,1000)];
    [child3 setBackgroundColor:[UIColor clearColor]];
    child3.contentSize = CGSizeMake(900,1800);
    [rootScroll addSubview:child3];
    [self.view addSubview:rootScroll];
    
    
    childImage1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 900,1000)];
    [child1 addSubview:childImage1];
    childImage2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 900,1200)];

    [child2 addSubview:childImage2];
    childImage3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 900,1000)];
    [child3 addSubview:childImage3];
    
    favImageView=[[UIImageView alloc]initWithFrame:CGRectMake(750, 70, 200,40)];
    favImageView.image = [UIImage imageNamed:@"dropdown.png"];

    mylabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 0,180, 40)];
    mylabel.text=@"Favorites";
    [mylabel setBackgroundColor:[UIColor clearColor]];
    [favImageView addSubview:mylabel];                 
    [self.view addSubview:favImageView];
    
    bottomview=[[UIImageView alloc]initWithFrame:CGRectMake(-10,648,1034,100)];
    bottomview.image=[UIImage imageNamed:@"bottom_bar.png"];

    [self.view addSubview: bottomview];
    
    activity=[[UILabel alloc]initWithFrame:CGRectMake(500,45, 300, 20)];
    activity.text=@"STARTING ACTIIVTY......";
    [activity setBackgroundColor:[UIColor clearColor]];
    [activity setTextColor:[UIColor whiteColor]];
    activity.font = [UIFont systemFontOfSize:12];
    activity.hidden=YES;
    [bottomview addSubview:activity];

                   
    
    loading=[[UIImageView alloc]initWithFrame:CGRectMake(400,65,500,5)];
    loading.image=[UIImage imageNamed:@"loading-bar.png"];
    [bottomview addSubview:loading];
    loading.hidden=YES;
    
    
       
    touchsurface1=[[UIImageView alloc]initWithFrame:CGRectMake(330,45,270,50)];
    touchsurface1.image=[UIImage imageNamed:@"touch_surface-background"];
  
    touchsurface1.hidden=YES;
    [bottomview addSubview: touchsurface1];
    
    reverse=[[UIImageView alloc]initWithFrame:CGRectMake(295,55,30,30)];
    reverse.image=[UIImage imageNamed:@"touch_surface-rewind"];
    reverse.hidden=YES;
    [bottomview addSubview: reverse];
    
    forward=[[UIImageView alloc]initWithFrame:CGRectMake(605,55,30,30)];
    forward.image=[UIImage imageNamed:@"touch_surface-forward"];
    forward.hidden=YES;
    [bottomview addSubview: forward];
    
    play=[[UIImageView alloc]initWithFrame:CGRectMake(450,55,30,30)];
    playImage=[UIImage imageNamed:@"touch_surface-play"];
    play.image=playImage;
    play.hidden=YES;
    [bottomview addSubview: play];


    
    touchsurface2=[[UIImageView alloc]initWithFrame:CGRectMake(700,45,270,50)];
    touchsurface2.image=[UIImage imageNamed:@"touch_surface-background"];
    touchsurface2.hidden=YES;
    [bottomview addSubview: touchsurface2];
    
    minus=[[UIImageView alloc]initWithFrame:CGRectMake(665,55,30,30)];
    minus.image=[UIImage imageNamed:@"touch_surface-minus"];
    minus.hidden=YES;
    [bottomview addSubview: minus];
    
    plus=[[UIImageView alloc]initWithFrame:CGRectMake(975,55,30,30)];
    plus.image=[UIImage imageNamed:@"touch_surface-plus"];
    plus.hidden=YES;
    [bottomview addSubview: plus];
    
    mute=[[UIImageView alloc]initWithFrame:CGRectMake(820,55,30,30)];
    volumeImage=[UIImage imageNamed:@"touch_surface-mute"];
    mute.image=volumeImage;
    mute.hidden=YES;
    [bottomview addSubview: mute];
   

    thumb=[[UIImageView alloc]initWithFrame:CGRectMake(456,22,373,251)];
    thumb.image=[UIImage imageNamed:@"glee_thumb.png"];
    [childImage2 addSubview:thumb];
    
    mySearch = [[UISearchBar alloc]initWithFrame:CGRectMake(750,25,210,30)];
  [[mySearch.subviews objectAtIndex:0] removeFromSuperview];
    mySearch.delegate = self;
    [topView addSubview:mySearch];
    
   
  
    
}
#pragma mark UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
   
 
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    mySearch.showsCancelButton = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
   // [search removeAllObjects];// remove all data that belongs to previous search
    
    if([searchText isEqualToString:@""])
    {
        [searchPopover dismissPopoverAnimated:YES];
    }

    if([searchText isEqualToString:@"g"])
    {
        myClick = [[SearchTable alloc] initWithStyle:UITableViewStyleGrouped]  ;
        myClick.delegate = self;
        
        nav = [[UINavigationController alloc] initWithRootViewController:myClick];
        [myClick release];
        
        searchPopover = [[UIPopoverController alloc] initWithContentViewController:nav];
        [nav release];
        
        searchPopover.popoverContentSize=CGSizeMake(280,300);
        [searchPopover presentPopoverFromRect:searchBar.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
 

    }
    
    
  
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    
}

    // called when Search (in our case “Done”) button pressed
   
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
    
{
   
}

- (void)Selected
{
 
    [mySearch resignFirstResponder];
    [searchPopover dismissPopoverAnimated:YES];
       [self onMoreInfo];
    
}

- (void)colorSelected:(NSString * )name
{
    title=name;
    mylabel.text=title;
    [myPopover dismissPopoverAnimated:YES];
    
}
-(void) onGlee:(UITapGestureRecognizer *)aGesture
{
    
    if(c==0)
    {
    watchNow.hidden=NO;
    MoreInfo.hidden=NO;
        c=1;
    
    }
    else
    {
        watchNow.hidden=YES;
        MoreInfo.hidden=YES;
        c=0;
    }
}


-(void) onTouchsurface2:(UIPanGestureRecognizer *)aGesture
{
       
    }

- (void)onPlay:(UITapGestureRecognizer *)aGesture
{
    if(p==1)
    {
        playImage=[UIImage imageNamed:@"touch_surface-pause"];
        play.image=playImage; 
        p=0;
    }
   else
    {
        playImage=[UIImage imageNamed:@"touch_surface-play"];
        play.image=playImage; 
        p=1;
    }
}

- (void)onMute:(UITapGestureRecognizer *)aGesture
{
    if(v==1)
    {
        volumeImage=[UIImage imageNamed:@"touch_surface-unmute"];
        mute.image=volumeImage; 
        v=0;
    }
    else
    {
        volumeImage=[UIImage imageNamed:@"touch_surface-mute"];
        mute.image=volumeImage; 
        v=1;
    };
}

- (void)MytableView:(UITapGestureRecognizer *)aGesture
{

    _colorPicker = [[ClickController alloc] initWithStyle:UITableViewStyleGrouped]  ;
    _colorPicker.title = title;
    _colorPicker.delegate = self;
                                       
    nav = [[UINavigationController alloc] initWithRootViewController:_colorPicker];
    [_colorPicker release];
                                       
    myPopover = [[UIPopoverController alloc] initWithContentViewController:nav];
    [nav release];
   
    [myPopover presentPopoverFromRect:favImageView.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}    
    
- (void)MyloadView:(UITapGestureRecognizer *)aGesture{
    if (posx<260) 
    {
        if(rootScroll.contentOffset.x>=800)
        {
            rootScroll.contentOffset=CGPointMake(rootScroll.contentOffset.x-800,rootScroll.contentOffset.y);
            labelScroll.contentOffset=CGPointMake(labelScroll.contentOffset.x-330,labelScroll.contentOffset.y);
        }
    }
    if (posx>720) 
    {
        if(rootScroll.contentOffset.x<=800)
        {
            rootScroll.contentOffset=CGPointMake(rootScroll.contentOffset.x+800,rootScroll.contentOffset.y);
            labelScroll.contentOffset=CGPointMake(labelScroll.contentOffset.x+330,labelScroll.contentOffset.y);
        }
    }

}



-(void) onTouchsurface1:(UIPanGestureRecognizer *)aGesture
{
    CGPoint location2;
    color=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,0,0)];
    [touchsurface1 addSubview:color];
    [color setImage:[UIImage imageNamed:@"GestureParticle.png"]];
    int x2,y2;
    if ([aGesture state]==UIGestureRecognizerStateBegan) 
    {
       // location1 = [aGesture locationInView:touchsurface1];
      //  x1=location1.x;
      //  y1=location1.y;
         //NSLog(@" Start %d %d",x1,y1);
    }  
    else if ([aGesture state]==UIGestureRecognizerStateChanged) 
    {
       
        location2 = [aGesture locationInView:touchsurface1];
        x2=location2.x;
        y2=location2.y;
     //   NSLog(@" end %d %d",x2,y2);
        NSLog(@"1");
        if((x2<250)&&(y2>1))
        {
            if(y2<35)
        color.frame=CGRectMake(x2-5,y2-5,25,25);
        }
      
    }
    else if ([aGesture state]==UIGestureRecognizerStateEnded) 
    {
       NSLog(@"2");
        [color setImage:[UIImage imageNamed:@"dialog-data.png"]];
       // [color addSubview:touchsurface1];
        
    }
       
}

- (void) touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event 
{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:touch.view];
    posx=location.x;
    posy=location.y;
}



-(void) setting
{
    
    rootScroll.delegate=self;
    labelScroll.delegate=self;
    sideScroll.delegate=self;
    child1.delegate=self;
    child2.delegate=self;
    child3.delegate=self;
    
    rootScroll.pagingEnabled=YES;
    labelScroll.pagingEnabled=YES;
    
    [thumb setUserInteractionEnabled:YES];
    
    [topView setUserInteractionEnabled:YES];
    [labelBar setUserInteractionEnabled:YES];
    [rootScroll setUserInteractionEnabled:YES];
    [child2 setUserInteractionEnabled:YES];
    [child1 setUserInteractionEnabled:YES];
    [childImage2 setUserInteractionEnabled:YES];
    [favImageView setUserInteractionEnabled:YES];
    [bottomview setUserInteractionEnabled:YES];
    [touchsurface1 setUserInteractionEnabled:YES];
    [play setUserInteractionEnabled:YES];
    [touchsurface2 setUserInteractionEnabled:YES];
    [mute setUserInteractionEnabled:YES];
    [thumb setUserInteractionEnabled:YES];
     [labelScroll setUserInteractionEnabled:YES];
    
    rootScroll.showsVerticalScrollIndicator = NO;
    rootScroll.showsHorizontalScrollIndicator = NO;
    child1.showsVerticalScrollIndicator = NO;
    child1.showsHorizontalScrollIndicator = NO;
    child2.showsVerticalScrollIndicator = NO;
    child2.showsHorizontalScrollIndicator = NO;
    child3.showsVerticalScrollIndicator = NO;
    child3.showsHorizontalScrollIndicator = NO;
    labelScroll.showsVerticalScrollIndicator = NO;
    labelScroll.showsHorizontalScrollIndicator = NO;
   
    moreInfoView1.hidden=YES;
    socialView1.hidden=YES;
    customWebView.hidden=YES;
    
    [powerButton setUserInteractionEnabled:NO];
    [backButton setUserInteractionEnabled:NO];
    
    toby.alpha=1.0f;
    Gina.alpha=0.4f;
    choice=2;
     title = @"Favourites";
    newView=0;
    p=1;
    v=1;
    c=0;
}

- (void)setChilds
{
        
    switch (choice) {
        case 1:
            childImage1.image = [UIImage imageNamed:@"Toby_channels.png"];
            childImage2.image = [UIImage imageNamed:@"Toby-1.png"];
            childImage3.image = [UIImage imageNamed:@"Toby-2.png"];
            toby.alpha = 1.0f;
            Gina.alpha = 0.4f;
            thumb.hidden=YES;
            watchNow.hidden=YES;
            MoreInfo.hidden=YES;
            break;
        case 2:
            childImage1.image = [UIImage imageNamed:@"GINA_channels.png"];
            childImage2.image = [UIImage imageNamed:@"Gina-1.png"];
            childImage3.image = [UIImage imageNamed:@"Gina-2.png"];
            Gina.alpha = 1.0f;
            toby.alpha = 0.4f;
            thumb.hidden=NO;
            break;
        case 3:
            childImage1.image = [UIImage imageNamed:@"TOBY&GINA_channels.png"];
            childImage2.image = [UIImage imageNamed:@"Toby&Gina-1.png"];
            childImage3.image = [UIImage imageNamed:@"Toby&Gina-2.png"];
            toby.alpha = 1.0f;
            Gina.alpha = 1.0f;
            thumb.hidden=YES;
            watchNow.hidden=YES;
            MoreInfo.hidden=YES;
            break;
    }
}
#pragma mark -
#pragma mark Button
-(void) onToby
{
    if(toby.alpha==0.4f)
    {
        if(Gina.alpha==1.0f)
        {
            choice=3;
        }
        else
            choice=1;
    }
    else
    {
        if(Gina.alpha==1.0f)
        {
            choice=2;
        }
        else
            choice=1;
    }
    
    [self setChilds];
}

-(void) onGina
{
    NSLog(@"gina alpha== %f",Gina.alpha);
    if(Gina.alpha==0.4f)
    {
        NSLog(@"hii");
        if(toby.alpha==1.0f)
        {
            choice=3;
        }
        else
            choice=2;
    }
    else
    {
        NSLog(@"byye");
        if(toby.alpha==1.0f)
        {
            choice=1;
        }
        else
            choice=2;
    }
    
    [self setChilds];
}

- (void)HideStart{
    CGAffineTransform transform = CGAffineTransformMakeScale(1.2f, 1.2f);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(HideBegin)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
   
    if(resume!=-1)
    {
    Listen.transform = transform;
    watchNet.transform=transform;
    Playstation.transform=transform;
    watchHulu.transform=transform;
    watchTV.transform=transform;
    }
    else
    {
        powerButton.transform = transform;
        backButton.transform=transform;
    }
    [UIView commitAnimations];
}

- (void)HideBegin{
    CGAffineTransform transform = CGAffineTransformScale(Listen.transform, 0.5f, 0.5f);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(HideEnd)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    if(resume!=-1)
    {
        Listen.transform = transform;
        watchNet.transform=transform;
        Playstation.transform=transform;
        watchHulu.transform=transform;
        watchTV.transform=transform;
    }
    else
    {
        powerButton.transform = transform;
        backButton.transform=transform;
    }

    [UIView commitAnimations];
    
}    

- (void)HideEnd
{
    if(resume!=-1)
    {
    Listen.hidden = YES;
    watchNet.hidden=YES;
    Playstation.hidden=YES;
    watchHulu.hidden=YES;
    watchTV.hidden=YES;
   
    }
    else
    {
        powerButton.hidden=YES;
        backButton.hidden=YES;
        loading.hidden=YES;
    }
    [self showBegin];
}

-(void) showBegin
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1f];
    [UIView setAnimationDelay:0.5f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(ShowStart)];  
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView commitAnimations];
}


- (void)ShowStart{
 
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView beginAnimations:nil context:nil];
   [UIView setAnimationDelay:0.5f];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(ShowFinish)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
   if(resume!=-1)
   {
    backButton.transform = transform;
    powerButton.transform = transform;
   }
    else
    {
        Listen.transform=transform;
        watchNet.transform=transform;
        Playstation.transform=transform;
        watchTV.transform=transform;
        watchHulu.transform=transform;
        
    }
    [UIView commitAnimations];
}




- (void)ShowFinish{
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0.5f];
    [UIView setAnimationDuration:0.3f];
     [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDidStopSelector:@selector(ShowEnd)];
    if(resume!=-1)
    {
        backButton.transform = transform;
        powerButton.transform = transform;
    }
    else
    {
        Listen.transform=transform;
        watchNet.transform=transform;
        Playstation.transform=transform;
        watchTV.transform=transform;
        watchHulu.transform=transform;
        
    }
    [UIView commitAnimations];
}

-(void) ShowEnd
{
    if(resume!=-1)
  {
    powerButton.hidden    = NO;
    backButton.hidden=NO;
        [self bar];
    
  }
    else
    {
        Listen.hidden=NO;
        watchTV.hidden=NO;
        Playstation.hidden=NO;
        watchNet.hidden=NO;
        watchHulu.hidden=NO;
    }

}
-(void) bar
{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelay:0.5f];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDidStopSelector:@selector(left)];
    [UIView setAnimationDidStopSelector:@selector(right)];
    [UIView commitAnimations];

}

- (void) left
{
    loading.hidden=NO;
    activity.hidden=NO;
    loading.transform = CGAffineTransformMakeTranslation(-30.0f, 0.0f);
    CGAffineTransform transform = CGAffineTransformMakeTranslation(30.0f, 0.0f);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(ShowBarFinish)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    loading.transform=transform;
    [UIView commitAnimations];
    
}


- (void) right
{
    loading.hidden=NO;
    activity.hidden=NO;
    loading.transform = CGAffineTransformMakeTranslation(30.0f, 0.0f);
    CGAffineTransform transform = CGAffineTransformMakeTranslation(-30.0f, 0.0f);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(ShowBarFinish)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    loading.transform=transform;
    [UIView commitAnimations];
}

- (void)ShowBarFinish{
 
   
    loading.hidden=YES;
    activity.hidden=YES;
    touchsurface1.hidden=NO;
    touchsurface2.hidden=NO;
    play.hidden=NO;
    forward.hidden=NO;
    reverse.hidden=NO;
    plus.hidden=NO;
    minus.hidden=NO;
    mute.hidden=NO;

    
    [powerButton setUserInteractionEnabled:YES];
    [backButton setUserInteractionEnabled:YES];
    
}



-(void) onTV
{
  
   // NSLog(@"click");
    [self HideStart];
  
    resume=0;

}

-(void) onWatchTV
{
    [powerButton setUserInteractionEnabled:NO];
    [backButton setUserInteractionEnabled:NO];
    loading.hidden=YES;
    touchsurface1.hidden=YES;
    touchsurface2.hidden=YES;
    play.hidden=YES;
    forward.hidden=YES;
    reverse.hidden=YES;
    plus.hidden=YES;
    minus.hidden=YES;
    mute.hidden=YES;
   [self HideStart];
    
    resume=0;
    
}

-(void) onInfo
{
    [self showBeginthumb];


    
}

-(void) showBeginthumb
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1f];
    [UIView setAnimationDelay:0.5f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(ShowStartthumb)];  
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView commitAnimations];
}


- (void)ShowStartthumb
    {
    
    CGAffineTransform transform = CGAffineTransformMakeScale(1.5f, 1.5f);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(ShowFinishthumb)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    thumb.transform=transform;
    [UIView commitAnimations];
}




- (void)ShowFinishthumb
{
    CGAffineTransform transform = CGAffineTransformMakeScale(1.5f, 1.5f);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDidStopSelector:@selector(ShowViewStart)];
    thumb.transform=transform;
    [UIView commitAnimations];
}

-(void) ShowViewStart
{
    
   CGAffineTransform transform = CGAffineTransformMakeScale(1.5f, 1.5f);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2.0f];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationOptionTransitionFlipFromLeft];
    [UIView setAnimationDidStopSelector:@selector(ShowViewEnd)];
    thumb.transform=transform;
    [UIView commitAnimations];

}

-(void) ShowViewEnd
{
    
    
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
						   forView:thumb cache:YES];
    thumb.hidden=YES;
	[UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
						   forView:moreInfoView1 cache:YES];
    moreInfoView1.hidden=NO;
	[UIView commitAnimations];
    
}



-(void) setInfoView
{
    [rootScroll setUserInteractionEnabled:NO];
    [labelBar setUserInteractionEnabled:NO];
    [backgroundImage setUserInteractionEnabled:NO];
    [sideScroll setUserInteractionEnabled:NO];
    [watchTV setUserInteractionEnabled:NO];
    [watchNow setUserInteractionEnabled:NO];
    [watchNet setUserInteractionEnabled:NO];
    [watchHulu setUserInteractionEnabled:NO];
    [backButton setUserInteractionEnabled:NO];
    [powerButton setUserInteractionEnabled:NO];
    newView=1;

    
    moreInfoView1=[[UIView alloc]initWithFrame:CGRectMake(100,100,840,530)];
    [moreInfoView1 setBackgroundColor:[UIColor clearColor]];
    [moreInfoView1 setUserInteractionEnabled:YES];
    
    
    moreInfoView=[[UIView alloc]initWithFrame:CGRectMake(0,30,840,500)];
    [moreInfoView setBackgroundColor:[UIColor whiteColor]];
    [moreInfoView setUserInteractionEnabled:YES];
    
   
    
    UIImageView *gleeback=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,840,500)];
    gleeback.image=[UIImage imageNamed:@"glee-background"];
    [moreInfoView addSubview:gleeback];
    [gleeback release];
    
    UIScrollView *mydata=[[UIScrollView alloc]initWithFrame:CGRectMake(450,70,300,300)];
    mydata.contentSize=CGSizeMake(300,420);
    UIImageView *mydataimage=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,300,400)];
    mydataimage.image=[UIImage imageNamed:@"glee-details"];
    [mydata addSubview:mydataimage];
    [mydataimage release];
    [moreInfoView addSubview:mydata];
    [mydata release];
                          
    
    
    UIButton *watchNow1 = [UIButton buttonWithType:UIButtonTypeCustom];
	watchNow1.frame = CGRectMake(30,420,180,60);
    UIImage *watchNowImage = [UIImage imageNamed:@"watch-now.png"];
    [watchNow1 setBackgroundImage:watchNowImage forState:UIControlStateNormal];
    [watchNow1 addTarget:self action:@selector(onWatchTV) forControlEvents:UIControlEventTouchUpInside];
    [watchNow1 setUserInteractionEnabled:YES];
	[moreInfoView1 addSubview:watchNow1]; 
  
    


    
    UIButton *more = [UIButton buttonWithType:UIButtonTypeCustom];
	more.frame = CGRectMake(220,420,180,60);
    UIImage *moreImage = [UIImage imageNamed:@"more-info.png"];
    [more setBackgroundImage:moreImage forState:UIControlStateNormal];
    [more setUserInteractionEnabled:YES];
	[moreInfoView addSubview:more];    
    

    
    UIButton *imdb = [UIButton buttonWithType:UIButtonTypeCustom];
	imdb.frame = CGRectMake(430,420,80,60);
    UIImage *imdbImage = [UIImage imageNamed:@"imdb-dialog.png"];
    [imdb setBackgroundImage:imdbImage forState:UIControlStateNormal];
    [imdb addTarget:self action:@selector(onIMDB) forControlEvents:UIControlEventTouchUpInside];
    [imdb setUserInteractionEnabled:YES];
	[moreInfoView addSubview:imdb];    
    
    
    UIButton *wiki = [UIButton buttonWithType:UIButtonTypeCustom];
	wiki.frame = CGRectMake(520,420,80,60);
    UIImage *wikiImage = [UIImage imageNamed:@"wiki-dialog.png"];
    [wiki addTarget:self action:@selector(onWIKI) forControlEvents:UIControlEventTouchUpInside];
    [wiki setBackgroundImage:wikiImage forState:UIControlStateNormal];
    [wiki setUserInteractionEnabled:YES];
	[moreInfoView addSubview:wiki]; 
    
    
    thumbup = [UIButton buttonWithType:UIButtonTypeCustom];
	thumbup.frame = CGRectMake(620,430,40,40);
    UIImage *thumbupImage = [UIImage imageNamed:@"thumbs_up-dialog.png"];
    [thumbup setBackgroundImage:thumbupImage forState:UIControlStateNormal];
   [thumbup addTarget:self action:@selector(onThumUp) forControlEvents:UIControlEventTouchUpInside];
    [thumbup setUserInteractionEnabled:YES];
	[moreInfoView addSubview:thumbup]; 
    
    
    
    thumbdown = [UIButton buttonWithType:UIButtonTypeCustom];
	thumbdown.frame = CGRectMake(670,430,40,40);
    UIImage *thumbdownImage = [UIImage imageNamed:@"thumbs_down-dialog.png"];
    [thumbdown setBackgroundImage:thumbdownImage forState:UIControlStateNormal];
    [thumbdown addTarget:self action:@selector(onThumDown) forControlEvents:UIControlEventTouchUpInside];
    [thumbdown setUserInteractionEnabled:YES];
	[moreInfoView addSubview:thumbdown]; 
    
    social = [UIButton buttonWithType:UIButtonTypeCustom];
	social.frame = CGRectMake(400,-30,150,80);
    UIImage *socialImage = [UIImage imageNamed:@"social.png"];
    [social setBackgroundImage:socialImage forState:UIControlStateNormal];
    [social addTarget:self action:@selector(onSocial) forControlEvents:UIControlEventTouchUpInside];
    [social setUserInteractionEnabled:YES];
	[moreInfoView addSubview:social]; 

    
    UIButton *close= [UIButton buttonWithType:UIButtonTypeCustom];
	close.frame = CGRectMake(720,0,80,80);
    UIImage *buttonImage2 = [UIImage imageNamed:@"close.png"]; 
    [close setBackgroundImage:buttonImage2 forState:UIControlStateNormal];
	[close addTarget:self action:@selector(onClose) forControlEvents:UIControlEventTouchUpInside];
    [close setUserInteractionEnabled:YES];
    [moreInfoView addSubview:close];
    
    [moreInfoView1 addSubview:moreInfoView];
    [self.view addSubview:moreInfoView1];


    
}
-(void) setSocialView
{
    socialView1=[[UIView alloc]initWithFrame:CGRectMake(100,100,840,530)];
    [self.view addSubview:socialView1];
    
    socialView=[[UIView alloc]initWithFrame:CGRectMake(0,30,840,500)];
    [socialView1 addSubview:socialView];
    
    
    UIImageView *tempImage1 =[[[UIImageView alloc] initWithFrame:CGRectMake(40,40,840,500)] initWithImage:[UIImage imageNamed:@"social-box"]];
    [tempImage1 setUserInteractionEnabled:YES];
    [socialView  addSubview:tempImage1];
    [tempImage1 release];
    
    UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(30,30,20,20)];
    [socialView addSubview:tempView];
    [tempView release];
    
    
    UIImageView *tempImage2=[[[UIImageView alloc]initWithFrame:CGRectMake(100,100,840,400)]initWithImage:[UIImage imageNamed:@"glee-feeds.png"]];
    [tempView addSubview:tempImage2];
    [tempImage2 release];
    
    
    UIScrollView *tweetsView=[[UIScrollView alloc]initWithFrame:CGRectMake(35,112, 213,300)];
    tweetsView.contentSize=CGSizeMake(213,450);
    UIImageView *tweetImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,200,500)];
    tweetImage.image=[UIImage imageNamed:@"glee-tweets"];
    [tweetsView addSubview:tweetImage];
    [tweetImage release];
    [socialView addSubview:tweetsView];
    [tweetsView release];
    
    
    UIButton *more_info= [UIButton buttonWithType:UIButtonTypeCustom];
	more_info.frame = CGRectMake(350,0,250,60);
    UIImage *Image2 = [UIImage imageNamed:@"view_more_info.png"]; 
    [more_info setBackgroundImage:Image2 forState:UIControlStateNormal];
	[more_info addTarget:self action:@selector(onMoreInfo) forControlEvents:UIControlEventTouchUpInside];
    [more_info setUserInteractionEnabled:YES];
    [socialView1 addSubview:more_info];
    
    UIButton *close= [UIButton buttonWithType:UIButtonTypeCustom];
	close.frame = CGRectMake(720,0,80,80);
    UIImage *buttonImage2 = [UIImage imageNamed:@"close.png"]; 
    [close setBackgroundImage:buttonImage2 forState:UIControlStateNormal];
	[close addTarget:self action:@selector(onSocialClose) forControlEvents:UIControlEventTouchUpInside];
    [close setUserInteractionEnabled:YES];
    
    [socialView addSubview:close];

}
-(void) setWebView
{
    customWebView =[[UIWebView alloc] initWithFrame:CGRectMake(100,130,840,500)];
    customWebView.delegate = self;
    [customWebView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:customWebView];
    
    
    UIButton *close= [UIButton buttonWithType:UIButtonTypeCustom];
	close.frame = CGRectMake(720,0,80,80);
    UIImage *buttonImage2 = [UIImage imageNamed:@"close.png"]; 
    [close setBackgroundImage:buttonImage2 forState:UIControlStateNormal];
	[close addTarget:self action:@selector(onWebClose) forControlEvents:UIControlEventTouchUpInside];
    [close setUserInteractionEnabled:YES];
    [customWebView addSubview:close];

}
-(void) onSocial
{  
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
						   forView:moreInfoView1 cache:YES];
     moreInfoView1.hidden=YES;
	[UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
						   forView:socialView1 cache:YES];
    socialView1.hidden=NO;
	[UIView commitAnimations];

    

}


-(void) onMoreInfo
{
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
						   forView:socialView1 cache:YES];
    socialView1.hidden=YES;
	[UIView commitAnimations];
    
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
						   forView:moreInfoView1 cache:YES];
    moreInfoView1.hidden=NO;
	[UIView commitAnimations];
	
    

    
}

-(void) onIMDB
{
    [customWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    [customWebView  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.imdb.com/title/tt1327801/"]]];
   
     [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    CGAffineTransform  transform = CGAffineTransformTranslate(moreInfoView1.transform, -860.0f , 0.0f);            
    moreInfoView1.alpha     = 0.5f;
    moreInfoView1.transform = transform;
    [UIView commitAnimations];
    
    
     customWebView.hidden=NO;
  
    
       
}
-(void) onWIKI
{
   [customWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    [customWebView  loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://en.wikipedia.org/wiki/Glee_(TV_series)"]]];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    CGAffineTransform  transform = CGAffineTransformTranslate(moreInfoView1.transform, -860.0f , 0.0f);            
    moreInfoView1.alpha     = 0.5f;
    moreInfoView1.transform = transform;
    [UIView commitAnimations];
    
    
    customWebView.hidden=NO;
  

    
}



-(void) onWebClose
{
   
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    
    CGAffineTransform  transform = CGAffineTransformTranslate(moreInfoView1.transform, 860.0f , 0.0f);            
    moreInfoView1.alpha     = 1.0f;
    moreInfoView1.transform = transform;
    [UIView commitAnimations];
    
    
    customWebView.hidden=YES;
   
}
-(void) onThumUp
{
    UIImage *thumbupImage = [UIImage imageNamed:@"thumbs_up-selected-dialog.png"];
    [thumbup setBackgroundImage:thumbupImage forState:UIControlStateNormal];
    
    thumbupImage = [UIImage imageNamed:@"thumbs_down-dialog.png"];
    [thumbdown setBackgroundImage:thumbupImage forState:UIControlStateNormal];
    
   
}

-(void) onThumDown
{

    alertView=[[UIImageView alloc]initWithFrame:CGRectMake(60,20,700,500)];
    UIImage *alertViewImage=[UIImage imageNamed:@"unfavorite_dialog.png"];
    alertView.image=alertViewImage;
    
    
    UILabel *textLabel=[[UILabel alloc]initWithFrame:CGRectMake(220,170, 210,100)];
    [textLabel setBackgroundColor:[UIColor clearColor]];
    textLabel.textColor=[UIColor whiteColor];
    textLabel.font = [UIFont systemFontOfSize:22];
    textLabel.textAlignment=UITextAlignmentCenter;
    textLabel.text=@"Glee will be removed from your recommended shows";
    textLabel.numberOfLines = 3;
    [alertView addSubview:textLabel];
    [textLabel release];              
     
    [alertView setUserInteractionEnabled:YES];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
	btn1.frame = CGRectMake(220,300,100,50);
    UIImage *btn1Image = [UIImage imageNamed:@"ok-unfavorite.png"];
    [btn1 setBackgroundImage:btn1Image forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(onOK) forControlEvents:UIControlEventTouchUpInside];
    btn1.userInteractionEnabled=YES;
	[alertView addSubview:btn1];
	
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
	btn2.frame = CGRectMake(340,300,100,50);
    UIImage *btn2Image = [UIImage imageNamed:@"cancel-unfavorite.png"];
    [btn2 setBackgroundImage:btn2Image forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(onCANCEL) forControlEvents:UIControlEventTouchUpInside];
    btn2.userInteractionEnabled=YES;
	[alertView addSubview:btn2];

  [moreInfoView addSubview:alertView];
    
}
-(void) onOK
{
    alertView.hidden=YES;
   
    UIImage *thumbupImage = [UIImage imageNamed:@"thumbs_up-dialog.png"];
    [thumbup setBackgroundImage:thumbupImage forState:UIControlStateNormal];
    
    thumbupImage = [UIImage imageNamed:@"thumbs_down-selected-dialog.png"];
    [thumbdown setBackgroundImage:thumbupImage forState:UIControlStateNormal];
}

-(void) onCANCEL
{
     alertView.hidden=YES;
}

-(void) onClose
{
    [rootScroll setUserInteractionEnabled:YES];
    [labelBar setUserInteractionEnabled:YES];
    [backgroundImage setUserInteractionEnabled:YES];
    [sideScroll setUserInteractionEnabled:YES];
    [watchTV setUserInteractionEnabled:YES];
    [watchNow setUserInteractionEnabled:YES];
    [watchNet setUserInteractionEnabled:YES];
    [watchHulu setUserInteractionEnabled:YES];
    [backButton setUserInteractionEnabled:YES];
    [powerButton setUserInteractionEnabled:YES];
    newView=1;
    
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f,1.0f);
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0f];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
						   forView:moreInfoView1 cache:YES];
	[UIView commitAnimations];
    moreInfoView1.hidden=YES;
    
   [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0f];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
						   forView:thumb cache:YES];
    thumb.transform=transform;
    thumb.hidden=NO;
	[UIView commitAnimations];
    

 
}

-(void) onSocialClose
{
    
    [rootScroll setUserInteractionEnabled:YES];
    [labelBar setUserInteractionEnabled:YES];
    [backgroundImage setUserInteractionEnabled:YES];
    [sideScroll setUserInteractionEnabled:YES];
    [watchTV setUserInteractionEnabled:YES];
    [watchNow setUserInteractionEnabled:YES];
    [watchNet setUserInteractionEnabled:YES];
    [watchHulu setUserInteractionEnabled:YES];
    [backButton setUserInteractionEnabled:YES];
    [powerButton setUserInteractionEnabled:YES];
    newView=1;
    
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f,1.0f);
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0f];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
						   forView:socialView1 cache:YES];
	[UIView commitAnimations];
    socialView1.hidden=YES;
    
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0f];
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight
						   forView:thumb cache:YES];
    thumb.transform=transform;
    thumb.hidden=NO;
	[UIView commitAnimations];
    
}

-(void) onResume
{
    touchsurface1.hidden=YES;
    touchsurface2.hidden=YES;
    play.hidden=YES;
    forward.hidden=YES;
    reverse.hidden=YES;
    plus.hidden=YES;
    minus.hidden=YES;
    mute.hidden=YES;
    watchNow.hidden=YES;
    MoreInfo.hidden=YES;

    [self HideStart];
    resume=-1;
}

-(void) addButton
{
    Gina = [UIButton buttonWithType:UIButtonTypeCustom];
	Gina.frame = CGRectMake(120,20,80,80);
	UIImage *buttonImage1 = [UIImage imageNamed:@"gina.png"];
    UIImage *stretchableButtonImage1 = [buttonImage1 stretchableImageWithLeftCapWidth:12 topCapHeight:0]; 
    [Gina setBackgroundImage:stretchableButtonImage1 forState:UIControlStateNormal];
	[Gina addTarget:self action:@selector(onGina) forControlEvents:UIControlEventTouchUpInside];
    [Gina setUserInteractionEnabled:YES];
	[topView addSubview:Gina];

    toby = [UIButton buttonWithType:UIButtonTypeCustom];
	toby.frame = CGRectMake(20,20,80,80);
    UIImage *buttonImage2 = [UIImage imageNamed:@"toby.png"];
    UIImage *stretchableButtonImage2 = [buttonImage2 stretchableImageWithLeftCapWidth:12 topCapHeight:0]; 
    [toby setBackgroundImage:stretchableButtonImage2 forState:UIControlStateNormal];
	[toby addTarget:self action:@selector(onToby) forControlEvents:UIControlEventTouchUpInside];
     [toby setUserInteractionEnabled:YES];
	[topView addSubview:toby];
  
    powerButton = [UIButton buttonWithType:UIButtonTypeCustom];
	powerButton.frame = CGRectMake(55,45,50,50);
    UIImage *powerImage = [UIImage imageNamed:@"poweroff.png"];
    [powerButton setBackgroundImage:powerImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(onResume) forControlEvents:UIControlEventTouchUpInside];
    [powerButton setUserInteractionEnabled:NO];
	[bottomview addSubview:powerButton];
    powerButton.hidden=YES;
    
    backButton = [UIButton buttonWithType:UIButtonTypeCustom];
	backButton.frame = CGRectMake(98,45,170,50);
    UIImage *backImage = [UIImage imageNamed:@"back.png"];
    [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
	[backButton setTitle:@"Watch TV" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(onResume) forControlEvents:UIControlEventTouchUpInside];
    [backButton setUserInteractionEnabled:NO];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:18];
	[bottomview addSubview:backButton];
    backButton.hidden=YES;

   
   
    watchTV = [UIButton buttonWithType:UIButtonTypeCustom];
	watchTV.frame = CGRectMake(55,45,170,50);
    UIImage *buttonImage = [UIImage imageNamed:@"nav_button.png"];
    [watchTV setBackgroundImage:buttonImage forState:UIControlStateNormal];
	[watchTV setTitle:@"Watch TV" forState:UIControlStateNormal];
    [watchTV addTarget:self action:@selector(onTV) forControlEvents:UIControlEventTouchUpInside];
    [watchTV setUserInteractionEnabled:YES];
    [watchTV setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    watchTV.titleLabel.font = [UIFont systemFontOfSize:18];
	[bottomview addSubview:watchTV];
    
    
    watchNet = [UIButton buttonWithType:UIButtonTypeCustom];
	watchNet.frame = CGRectMake(250,45,170,50);
    [watchNet setBackgroundImage:buttonImage forState:UIControlStateNormal];
	[watchNet setTitle:@"Watch Netflix" forState:UIControlStateNormal];
    [watchNet setUserInteractionEnabled:YES];
    [watchNet setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    watchNet.titleLabel.font = [UIFont systemFontOfSize:18];
	[bottomview addSubview:watchNet];

    watchHulu = [UIButton buttonWithType:UIButtonTypeCustom];
	watchHulu.frame = CGRectMake(440,45,170,50);
    [watchHulu setBackgroundImage:buttonImage forState:UIControlStateNormal];
	[watchHulu setTitle:@"Watch HuluPlus" forState:UIControlStateNormal];
    [watchHulu setUserInteractionEnabled:YES];
    [watchHulu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    watchHulu.titleLabel.font = [UIFont systemFontOfSize:18];
	[bottomview addSubview:watchHulu];
    
    Listen = [UIButton buttonWithType:UIButtonTypeCustom];
	Listen.frame = CGRectMake(630,45,170,50);
    [Listen setBackgroundImage:buttonImage forState:UIControlStateNormal];
	[Listen setTitle:@"Listen To Music" forState:UIControlStateNormal];
    [Listen setUserInteractionEnabled:YES];
    [Listen setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Listen.titleLabel.font = [UIFont systemFontOfSize:18];
	[bottomview addSubview:Listen];
    
    Playstation = [UIButton buttonWithType:UIButtonTypeCustom];
	Playstation.frame = CGRectMake(820,45,170,50);
    [Playstation setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [Playstation setTitle:@"Play Playstation" forState:UIControlStateNormal];
    [Playstation setUserInteractionEnabled:YES];
    [Playstation setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Playstation.titleLabel.font = [UIFont systemFontOfSize:18];
	[bottomview addSubview:Playstation];
    
    watchNow = [UIButton buttonWithType:UIButtonTypeCustom];
	watchNow.frame = CGRectMake(530,80,200,60);
    UIImage *watchNowImage = [UIImage imageNamed:@"watch-now.png"];
    [watchNow setBackgroundImage:watchNowImage forState:UIControlStateNormal];
   [watchNow addTarget:self action:@selector(onWatchTV) forControlEvents:UIControlEventTouchUpInside];
    [watchNow setUserInteractionEnabled:YES];
	[childImage2 addSubview:watchNow];
    watchNow.hidden=YES;
    
   
    MoreInfo = [UIButton buttonWithType:UIButtonTypeCustom];
	MoreInfo.frame = CGRectMake(530,150,200,60);
    UIImage *MoreInfoImage = [UIImage imageNamed:@"more-info.png"];
    [MoreInfo setBackgroundImage:MoreInfoImage forState:UIControlStateNormal];
    [MoreInfo addTarget:self action:@selector(onInfo) forControlEvents:UIControlEventTouchUpInside];
    [MoreInfo setUserInteractionEnabled:YES];
	[childImage2 addSubview:MoreInfo];
    MoreInfo.hidden=YES;

    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
	btn1.frame = CGRectMake(0,0,200,50);
	[btn1 setTitle:@"Favorite Channel" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:22];
    [btn1 setBackgroundColor:[UIColor clearColor]];
	[labelScroll addSubview:btn1];
	
	UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
	btn2.frame = CGRectMake(350,0,200,50);
	[btn2 setTitle:@"Watch Now" forState:UIControlStateNormal];
     [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:22];
    [btn2 setBackgroundColor:[UIColor clearColor]];
	[labelScroll addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
	btn3.frame = CGRectMake(650,0,200,50);
	[btn3 setTitle:@"Watch Later" forState:UIControlStateNormal];
     [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn3.titleLabel.font = [UIFont systemFontOfSize:22];
    [btn3 setBackgroundColor:[UIColor clearColor]];
	[labelScroll addSubview:btn3];
}




- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{     

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

    if(scrollView == labelScroll)
    {        
        
        startX=labelScroll.contentOffset.x;   
        
    } 
    if(scrollView == rootScroll)
    {        
        
        startX=rootScroll.contentOffset.x;   
        
    } 
        

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
   
    if(scrollView == sideScroll)
    {
        rootScroll.contentOffset=CGPointMake(rootScroll.contentOffset.x+800,rootScroll.contentOffset.y);
        
    }

    if(scrollView == labelScroll)
    {  
        endX=labelScroll.contentOffset.x;
         // NSLog(@"startx == %f endx== %f",startX,endX);
        if(abs(endX-startX)>50)
        {
             if(endX-startX>0)
                if(rootScroll.contentOffset.x<1600)
                       rootScroll.contentOffset=CGPointMake(rootScroll.contentOffset.x+800,rootScroll.contentOffset.y);
             if(startX-endX>0)
               {
                if(rootScroll.contentOffset.x>700)
                 rootScroll.contentOffset=CGPointMake(rootScroll.contentOffset.x-800,rootScroll.contentOffset.y);
               }
        }
    }
   
    if(scrollView == rootScroll)
    {  
        endX=rootScroll.contentOffset.x;
        //NSLog(@"startx == %f endx== %f",startX,endX);
        if(abs(endX-startX)>50)
        {
            if(endX-startX>0)
                if(labelScroll.contentOffset.x<600)
                    labelScroll.contentOffset=CGPointMake(labelScroll.contentOffset.x+330,labelScroll.contentOffset.y);
            if(startX-endX>0)
            {
                if(labelScroll.contentOffset.x>0)
                    labelScroll.contentOffset=CGPointMake(labelScroll.contentOffset.x-330,labelScroll.contentOffset.y);
            }
        }
         //NSLog(@"content offset x %f",labelScroll.contentOffset.x);
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
