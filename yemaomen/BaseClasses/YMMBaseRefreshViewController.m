//
//  YMMBaseRefreshViewController.m
//  yemaomen
//
//  Created by Zhu Weifeng on 11/17/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//
/*
 使用说明：
 1. 子类要完成下拉刷新或加载更多，需要实现或调用interface methods中的方法。
 2. extension中有些ivar是子类可以使用的，不用自己去构建。
 */

#import "YMMBaseRefreshViewController.h"

#define FOOTER_VIEW_HEIGHT 44.0

@interface YMMBaseRefreshViewController () {
  /** 子类一般用不到的ivar **/
  
  // 当TableView被scroll的时候，如果已经到了TableView的下边界（不含tableFooter），如果继续scroll，就会露出这个footerView。
  // 加载更多的时候，就会在这个footerView上显示一些文字或效果（例：让_activityIndicatorView转动起来等）。
  // 本身加载更多的逻辑判断和这个footerView没有关系。可以参看scroll相关的delegate方法。
  UIView *_footerView;
  // 显示在footerView上的ActivityIndicator
  UIActivityIndicatorView *_activityIndicatorView;
  
  // 是否正在进行相关加载的标识。
  BOOL _isLoadingLatest;
  BOOL _isLoadingMore;
}

@end

@implementation YMMBaseRefreshViewController

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Uncomment the following line to preserve selection between presentations.
  // self.clearsSelectionOnViewWillAppear = NO;

  // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
  // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
  // 添加下拉刷新控件
  UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
  [refreshControl addTarget:self action:@selector(loadingLatestData) forControlEvents:UIControlEventValueChanged];
  // 如果要改变刷新控件的颜色的话，修改下面这行代码。
  // refreshControl.tintColor = [UIColor colorWithRed:255.0 green:255.0 blue:255.0 alpha:1.0];
  self.refreshControl = refreshControl;
  
  self.screenWidth = self.tableView.frame.size.width;
  self.requestOperationManager = [AFHTTPRequestOperationManager manager];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - interface methods
// pragma mark注释：在.h文件中声明的别人能调用的方法

// 设置TableView的footerView，当加载更多的时候，需要在footerView上展现一些文字或效果。
// 是否有footerView也是是否进行load more的一个判断条件。
- (void)setupLoadMoreFooterView {
  YMMLOG(@"class: %@, _cmd: %@",[self class], NSStringFromSelector(_cmd));
  
  if (_footerView == nil) {
    _footerView = [[UIView alloc] init];
    _footerView.frame = CGRectMake(0, 0, _screenWidth, FOOTER_VIEW_HEIGHT);
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.center = _footerView.center;
    _activityIndicatorView.hidesWhenStopped = YES;
    [_footerView addSubview:_activityIndicatorView];
  }
  self.tableView.tableFooterView = _footerView;
}

// 设置footerView为nil，load more的时候会判断是否有footerView。
// 如果已经没有更多内容可以加载了，可以调用这个方法，从而避免继续无效加载。
- (void)removeLoadMoreFootView {
  if (_footerView) {
    self.tableView.tableFooterView = nil;
  }
}

// 子类需override此方法，来实现loadingLatestData功能。
// override的时候记得调用[super loadingLatestData];
- (void)loadingLatestData {
  YMMLOG(@"class: %@, _cmd: %@",[self class], NSStringFromSelector(_cmd));
  // loadingLatestFinished会end这个refresh
  [self.refreshControl beginRefreshing];
  _isLoadingLatest = YES;
}

// 子类需override此方法，来实现loadingMoreData功能。
// override的时候记得调用[super loadingMoreData];
- (void)loadingMoreData {
  YMMLOG(@"class: %@, _cmd: %@",[self class], NSStringFromSelector(_cmd));
  if (_isLoadingMore) return;
  [_activityIndicatorView startAnimating];
  _isLoadingMore = YES;
}

// 子类在completeBlock或failBlock中记得调用这个方法([self loadLatestFinished])来收尾。
- (void)loadLatestFinished {
  _isLoadingLatest = NO;
  [self.refreshControl endRefreshing];
}

// 子类在completeBlock或failBlock中记得调用这个方法([self loadMoreFinished])来收尾。
- (void)loadMoreFinished {
  _isLoadingMore = NO; 
  [_activityIndicatorView stopAnimating];
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  // 不正在进行加载更多，并且已经设置了加载更多时候需要展现文字或效果的载体（footerView）。
  if (!_isLoadingMore && self.tableView.tableFooterView) {
    CGFloat scrollOffset = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y;
    // 这个触发条件和是否设置了footerView没有关系。设置footerView的话，contentSize.height和contentOffset.y都会增加，刚好抵消。
    // 确保有footerView是为了能有地方展现文字或效果。另外，如果已经没有东西可以load more了，就可以通过remove footer，从而避免进入这个判断。
    if (scrollOffset < 0) {
      [self loadingMoreData];
    }
  }
}

@end
