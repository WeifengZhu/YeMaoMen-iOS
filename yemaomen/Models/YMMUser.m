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

@end

@implementation YMMUser

- (id)initWithDictionary:(NSDictionary *)dict {
  if (self = [super init]) {
    if (dict[@"username"]) self.username = dict[@"username"];
  }
  return self;
}

@end
