//
//  YMMBaseCustomCell.h
//  yemaomen
//
//  Created by Zhu Weifeng on 12/27/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import <UIKit/UIKit.h>

// to use: subclass YMMBaseCustomCell and implement -drawContentView:

@interface YMMBaseCustomCell : UITableViewCell

@property (nonatomic, strong) UIView *customContentView;

- (void)drawCellContentView:(CGRect)rect; // subclasses should implement

@end
