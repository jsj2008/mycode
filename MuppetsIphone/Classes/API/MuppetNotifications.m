//
//  MuppetNotifications.m
//  Muppets
//
//  Created by Gaurav Sharma on 7/20/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "MuppetNotifications.h"
#import "MuppetAccount.h"

static MuppetNotifications *shared=nil;

NSString * const DisneyNotificationsReceived = @"DisneyNotificationsReceived";
NSString * const FacebookNotificationsReceived = @"FacebookNotificationsReceived";

@implementation MuppetNotifications

+ (MuppetNotifications*)shared{
	@synchronized(shared){
		if (!shared) {
			shared = [[MuppetNotifications alloc] init];
            [shared load];
		}
	}
	return shared;
}

- (void)load{
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(facebookAccountStatusChanged) 
                                                 name: AccountLoginStatusChanged 
                                               object: nil];
}

- (void)facebookAccountStatusChanged{
    if ([MuppetAccount shared].status == AccountStatusMuppetLoggedIn) {
        [self getNotifications];
    }
}

- (void)parseDisneyNotifications:(NSArray *)alerts{
    NSMutableArray *_alerts = [NSMutableArray new];
    
    for (NSDictionary *_alert in alerts) {
        NSDictionary *_alertDetails = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       @"disney", @"type",
                                       [[_alert objectForKey:@"alert"] objectForKey:@"name"], @"name",
                                       [[_alert objectForKey:@"alert"] objectForKey:@"description"], @"description",
                                       nil];
        [_alerts addObject:_alertDetails];
        [_alertDetails release];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DisneyNotificationsReceived object:[[_alerts copy] autorelease]];
    [_alerts release];
    [alerts release];
}

- (void)getDisneyNotifications{
    if (![self disneyNotificationsEnabled]) {
        return;
    }   

    [[MuppetAccount shared] getRequestWithPath:kMuppetsApiNotificationPath andParams:nil andResponse:^(id response) {
        [self parseDisneyNotifications:[[response objectForKey:@"data"] retain]];
    } andError:^(NSError *error) {
        
    }];
}

- (void)parseFacebookNotifications:(NSArray *)friends{
    NSMutableArray *_alerts = [NSMutableArray new];
    for (NSDictionary *_friend in friends) {
        NSDictionary *_alertDetails = [[NSDictionary alloc] initWithObjectsAndKeys:
                                       @"facebook", @"type",
                                       [_friend objectForKey:@"name"], @"name",
                                       [_friend objectForKey:@"parsed_birthday"], @"birthday",
                                       nil];
        [_alerts addObject:_alertDetails];
        [_alertDetails release];
    }
    if ([_alerts count] > 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:FacebookNotificationsReceived object:[[_alerts copy] autorelease]];
    }
    [_alerts release];
    [friends release];
}

- (void)getFacebookNotifications{
    [[MuppetAccount shared] fetchFriendsWithResponseBlock:^(NSArray *friends) {
        NSMutableArray *_friendsWithBirthday = [NSMutableArray new];
        NSArray *_ignoredFriends             = [[self notificationIgnoredFacebookFriends] retain];
        
        // http://stackoverflow.com/questions/2331129/how-to-determine-if-an-nsdate-is-today
        NSCalendar *cal                 = [NSCalendar currentCalendar];
        NSDateComponents *components    = [cal components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:[NSDate date]];
        NSDate *today                   = [cal dateFromComponents:components];
        
        for (NSDictionary *_friend in friends) {
            NSString *_id = [_friend objectForKey:@"id"];
            
            // if ignored
            if ([_ignoredFriends indexOfObject:_id] != NSNotFound) {
                continue;
            }

            NSDate *_date = [_friend objectForKey:@"parsed_birthday"];

            // birthday not found
            if (!_date) {
                continue;
            }
            
            NSDateComponents *components    = [cal components:(NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit) fromDate:_date];
            NSDate *_birthDate              = [cal dateFromComponents:components];
            
            if([today isEqualToDate:_birthDate]) {
                [_friendsWithBirthday addObject:_friend];
            }
        }
        if ([_friendsWithBirthday count] > 0) {
            [self parseFacebookNotifications:[_friendsWithBirthday copy]];
        }
        [_friendsWithBirthday release];
        
        [_ignoredFriends release];
        
    } andErrorBlock:^(NSError *error) {
        
    }];
}

- (void)getNotifications{
    [self getDisneyNotifications];
    [self getFacebookNotifications];
}


- (void)setNotificationIgnoredFacebookFriends:(NSArray *)facebookfriends{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setValue:facebookfriends forKey:@"no_notification_facebook_friends"];
    [prefs synchronize];
}

- (NSArray *)notificationIgnoredFacebookFriends{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSArray *_friends = [prefs valueForKey:@"no_notification_facebook_friends"];
    if (!_friends) {
        _friends = [NSArray array];
    }
    return _friends;
}

- (void)setFacebookNotificationsEnabled:(BOOL)isEnabled{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setValue:[NSNumber numberWithBool:isEnabled] forKey:@"facebook_notifications_enabled"];
    [prefs synchronize];
}

- (BOOL)facebookNotificationsEnabled{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSNumber *_enabled    = [prefs objectForKey:@"facebook_notifications_enabled"];
    if (!_enabled) {
        [self setFacebookNotificationsEnabled:YES];
        _enabled = [NSNumber numberWithBool:YES];
    }
    return [_enabled boolValue];
}

- (void)setDisneyNotificationsEnabled:(BOOL)isEnabled{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setValue:[NSNumber numberWithBool:isEnabled] forKey:@"disney_notifications_enabled"];
    [prefs synchronize];
}

- (BOOL)disneyNotificationsEnabled{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSNumber *_enabled    = [prefs objectForKey:@"disney_notifications_enabled"];
    if (!_enabled) {
        [self setDisneyNotificationsEnabled:YES];
        _enabled = [NSNumber numberWithBool:YES];
    }
    return [_enabled boolValue];
}


@end
