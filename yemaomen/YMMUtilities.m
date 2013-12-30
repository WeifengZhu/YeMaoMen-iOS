//
//  YMMUtilities.m
//  yemaomen
//
//  Created by Zhu Weifeng on 12/1/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import "YMMUtilities.h"

#ifdef PRODCUTION

NSString *const ServerHost = @"http://localhost:3000";

#else

//NSString *const ServerHost = @"http://192.168.32.198:3000";
NSString *const ServerHost = @"http://192.168.1.104:3000";

#endif

@implementation YMMUtilities

+ (YMMUtilities *)sharedInstance {
  static dispatch_once_t pred;
  static YMMUtilities *instance = nil;
  dispatch_once(&pred, ^{ instance = [[self alloc] initSingleton]; });
  return instance;
}

- (id)init {
  // Forbid calls to –init or +new
  NSAssert(NO, @"不能使用init来初始化YMMUtilities单例");
  return nil;
}

// Real (private) init method
- (id)initSingleton {
  self = [super init];
  if ((self = [super init])) {
    // 初始化Cache
    _secondViewCellHeightCache = [[NSCache alloc] init];
  }
  return self;
}

+ (UIColor *)cellHighlightedGrayColor {
  return [UIColor colorWithRed:217.0 green:217.0 blue:217.0 alpha:0.0];
}

@end
