//
//  MuppetFeatureDataProvider.m
//  Muppets
//
//  Created by Gaurav Sharma on 7/5/11.
//  Copyright 2011 Sequence. All rights reserved.
//

#import "MuppetFeatureDataProvider.h"
#import "MuppetFeatureTableViewCell.h"
#import "SBJson.h"

#define kCellIdentifier @"MuppetFeatureTableViewCell"

@implementation MuppetFeatureDataProvider

@synthesize delegate;

- (void)dealloc
{
    [delegate release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)loadFeature:(MuppetFeatureType)aFeatureType{
    featureType = aFeatureType;
    
    NSString *resourcePath  = [[NSBundle mainBundle] pathForResource:@"builder" ofType:@"json"];
    NSError *error          = nil;
    NSString *resourceData  = [NSString stringWithContentsOfFile:resourcePath encoding:NSASCIIStringEncoding error:&error];
    
    NSDictionary *_allFeatures             = [[resourceData JSONValue] retain];
    
    switch (aFeatureType) {
        case MuppetFeatureTypeHair:
            self.data = [[_allFeatures objectForKey:@"hair"] retain];
            break;
        case MuppetFeatureTypeFace:
            self.data = [[_allFeatures objectForKey:@"expression"] retain];
            break;    
        case MuppetFeatureTypeShirt:
            self.data = [[_allFeatures objectForKey:@"shirts"] retain];
            break;    
        case MuppetFeatureTypePant:
            self.data = [[_allFeatures objectForKey:@"pants"] retain];
            break;    
    }
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)atableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MuppetFeatureTableViewCell *cell = (MuppetFeatureTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:kCellIdentifier owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
    }
    
    [cell setSourceData:[data objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [delegate featureChanged:featureType withResource:[data objectAtIndex:indexPath.row]];
}

@end
