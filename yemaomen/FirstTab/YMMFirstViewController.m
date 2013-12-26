//
//  FirstViewController.m
//  yemaomen
//
//  Created by Zhu Weifeng on 10/8/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import "YMMFirstViewController.h"

@interface YMMFirstViewController ()

@end

@implementation YMMFirstViewController

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
    self.title = @"每晚精选";
    self.tabBarItem.image = [UIImage imageNamed:@"first"];
  }
  return self;
}
							
- (void)viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
  
  // 加载最新数据
  [self loadingLatestData];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - data handling

- (void)loadingLatestData {
  YMMLOG(@"class: %@, _cmd: %@",[self class], NSStringFromSelector(_cmd));
  
  [super loadingLatestData];
  
  NSString *urlString = [NSString stringWithFormat:@"%@/topics", ServerHost];
  [self.requestOperationManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

@end
