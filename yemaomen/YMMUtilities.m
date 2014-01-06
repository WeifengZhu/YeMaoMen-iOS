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

//NSString *const ServerHost = @"http://192.168.32.186:3000";
//NSString *const ServerHost = @"http://192.168.1.104:3000";
NSString *const ServerHost = @"http://localhost:3000";

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

#pragma mark - colors

+ (UIColor *)cellHighlightedGrayColor {
  return [YMMUtilities colorFromRGBString:@"#D9D9D9"];
}

+ (UIColor *)parentPostBorderColor {
  return [YMMUtilities colorFromRGBString:@"#E8E7D2"];
}

+ (UIColor *)parentPostFillColor {
  return [YMMUtilities colorFromRGBString:@"#F9F8E9"];
}

/**
 根据RGB字符串值获取UIColor。
 Example usage:
 @code
 UIColor *color = [YMMUtilities colorFromRGB:@"042B51"];
 UIColor *color = [YMMUtilities colorFromRGB:@"#042B51"];
 @endcode
 @param stringToConvert
 16进制颜色字符串值，类似：042B51 或 #042B51。
 */
+ (UIColor *)colorFromRGBString:(NSString *)stringToConvert {
  NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
  
  // String should be 6 or 8 characters
  if ([cString length] < 6) {
    return [UIColor blackColor];
  }
  
  // strip 0X if it appears
  if ([cString hasPrefix:@"0X"]) {
    cString = [cString substringFromIndex:2];
  }
  
  // strip # if it appears
  if ([cString hasPrefix:@"#"]) {
    cString = [cString substringFromIndex:1];
  }
  
  if ([cString length] != 6) {
    return [UIColor blackColor];
  }
  
  // Separate into r, g, b substrings
  NSRange range;
  range.location = 0;
  range.length = 2;
  NSString *rString = [cString substringWithRange:range];
  
  range.location = 2;
  NSString *gString = [cString substringWithRange:range];
  
  range.location = 4;
  NSString *bString = [cString substringWithRange:range];
  
  // Scan values
  unsigned int r, g, b;
  [[NSScanner scannerWithString:rString] scanHexInt:&r];
  [[NSScanner scannerWithString:gString] scanHexInt:&g];
  [[NSScanner scannerWithString:bString] scanHexInt:&b];
  
  return [UIColor colorWithRed:( (float)r / 255.0f )
                         green:( (float)g / 255.0f )
                          blue:( (float)b / 255.0f )
                         alpha:1.0f];
}

@end
