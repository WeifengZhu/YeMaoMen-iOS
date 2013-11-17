//
//  YMMBaseRefreshViewController.m
//  yemaomen
//
//  Created by Zhu Weifeng on 11/17/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

// TODO 确定加载更多的判断是否和footerView有关？是不是说如果没有设置footerView，无论如何scrollDelegate方法中的判断都不可能达到。加了footerView才可能达到。另外对scrollView进行复习，判断逻辑不太能搞懂。

#import "YMMBaseRefreshViewController.h"

#define kFooterViewHeight 44.0

@interface YMMBaseRefreshViewController ()
{
  // 当TableView被scroll的时候，如果已经到了TableView的下边界（不含tableFooter），如果继续scroll，就会露出这个footerView。
  // 加载更多的时候，就会在这个footerView上显示一些文字或效果（例：让_activityIndicatorView转动起来等）。
  // 本身加载更多的逻辑判断和这个footerView没有关系。可以参看scroll相关的delegate方法。
  UIView *_footerView;
  // 显示在footerView上的ActivityIndicator
  UIActivityIndicatorView *_activityIndicatorView;
  // viewDidLoad的时候进行设置，方便后续使用（不需要每次都使用self.tableView.frame.size.width来获取宽度）。
  CGFloat _screenWidth;
}

@end

@implementation YMMBaseRefreshViewController

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
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
  
  _screenWidth = self.tableView.frame.size.width;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - interface methods
// 在.h文件中声明的别人能调用的方法

// 设置TableView的footerView，当加载更多的时候，需要在footerView上展现一些文字或效果。
- (void)setupLoadMoreFooterView
{
  if (_footerView == nil) {
    _footerView = [[UIView alloc] init];
    _footerView.frame = CGRectMake(0, 0, _screenWidth, kFooterViewHeight);
    
    _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _activityIndicatorView.center = _footerView.center;
    _activityIndicatorView.hidesWhenStopped = YES;
    [_footerView addSubview:_activityIndicatorView];
    
    self.tableView.tableFooterView = _footerView;
  }
}

- (void)removeLoadMoreFootView
{
  if (_footerView)
  {
    [_activityIndicatorView removeFromSuperview];
    _activityIndicatorView = nil;
    [_footerView removeFromSuperview];
    _footerView = nil;
  }
}

// 子类需override此方法，来实现loadingLatestData功能。
// override的时候记得调用[super loadingLatestData];
- (void)loadingLatestData
{
  // loadingLatestFinished会end这个refresh
  [self.refreshControl beginRefreshing];
}

// 子类需override此方法，来实现loadingMoreData功能。
// override的时候记得调用[super loadingMoreData];
- (void)loadingMoreData
{
  if (_isLoadingMore) return;
  [_activityIndicatorView startAnimating];
}

- (void)loadLatestFinished
{
  _isLoadingLatest = NO;
  [self.refreshControl endRefreshing];
}

- (void)loadMoreFinished
{
  _isLoadingMore = NO;
  [_activityIndicatorView stopAnimating];
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  // 不正在进行加载更多，并且已经设置了加载更多时候需要展现文字或效果的载体（footerView）。
  if (!_isLoadingMore && self.tableView.tableFooterView)
  {
    CGFloat scrollPosition = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y;
    if (scrollPosition < kFooterViewHeight)
    {
      [self loadingMoreData];
    }
  }
}

@end
