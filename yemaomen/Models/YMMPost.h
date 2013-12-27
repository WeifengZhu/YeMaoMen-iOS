//
//  YMMPost.h
//  yemaomen
//
//  Created by Zhu Weifeng on 12/27/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMMUser.h"

@interface YMMPost : NSObject

@property (nonatomic, strong, readonly) NSNumber *ID;
@property (nonatomic, strong, readonly) NSString *content;
@property (nonatomic, strong, readonly) NSNumber *topicID;
@property (nonatomic, strong, readonly) NSNumber *likeCount;
@property (nonatomic, strong, readonly) NSString *updatedAt;
@property (nonatomic, strong, readonly) YMMUser *user;
@property (nonatomic, strong, readonly) YMMPost *parentPost;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
