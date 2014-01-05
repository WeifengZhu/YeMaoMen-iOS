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
  // parent post的baseline的y坐标。这个值初始化为parent post的顶部，parent post是基于这个y的相对值来画的，当一个parent post画完的时候，这个值被设置为parent post的底部，也就是下一个parent post的顶部。依次类推。注意parent post被画的顺序和被回复的顺序是反过来的。
  CGFloat _parentBaselineY;
  CGFloat _initialBaselineY; // 如果有parent post，用于记录最初的基线（parent post的顶部），不会随着parent的draw而发生变化。
  NSMutableParagraphStyle *_paragraphStyle;
  YMMPost *_actionTargetPost; // 赞某人或回复某人的对象
  NSMutableArray *_parentPostsArray; // 直接回复的parent post位于[0]处，直接回复的parent post回复的post位于[1]处，以此类推。需要调用[self recursivlyAddParentPostToArray:xxx]来产生正确的值。
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
static CGFloat ParentPostBackgroundLeftMargin; // 回复post背景框距左边的距离
static CGFloat ParentPostBackgroundRightMargin; // 回复post背景框距右边的距离

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
  ParentPostBackgroundLeftMargin = ContentLeftMargin + 8.0;
  ParentPostBackgroundRightMargin = ContentRightMargin + 8.0;
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
    
    _parentPostsArray = [NSMutableArray array];
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
  
  // 计算这个parent post的高度。两个作用：
  // 1. 用于画这个parent post的背景框 2. 更新_parentBaselineY
  CGFloat parentCellHeight = [YMMSecondViewCell parentCellHeightWithContent:parentPost.content];
  // 1. 用于画这个parent post的背景框
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetLineWidth(context, 1.0);
  CGContextSetStrokeColorWithColor(context, [YMMUtilities parentPostBorderColor].CGColor);
  CGRect rect = CGRectMake(ParentPostBackgroundLeftMargin,
                           _parentBaselineY,
                           [UIScreen mainScreen].bounds.size.width - ParentPostBackgroundLeftMargin - ParentPostBackgroundRightMargin,
                           parentCellHeight);
  CGContextAddRect(context, rect);
  CGContextStrokePath(context);
  CGContextSetFillColorWithColor(context, [YMMUtilities parentPostFillColor].CGColor);
  CGContextFillRect(context, rect);
  
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
  
  // 2. 更新_parentBaselineY
  _parentBaselineY += parentCellHeight;
}

/**
 根据touch的y坐标，得出touch点所在的target post。
 @param location
 touch的坐标
 */
- (YMMPost *)getTargetPostWithLocation:(CGPoint)location {
  [self recursivlyAddParentPostToArray:self.post.parentPost];
  
  if (location.y < _initialBaselineY) {
    return self.post;
  }
  
  CGFloat accumulatedY = _initialBaselineY;
  for (int i = _parentPostsArray.count - 1; i >= 0; i--) {
    CGFloat parentPostHeight = [YMMSecondViewCell parentCellHeightWithContent:((YMMPost *)_parentPostsArray[i]).content];
    accumulatedY += parentPostHeight;
    if (location.y <= accumulatedY) {
      return _parentPostsArray[i];
    }
  }
  
  return self.post;
}

/**
 将parent post递归的加入到ivar _parentPostsArray里面. 直接回复的parent post位于[0]处。调用过这个方法之后，_parentPostsArray里面才会有正确的值。
 @param parentPost
 直接回复的parent post。
 */
- (void)recursivlyAddParentPostToArray:(YMMPost *)parentPost {
  [_parentPostsArray addObject:parentPost];
  if (parentPost.parentPost) {
    [self recursivlyAddParentPostToArray:parentPost.parentPost];
  }
}

#pragma mark - override methods

/**
 Override这个方法，主要是为了处理touch事件。如果touch在parent post里面，则弹出针对parent post的action sheet：赞 xxx， 回复 xxx。如果touch不在parent post里面，则弹出的action sheet是针对本post的。
 */
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  YMMLOG(@"class: %@, _cmd: %@",[self class], NSStringFromSelector(_cmd));
  
  [super touchesEnded:touches withEvent:event];
  
  // 获取touch相对self.contentView的坐标。
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self.contentView];
  YMMLOG(@"touch location: x - %f, y - %f", location.x, location.y);
  
  // 先判断x，如果不在框内，则回复本post或赞本post。如果这个没有直接回复的post，也是回复本post或赞本post。
  if (location.x < ParentPostBackgroundLeftMargin ||
      location.x > ([UIScreen mainScreen].bounds.size.width - ParentPostBackgroundRightMargin) ||
      !self.post.parentPost) {
    _actionTargetPost = self.post;
    
    // YMMTODO: 弹出action sheet。
    
  }
  
  if (self.post.parentPost) {
    // 有parentPost才进行下面的动作。
    _actionTargetPost = [self getTargetPostWithLocation:location];
    
    // YMMTODO: 弹出action sheet。
  }
}

#pragma mark - super class methods implementation

- (void)drawCellContentView:(CGRect)rect {
  // 设置基线的y坐标
  _parentBaselineY = NameTopMargin + NameHeight + ContentTopMargin;
  _initialBaselineY = _parentBaselineY;
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  
	UIColor *backgroundColor = [UIColor whiteColor];
  // highlighted的时候用同一种背景色
	if(self.highlighted) {
		backgroundColor = [YMMUtilities cellHighlightedGrayColor];
	}
	
  // 画背景
	[backgroundColor set];
	CGContextFillRect(context, rect);
  
  if (self.post.parentPost) {
    [self recursivlyDrawParentPost:self.post.parentPost];
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
