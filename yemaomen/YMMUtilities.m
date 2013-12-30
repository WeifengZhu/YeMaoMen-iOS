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

NSString *const ServerHost = @"http://192.168.32.198:3000";

#endif

@implementation YMMUtilities

+ (UIColor *)cellHighlightedGrayColor {
  return [UIColor colorWithRed:217.0 green:217.0 blue:217.0 alpha:0.0];
}

@end
