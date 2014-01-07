//
//  YMMUser.m
//  yemaomen
//
//  Created by Zhu Weifeng on 12/27/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import "YMMUser.h"

#define CURRENT_USER_KEY @"CURRENT_USER_KEY"

#define USERNAME_KEY @"username"
#define BIO_KEY @"bio"
#define LOCATION_KEY @"location"
#define SCORE_KEY @"score"
#define AVATAR_URL_KEY @"avatarURL"
#define ALLOW_BROWSE_KEY @"allowBrowse"
#define IDENTIFY_TOKEN_KEY @"identifyToken"

@interface YMMUser ()

@property (nonatomic, strong, readwrite) NSString *username;
@property (nonatomic, strong, readwrite) NSString *bio;
@property (nonatomic, strong, readwrite) NSString *location;
@property (nonatomic, strong, readwrite) NSNumber *score;
@property (nonatomic, strong, readwrite) NSString *avatarURL;
@property (nonatomic, strong, readwrite) NSNumber *allowBrowse;
@property (nonatomic, strong, readwrite) NSString *identifyToken;

@end

static YMMUser *CurrentUser = nil;

@implementation YMMUser

/**
 从NSUserDefaults中恢复user，如果NSUserDefaults中没有User的信息（例如username），证明用户没有登录过。所以，可以通过[YMMUser currentUser]是否为nil来判断用户是否已经登录。
 一旦用户登录成功，则需要通过[user saveCurrentUserToUserDefaults]来将用户信息存进UserDefaults里，那么[YMMUser currentUser]就不会为nil了，证明用户登录了。
 */
+ (YMMUser *)currentUser {
  if (CurrentUser == nil) {
    CurrentUser = [YMMUser restoreCurrentUserFromUserDefaults];
  }
  if (!CurrentUser.username) {
    return nil;
  }
  return CurrentUser;
}

+ (YMMUser *)restoreCurrentUserFromUserDefaults {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSData *encodedObject = [defaults objectForKey:CURRENT_USER_KEY];
  YMMUser *currentUser = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
  return currentUser;
}

+ (void)removeCurrentUserFromUserDefaults {
  CurrentUser = nil;
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:CURRENT_USER_KEY];
}

- (void)saveCurrentUserToUserDefaults {
  NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:self];
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:encodedObject forKey:CURRENT_USER_KEY];
  [defaults synchronize];
}

- (id)initWithDictionary:(NSDictionary *)dict {
  if (self = [super init]) {
    if (dict[USERNAME_KEY]) self.username = dict[USERNAME_KEY];
    if (dict[BIO_KEY]) self.bio = dict[BIO_KEY];
    if (dict[LOCATION_KEY]) self.location = dict[LOCATION_KEY];
    if (dict[SCORE_KEY]) self.score = dict[SCORE_KEY];
    if (dict[AVATAR_URL_KEY]) self.avatarURL = dict[AVATAR_URL_KEY];
    if (dict[ALLOW_BROWSE_KEY]) self.allowBrowse = dict[ALLOW_BROWSE_KEY];
    if (dict[IDENTIFY_TOKEN_KEY]) self.identifyToken = dict[IDENTIFY_TOKEN_KEY];
  }
  return self;
}

- (void)updateUserInfoWithDictionary:(NSDictionary *)dict {
  if (dict[USERNAME_KEY]) self.username = dict[USERNAME_KEY];
  if (dict[BIO_KEY]) self.bio = dict[BIO_KEY];
  if (dict[LOCATION_KEY]) self.location = dict[LOCATION_KEY];
  if (dict[SCORE_KEY]) self.score = dict[SCORE_KEY];
  if (dict[AVATAR_URL_KEY]) self.avatarURL = dict[AVATAR_URL_KEY];
  if (dict[ALLOW_BROWSE_KEY]) self.allowBrowse = dict[ALLOW_BROWSE_KEY];
  if (dict[IDENTIFY_TOKEN_KEY]) self.identifyToken = dict[IDENTIFY_TOKEN_KEY];
}

#pragma mark - NSCoding methods
// 为了把User对象存到NSUserDefaults里面，需要实现NSCoding protocol中的方法。

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.username forKey:USERNAME_KEY];
  [aCoder encodeObject:self.bio forKey:BIO_KEY];
  [aCoder encodeObject:self.location forKey:LOCATION_KEY];
  [aCoder encodeObject:self.score forKey:SCORE_KEY];
  [aCoder encodeObject:self.avatarURL forKey:AVATAR_URL_KEY];
  [aCoder encodeObject:self.allowBrowse forKey:ALLOW_BROWSE_KEY];
  [aCoder encodeObject:self.identifyToken forKey:IDENTIFY_TOKEN_KEY];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super init]) {
    self.username = [aDecoder decodeObjectForKey:USERNAME_KEY];
    self.bio = [aDecoder decodeObjectForKey:BIO_KEY];
    self.location = [aDecoder decodeObjectForKey:LOCATION_KEY];
    self.score = [aDecoder decodeObjectForKey:SCORE_KEY];
    self.avatarURL = [aDecoder decodeObjectForKey:AVATAR_URL_KEY];
    self.allowBrowse = [aDecoder decodeObjectForKey:ALLOW_BROWSE_KEY];
    self.identifyToken = [aDecoder decodeObjectForKey:IDENTIFY_TOKEN_KEY];
  }
  return self;
}

@end
