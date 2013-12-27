//
//  YMMPost.m
//  yemaomen
//
//  Created by Zhu Weifeng on 12/27/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import "YMMPost.h"

@interface YMMPost ()

// 注意这里使用了readwrite，头文件里面是 readonly。
@property (nonatomic, strong, readwrite) NSNumber *ID;
@property (nonatomic, strong, readwrite) NSString *content;
@property (nonatomic, strong, readwrite) NSNumber *topicID;
@property (nonatomic, strong, readwrite) NSNumber *likeCount;
@property (nonatomic, strong, readwrite) NSString *updatedAt;
@property (nonatomic, strong, readwrite) YMMUser *user;
@property (nonatomic, strong, readwrite) YMMPost *parentPost;

@end

@implementation YMMPost

- (id)initWithDictionary:(NSDictionary *)dict {
  if (self = [super init]) {
    if (dict[@"id"]) self.ID = dict[@"id"];
    if (dict[@"content"]) self.content = dict[@"content"];
    if (dict[@"topicID"]) self.topicID = dict[@"topicID"];
    if (dict[@"updatedAt"]) self.updatedAt = dict[@"updatedAt"];
    if (dict[@"user"]) self.user = [[YMMUser alloc] initWithDictionary:dict[@"user"]];
    if (dict[@"parentPost"]) self.parentPost = [[YMMPost alloc] initWithDictionary:dict[@"parentPost"]];
  }
  return self;
}

@end
