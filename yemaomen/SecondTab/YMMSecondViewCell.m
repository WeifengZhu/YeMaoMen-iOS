//
//  YMMSecondViewCell.m
//  yemaomen
//
//  Created by Zhu Weifeng on 12/27/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import "YMMSecondViewCell.h"
#import "YMMPost.h"
#import "UIView+frameAdjust.h"

@interface YMMSecondViewCell () {
  CGFloat _parentBaselineY; // 直接回复的post的baseline（底部框线）的y坐标
  NSMutableParagraphStyle *_paragraphStyle;
}

@end

@implementation YMMSecondViewCell

static UIFont *NameFont = nil;
static UIFont *LikeFont = nil;
static UIFont *ContentFont = nil;
static CGFloat NameTopMargin; // 名字距上边的距离
static CGFloat NameLeftMargin; // 名字距左边的距离
static CGFloat NameHeight; // 名字的高度
static CGFloat LikeTopMargin; // x 赞距上边的距离
static CGFloat LikeRightMargin; // x 赞距右边的距离
static CGFloat LikeHeight; // 赞的高度
static CGFloat ContentTopMargin; // 内容距名字的距离
static CGFloat ContentBottomMargin; // 内容距下边的距离
static CGFloat ContentLeftMargin; // 内容距左边的距离
static CGFloat ContentRightMargin; // 内容距右边的距离
static CGFloat ParentPostContentTopMargin; // 被回复内容距被回复作者的距离
static UIFont *NameFontParent = nil; // 回复中名字的字体
static UIFont *LikeFontParent = nil; // 回复中x 赞的字体

+ (void)initialize {
  NameFont = [UIFont boldSystemFontOfSize:16];
  LikeFont = [UIFont systemFontOfSize:14];
  ContentFont = [UIFont systemFontOfSize:15];
  NameTopMargin = 10.0;
  NameLeftMargin = 15.0;
  NameHeight = 15.0;
  LikeTopMargin = 12.0;
  LikeRightMargin = 20.0;
  LikeHeight = 15.0;
  ContentTopMargin = 10.0;
  ContentBottomMargin = 10.0;
  ContentLeftMargin = NameLeftMargin;
  ContentRightMargin = 15.0;
  ParentPostContentTopMargin = 5.0;
  NameFontParent = [UIFont systemFontOfSize:14];
  LikeFontParent = [UIFont systemFontOfSize:12];
}

+ (CGFloat)cellHeightForPost:(YMMPost *)post {
  CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
  CGFloat contentWidth = screenWidth - ContentLeftMargin - ContentRightMargin;
  CGFloat contentHeight = [post.content sizeWithFont:ContentFont
                                   constrainedToSize:CGSizeMake(contentWidth, CGFLOAT_MAX)
                                       lineBreakMode:NSLineBreakByWordWrapping].height;
  CGFloat cellHeight = NameTopMargin + NameHeight + ContentTopMargin + contentHeight + ContentBottomMargin;
  if (post.parentPost) {
    cellHeight += [YMMSecondViewCell parentCellsTotalHeight:post.parentPost] + ContentTopMargin;
  }
  return cellHeight;
}

/**
 计算除了自己外的所有楼的高度。
 @param parentPost
 直接回复的post
 @return 高度
 */
+ (CGFloat)parentCellsTotalHeight:(YMMPost *)parentPost {
  CGFloat height = [YMMSecondViewCell parentCellHeightWithContent:parentPost.content];
  if (parentPost.parentPost) {
    height += [YMMSecondViewCell parentCellsTotalHeight:parentPost.parentPost];
  }
  return height;
}

+ (CGFloat)parentCellHeightWithContent:(NSString *)content {
  CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
  CGFloat contentWidth = screenWidth - ContentLeftMargin * 2 - ContentRightMargin * 2;
  CGFloat contentHeight = [content sizeWithFont:ContentFont
                              constrainedToSize:CGSizeMake(contentWidth, CGFLOAT_MAX)
                                  lineBreakMode:NSLineBreakByWordWrapping].height;
  CGFloat parentCellHeight = NameTopMargin + NameHeight + ParentPostContentTopMargin + contentHeight + ContentBottomMargin;
  return parentCellHeight;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // Initialization code
    _paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    [_paragraphStyle setAlignment:NSTextAlignmentRight];
  }
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 因为这个post有可能是回复别人的。被回复的post也可能是回复别人的。所以需要能够递归地画post，实现类似网易盖楼的效果。
 @param parentPost
 这个post直接回复的post。
 */
- (void)recursivlyDrawParentPost:(YMMPost *)parentPost {
  if (parentPost.parentPost) {
    [self recursivlyDrawParentPost:parentPost.parentPost];
  }
  // 实际画的代码
  // 画name
  [parentPost.user.username drawAtPoint:CGPointMake(NameLeftMargin * 2, NameTopMargin + _parentBaselineY )
                         withAttributes:@{ NSFontAttributeName: NameFontParent,
                                           NSForegroundColorAttributeName: [UIColor blackColor] }];
  // 画x 赞
  NSString *likeCountString = [parentPost.likeCount isKindOfClass:[NSNull class]] ? @"0" : [NSString stringWithFormat:@"%@", parentPost.likeCount];
  [likeCountString drawInRect:CGRectMake(0, LikeTopMargin + _parentBaselineY, [UIScreen mainScreen].bounds.size.width - LikeRightMargin * 2, LikeHeight)
               withAttributes:@{ NSParagraphStyleAttributeName: _paragraphStyle,
                                 NSFontAttributeName: LikeFontParent,
                                 NSForegroundColorAttributeName: [UIColor grayColor] }];
  // 画内容
  [parentPost.content drawInRect:CGRectMake(ContentLeftMargin + ContentLeftMargin,
                                      NameTopMargin + NameHeight + ParentPostContentTopMargin + _parentBaselineY,
                                      [UIScreen mainScreen].bounds.size.width - ContentLeftMargin * 2 - ContentRightMargin * 2,
                                      CGFLOAT_MAX)
            withAttributes:@{ NSFontAttributeName: ContentFont,
                              NSForegroundColorAttributeName: [UIColor blackColor] }];
  // 计算这个parent cell的高度，更新_parentBaselineY。
  CGFloat parentCellHeight = [YMMSecondViewCell parentCellHeightWithContent:parentPost.content];
  _parentBaselineY += parentCellHeight;
}

#pragma mark - super class methods implementation

- (void)drawCellContentView:(CGRect)rect {
  // 设置基线的y坐标
  _parentBaselineY = NameTopMargin + NameHeight + ContentTopMargin;
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  
	UIColor *backgroundColor = [UIColor whiteColor];
  // highlighted的时候用同一种背景色
//	if(self.highlighted) {
//		backgroundColor = [YMMUtilities cellHighlightedGrayColor];
//	}
	
  // 画背景
	[backgroundColor set];
	CGContextFillRect(context, rect);
  
  if (self.post.parentPost) {
    [self recursivlyDrawParentPost:self.post.parentPost];
  } else {
    _parentBaselineY = 0.0;
  }
  
  // 画name
  [self.post.user.username drawAtPoint:CGPointMake(NameLeftMargin, NameTopMargin) withAttributes:@{ NSFontAttributeName: NameFont,
                                                                                                    NSForegroundColorAttributeName: [UIColor blackColor] }];
  // 画x 赞
  NSString *likeCountString = [self.post.likeCount isKindOfClass:[NSNull class]] ? @"0 赞" : [NSString stringWithFormat:@"%@ 赞", self.post.likeCount];
  [likeCountString drawInRect:CGRectMake(0, LikeTopMargin, rect.size.width - LikeRightMargin, LikeHeight)
               withAttributes:@{ NSParagraphStyleAttributeName: _paragraphStyle,
                                 NSFontAttributeName: LikeFont,
                                 NSForegroundColorAttributeName: [UIColor grayColor] }];
  // 画内容
  CGFloat contentY;
  if (self.post.parentPost) {
    contentY = ContentTopMargin + _parentBaselineY;
  } else {
    contentY = NameTopMargin + NameHeight + ContentTopMargin;
  }
  [self.post.content drawInRect:CGRectMake(ContentLeftMargin,
                                           contentY,
                                           rect.size.width - ContentLeftMargin - ContentRightMargin,
                                           CGFLOAT_MAX)
                 withAttributes:@{ NSFontAttributeName: ContentFont,
                                   NSForegroundColorAttributeName: [UIColor blackColor] }];
}

#pragma mark - custom setters & getters

// override这个setter是因为要加setNeedsDisplay。
- (void)setPost:(YMMPost *)post {
  _post = post;
  [self setNeedsDisplay];
}

@end
