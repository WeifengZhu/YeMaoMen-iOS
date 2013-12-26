//
//  UIView+frameAdjust.m
//  yemaomen
//
//  Created by Zhu Weifeng on 12/26/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import "UIView+frameAdjust.h"

@implementation UIView (frameAdjust)

- (CGPoint)origin {
  return self.frame.origin;
}

- (void)setOrigin:(CGPoint)point {
  self.frame = CGRectMake(point.x, point.y, self.frame.size.width, self.frame.size.height);
}

- (CGSize)size {
  return self.frame.size;
}

- (void)setSize:(CGSize)size {
  self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}

- (CGFloat)x {
  return self.frame.origin.x;
}

- (void)setX:(CGFloat)x {
  self.frame = CGRectMake(x, self.y, self.width, self.height);
}

- (CGFloat)y {
  return self.frame.origin.y;
}

- (void)setY:(CGFloat)y {
  self.frame = CGRectMake(self.x, y, self.width, self.height);
}

- (CGFloat)height {
  return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
  self.frame = CGRectMake(self.x, self.y, self.width, height);
}

- (CGFloat)width {
  return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
  self.frame = CGRectMake(self.x, self.y, width, self.height);
}

- (CGFloat)bottom {
  return self.y + self.height;
}

- (void)setBottom:(CGFloat)bottom {
  self.frame = CGRectMake(self.x, bottom - self.height, self.width, self.height);
}

- (CGFloat)right {
  return self.x + self.width;
}

- (void)setRight:(CGFloat)right {
  self.frame = CGRectMake(right - self.width, self.y, self.width, self.height);
}

@end
