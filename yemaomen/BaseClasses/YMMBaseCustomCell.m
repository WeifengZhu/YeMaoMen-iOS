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
  // 如果要兼容iOS 6的话，要加个判断，然后使用下面的代码。
//  [(YMMBaseCustomCell *)[self superview] drawCellContentView:rect];
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

- (void)layoutSubviews {
  // 因为在初始化customContentView的时候，没有设置frame的大小。
  // 所以需要实现此方法，来给customContentView设置frame。
  CGRect bounds = [self bounds];
	[self.customContentView setFrame:bounds];
  [super layoutSubviews];
}

- (void)drawCellContentView:(CGRect)rect {
	// subclasses should implement this
}

@end
