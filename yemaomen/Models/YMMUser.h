//
//  YMMUser.h
//  yemaomen
//
//  Created by Zhu Weifeng on 12/27/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMMUser : NSObject
<
NSCoding
>

@property (nonatomic, strong, readonly) NSString *username;
@property (nonatomic, strong, readonly) NSString *bio;
@property (nonatomic, strong, readonly) NSString *location;
@property (nonatomic, strong, readonly) NSNumber *score;
@property (nonatomic, strong, readonly) NSString *avatarURL;
@property (nonatomic, strong, readonly) NSNumber *allowBrowse;
@property (nonatomic, strong, readonly) NSString *identifyToken;

+ (YMMUser *)currentUser;

- (id)initWithDictionary:(NSDictionary *)dict;
- (void)updateUserInfoWithDictionary:(NSDictionary *)dict;

@end
