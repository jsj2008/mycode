//
//  FacebookFriendCell.m
//  Muppets
//
//  Created by Gaurav Sharma on 7/18/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "FacebookFriendCell.h"


@implementation FacebookFriendCell
@synthesize image;
@synthesize nameLabel;
@synthesize birthdayLabel;
@synthesize checkBox;
@synthesize selected;
@synthesize identifier;
@synthesize delegate;
@synthesize data;

+ (id)new{
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"FacebookFriendCell"
                                                      owner:self
                                                    options:nil];    
    return [[nibViews objectAtIndex:0] retain];
}

- (void)layoutSubviews{
    if (!_gestureAdded){
        _gestureAdded = YES;
        UITapGestureRecognizer *singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped)];
        [singleTapRecognizer setDelegate:self];
        [self addGestureRecognizer:singleTapRecognizer];
        [singleTapRecognizer release];
    }
}

- (void)setSelected:(BOOL)isselected{
    selected = isselected;
    checkBox.hidden = !selected;
    [delegate friendCellSelectionUpdated:self];
}

- (void)tapped{
    self.selected = !self.selected;
}

- (void)setData:(NSDictionary *)somedata{
    data = somedata;
    
    [self.image setImageWithPath:[data objectForKey:@"picture"] placeholderImage:nil];
    [self.nameLabel setText:[data objectForKey:@"name"]];
    [self.birthdayLabel setText:[data objectForKey:@"birthday"]];
    self.identifier = [data objectForKey:@"id"];
}

- (void)dealloc
{
    [identifier release];
    [image release];
    [nameLabel release];
    [birthdayLabel release];
    [checkBox release];
    [delegate release];
    [super dealloc];
}

@end
