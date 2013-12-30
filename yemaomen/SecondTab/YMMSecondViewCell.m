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
}

+ (CGFloat)cellHeightForPost:(YMMPost *)post {
  CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
  CGFloat contentWidth = screenWidth - ContentLeftMargin - ContentRightMargin;
  CGFloat contentHeight = [post.content sizeWithFont:ContentFont
                                   constrainedToSize:CGSizeMake(contentWidth, CGFLOAT_MAX)
                                       lineBreakMode:NSLineBreakByWordWrapping].height;
  CGFloat cellHeight = NameTopMargin + NameHeight + ContentTopMargin + contentHeight + ContentBottomMargin;
  return cellHeight;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // Initialization code
  }
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - super class methods implementation

- (void)drawCellContentView:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  
	UIColor *backgroundColor = [UIColor whiteColor];
	if(self.highlighted) {
		backgroundColor = [YMMUtilities cellHighlightedGrayColor];
	}
	
  // 画背景
	[backgroundColor set];
	CGContextFillRect(context, rect);
  
  // 画name
  [self.name drawAtPoint:CGPointMake(NameLeftMargin, NameTopMargin) withAttributes:@{ NSFontAttributeName: NameFont,
                                                                                      NSForegroundColorAttributeName: [UIColor blackColor] }];
  // 画x 赞
  NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
  [style setAlignment:NSTextAlignmentRight];
  [self.likeCount drawInRect:CGRectMake(0, LikeTopMargin, rect.size.width - LikeRightMargin, LikeHeight)
              withAttributes:@{ NSParagraphStyleAttributeName: style,
                                NSFontAttributeName: LikeFont,
                                NSForegroundColorAttributeName: [UIColor grayColor] }];
  
  // 画内容
  [self.content drawInRect:CGRectMake(ContentLeftMargin,
                                      NameTopMargin + NameHeight + ContentTopMargin,
                                      rect.size.width - ContentLeftMargin - ContentRightMargin,
                                      CGFLOAT_MAX)
            withAttributes:@{ NSFontAttributeName: ContentFont,
                              NSForegroundColorAttributeName: [UIColor blackColor] }];
}

#pragma mark - custom setters & getters

// override这个setter是因为要加setNeedsDisplay。
- (void)setContent:(NSString *)content {
  _content = content;
  [self setNeedsDisplay];
}

- (void)setName:(NSString *)name {
  _name = name;
  [self setNeedsDisplay];
}

- (void)setLikeCount:(NSString *)likeCount {
  _likeCount = likeCount;
  [self setNeedsDisplay];
}

@end
