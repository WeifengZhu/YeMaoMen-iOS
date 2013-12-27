//
//  YMMSecondViewCell.m
//  yemaomen
//
//  Created by Zhu Weifeng on 12/27/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import "YMMSecondViewCell.h"

@implementation YMMSecondViewCell

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

- (void)drawRect:(CGRect)rect {
  YMMLOG(@"class: %@, _cmd: %@",[self class], NSStringFromSelector(_cmd));
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  
	UIColor *backgroundColor = [UIColor redColor];
	UIColor *textColor = [UIColor blackColor];
	if(self.selected) {
		backgroundColor = [UIColor grayColor];
		textColor = [UIColor whiteColor];
	}
	
  // 画背景
	[backgroundColor set];
	CGContextFillRect(context, rect);
	
  // 画字
	CGPoint point;
	point.x = 42;
	point.y = 9;
	[textColor set];
	[self.cellContent drawAtPoint:point withAttributes:nil];
}

#pragma mark - custom setters & getters

// override这个setter是因为要加setNeedsDisplay。
- (void)setCellContent:(NSString *)cellContent {
  _cellContent = cellContent;
  [self setNeedsDisplay];
}

@end
