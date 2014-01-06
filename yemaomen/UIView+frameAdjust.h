//
//  UIView+frameAdjust.h
//  yemaomen
//
//  Created by Zhu Weifeng on 12/26/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (frameAdjust)

- (CGPoint)origin;
- (void)setOrigin:(CGPoint)point;

- (CGSize)size;
- (void)setSize:(CGSize)size;

- (CGFloat)x;
- (void)setX:(CGFloat)x;

- (CGFloat)y;
- (void)setY:(CGFloat)y;

- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

- (CGFloat)bottom;
- (void)setBottom:(CGFloat)bottom;

- (CGFloat)right;
- (void)setRight:(CGFloat)right;

@end
