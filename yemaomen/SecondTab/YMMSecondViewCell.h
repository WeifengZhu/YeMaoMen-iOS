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
@class YMMSecondViewController;

@interface YMMSecondViewCell : YMMBaseCustomCell
<
UIActionSheetDelegate
>

@property (nonatomic, strong) YMMPost *post;
@property (nonatomic, weak) YMMSecondViewController *parentViewController;

+ (CGFloat)cellHeightForPost:(YMMPost *)post;

@end
