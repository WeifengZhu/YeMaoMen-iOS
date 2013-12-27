//
//  YMMBaseCustomCell.m
//  yemaomen
//
//  Created by Zhu Weifeng on 12/27/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import "YMMBaseCustomCell.h"

// YMMBaseCustomCellView这个类只会被YMMBaseCustomCell用到，所以放到这里。
@interface YMMBaseCustomCellView : UIView

@end

@implementation YMMBaseCustomCellView

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Initialization code
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  // iOS 7中的Cell层次发生了变化。
  // http://www.curiousfind.com/blog/646
	[(YMMBaseCustomCell *)[[self superview] superview] drawCellContentView:rect];
}

@end

@implementation YMMBaseCustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // Initialization code
    _customContentView = [[YMMBaseCustomCellView alloc] initWithFrame:CGRectZero];
    _customContentView.opaque = YES;
    [self addSubview:_customContentView];
  }
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNeedsDisplay {
	[super setNeedsDisplay];
	[_customContentView setNeedsDisplay];
}

- (void)drawCellContentView:(CGRect)rect {
	// subclasses should implement this
}

@end
