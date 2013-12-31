//
//  YMMSecondViewCell.h
//  yemaomen
//
//  Created by Zhu Weifeng on 12/27/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMMBaseCustomCell.h"

@class YMMPost;

@interface YMMSecondViewCell : YMMBaseCustomCell

@property (nonatomic, strong) YMMPost *post;

+ (CGFloat)cellHeightForPost:(YMMPost *)post;

@end
