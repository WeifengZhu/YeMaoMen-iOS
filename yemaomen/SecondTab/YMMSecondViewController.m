//
//  SecondViewController.m
//  yemaomen
//
//  Created by Zhu Weifeng on 10/8/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import "YMMSecondViewController.h"

@interface YMMSecondViewController ()

@end

@implementation YMMSecondViewController

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
    self.title = @"闲扯";
    self.tabBarItem.image = [UIImage imageNamed:@"second"];
  }
  return self;
}
							
- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - data handling

- (void)loadingLatestData {
  YMMLOG(@"class: %@, _cmd: %@",[self class], NSStringFromSelector(_cmd));
  
  [super loadingLatestData];
  
  AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
  NSString *urlString = [NSString stringWithFormat:@"%@/posts", ServerHost];
  [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    YMMLOG(@"success, responseObject: %@", responseObject);
    [self loadLatestFinished];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    YMMLOG(@"failure, error: %@", error);
    [self loadLatestFinished];
  }];
}

- (void)loadingMoreData {
  YMMLOG(@"class: %@, _cmd: %@",[self class], NSStringFromSelector(_cmd));
  
  [super loadingMoreData];
  
}

#pragma mark - table view methods


@end
