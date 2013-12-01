//
//  YMMUtilities.h
//  yemaomen
//
//  Created by Zhu Weifeng on 12/1/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import <Foundation/Foundation.h>

// 全局宏定义开始

// Custom Logging
#if defined(FINAL_RELEASE)
  #define YMMLOG(format, ...)
#else
  #define YMMLOG(format, ...) NSLog([NSString stringWithFormat: format, ## __VA_ARGS__]);
#endif

// 全局宏定义结束

@interface YMMUtilities : NSObject

@end
