//
//  SecondViewController.m
//  yemaomen
//
//  Created by Zhu Weifeng on 10/8/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import "YMMSecondViewController.h"
#import "YMMSecondViewCell.h"
#import "YMMFirstViewController.h"

@interface YMMSecondViewController () {
  
}

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
  
  NSString *urlString = [NSString stringWithFormat:@"%@/posts", ServerHost];
  [self.requestOperationManager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
    YMMLOG(@"success, responseObject: %@", responseObject);
    self.tableViewContents = [NSMutableArray arrayWithArray:responseObject];
    [self.tableView reloadData];
    [self setupLoadMoreFooterView];
    [self loadLatestFinished];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    YMMLOG(@"failure, error: %@", error);
    [self loadLatestFinished];
  }];
}

- (void)loadingMoreData {
  YMMLOG(@"class: %@, _cmd: %@",[self class], NSStringFromSelector(_cmd));
  
  [super loadingMoreData];
  
  NSString *beforeTimestamp = [self.tableViewContents.lastObject objectForKey:@"updatedAt"];
  NSDictionary *params = @{ @"before_timestamp": beforeTimestamp };
  YMMLOG(@"params: %@", params);
  NSString *urlString = [NSString stringWithFormat:@"%@/posts", ServerHost];
  [self.requestOperationManager GET:urlString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    YMMLOG(@"success, responseObject: %@", responseObject);
    
    // 如果服务器返回的数据条数已经小于默认的page_size了，那么就移除加载更多的footer view。
    // 注意，如果调用API的时候传的page_size不是20的话，这里的值（20）要和具体的page_size对应。
    if (((NSArray *)responseObject).count < 20) {
      [self removeLoadMoreFootView];
    }
    
    [self.tableViewContents addObjectsFromArray:responseObject];
    [self.tableView reloadData];
    [self loadMoreFinished];
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    YMMLOG(@"failure, error: %@", error);
    [self loadMoreFinished];
  }];
}

#pragma mark - table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.tableViewContents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"CellIdentifier";
  YMMSecondViewCell *cell = (YMMSecondViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (!cell) {
    cell = [[YMMSecondViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  cell.cellContent = [self.tableViewContents[indexPath.row] valueForKey:@"content"];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
