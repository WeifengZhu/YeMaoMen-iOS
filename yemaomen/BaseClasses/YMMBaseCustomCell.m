//
//  YMMBaseCustomCell.m
//  yemaomen
//
//  Created by Zhu Weifeng on 12/27/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import "YMMBaseCustomCell.h"
#import "YMMBaseCustomCellView.h"

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
