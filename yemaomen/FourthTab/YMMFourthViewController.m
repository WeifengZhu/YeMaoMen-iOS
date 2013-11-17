//
//  FourthViewController.m
//  yemaomen
//
//  Created by Zhu Weifeng on 10/8/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import "YMMFourthViewController.h"

@interface YMMFourthViewController ()

@end

@implementation YMMFourthViewController

- (id)init
{
  self = [super init];
  if (self) {
    self.title = @"我";
    self.tabBarItem.image = [UIImage imageNamed:@"fourth"];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
