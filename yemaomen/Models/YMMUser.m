//
//  YMMUser.m
//  yemaomen
//
//  Created by Zhu Weifeng on 12/27/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import "YMMUser.h"

@interface YMMUser ()

@property (nonatomic, strong, readwrite) NSString *username;
@property (nonatomic, strong, readwrite) NSString *bio;
@property (nonatomic, strong, readwrite) NSString *location;
@property (nonatomic, strong, readwrite) NSNumber *score;
@property (nonatomic, strong, readwrite) NSString *avatarURL;
@property (nonatomic, strong, readwrite) NSNumber *allowBrowse;
@property (nonatomic, strong, readwrite) NSString *identifyToken;

@end

@implementation YMMUser

/**
 获取当前客户端登录的User。这个单例方法不是严格的单例，还是可以通过[[YMMUser alloc] init]或initWithDictionary来创建User对象。因为这个User model在多个地方被用到了，也确实不需要唯一。但客户端当前登录的User是唯一的，都是通过这个方法获取的，第一次被获取的时候初始化一次。
 */
+ (YMMUser *)currentUser {
  static dispatch_once_t pred;
  static YMMUser *instance = nil;
  dispatch_once(&pred, ^{ instance = [[self alloc] init]; });
  return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict {
  if (self = [super init]) {
    if (dict[@"username"]) self.username = dict[@"username"];
    if (dict[@"bio"]) self.bio = dict[@"bio"];
    if (dict[@"location"]) self.location = dict[@"location"];
    if (dict[@"score"]) self.score = dict[@"score"];
    if (dict[@"avatarURL"]) self.avatarURL = dict[@"avatarURL"];
    if (dict[@"allowBrowse"]) self.allowBrowse = dict[@"allowBrowse"];
    if (dict[@"identifyToken"]) self.identifyToken = dict[@"identifyToken"];
  }
  return self;
}

- (void)updateUserInfoWithDictionary:(NSDictionary *)dict {
  if (dict[@"username"]) self.username = dict[@"username"];
  if (dict[@"bio"]) self.bio = dict[@"bio"];
  if (dict[@"location"]) self.location = dict[@"location"];
  if (dict[@"score"]) self.score = dict[@"score"];
  if (dict[@"avatarURL"]) self.avatarURL = dict[@"avatarURL"];
  if (dict[@"allowBrowse"]) self.allowBrowse = dict[@"allowBrowse"];
  if (dict[@"identifyToken"]) self.identifyToken = dict[@"identifyToken"];
}

@end
