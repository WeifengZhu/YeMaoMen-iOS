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
// FINAL_RELEASE是在building settings中添加的宏定义，debug中没有定义这个值，所以会打印，release中定义了这个值，所以不会打印。
// 任何需要判断是不是release而进行条件编译的代码都可以用这个句式。
#if defined(FINAL_RELEASE)
  #define YMMLOG(format, ...)
#else
  #define YMMLOG(format, ...) NSLog(@"%@", [NSString stringWithFormat: format, ## __VA_ARGS__]);
#endif

// 全局宏定义结束

@interface YMMUtilities : NSObject

@end
