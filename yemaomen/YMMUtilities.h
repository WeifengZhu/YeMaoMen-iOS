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

// 全局常量开始

FOUNDATION_EXPORT NSString *const ServerHost;

// YMMUtilities.m中的一部分代码会进行条件编译，如果要dev环境，则注释掉下面这行宏，要prod环境，则释放注释。
// 因为别的地方也需要用到这个宏，所以放到这里来了。其他地方只要#import了这个头文件就可以使用这个宏了。
// 所以，这个宏全局控制了整个App的环境，要dev环境，注释掉此宏，要prod环境，释放注释此宏。
// 如果只跟build configuration是debug还是release有关的话，其实还可以利用FINAL_RELEASE这个宏，FINAL_RELEASE不需要人工控制，只和debug或release有关。
// 这里使用这个宏定义是因为在debug的build configuration下都有可能需要两套环境，release也有可能。
//#define PRODCUTION

// 全局常量结束

@interface YMMUtilities : NSObject

@end
