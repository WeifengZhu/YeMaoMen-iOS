//
//  FirstViewController.m
//  yemaomen
//
//  Created by Zhu Weifeng on 10/8/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (id)init
{
  self = [super init];
  if (self) {
    self.title = @"每晚精选";
    self.tabBarItem.image = [UIImage imageNamed:@"first"];
  }
  return self;
}
							
- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
