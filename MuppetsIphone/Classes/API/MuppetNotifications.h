//
//  MuppetNotifications.h
//  Muppets
//
//  Created by Gaurav Sharma on 7/20/11.
//  Copyright 2011 NA. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const DisneyNotificationsReceived;
extern NSString * const FacebookNotificationsReceived;

@interface MuppetNotifications : NSObject {
    
}

+ (MuppetNotifications*)shared;
- (void)load;

- (void)setNotificationIgnoredFacebookFriends:(NSArray *)facebookfriends;
- (NSArray *)notificationIgnoredFacebookFriends;
- (void)setFacebookNotificationsEnabled:(BOOL)isEnabled;
- (BOOL)facebookNotificationsEnabled;
- (void)setDisneyNotificationsEnabled:(BOOL)isEnabled;
- (BOOL)disneyNotificationsEnabled;

- (void)getDisneyNotifications;
- (void)getFacebookNotifications;
- (void)getNotifications;

@end
