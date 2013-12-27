//
//  YMMUser.h
//  yemaomen
//
//  Created by Zhu Weifeng on 12/27/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMMUser : NSObject

- (id)initWithDictionary:(NSDictionary *)dict;

@property (nonatomic, strong, readonly) NSString *username;

@end
