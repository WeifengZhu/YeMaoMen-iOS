//
//  YMMBaseCustomCellView.m
//  yemaomen
//
//  Created by Zhu Weifeng on 12/27/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import "YMMBaseCustomCellView.h"
#import "YMMBaseCustomCell.h"

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
