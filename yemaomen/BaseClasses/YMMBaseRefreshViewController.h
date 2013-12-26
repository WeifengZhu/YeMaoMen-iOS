//
//  YMMBaseRefreshViewController.h
//  yemaomen
//
//  Created by Zhu Weifeng on 11/17/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMMBaseRefreshViewController : UITableViewController

// TableView中Cells的数据源。
@property (nonatomic, strong) NSMutableArray *tableViewContents;

// 是否正在进行相关加载的标识。
@property (nonatomic) BOOL isLoadingLatest;
@property (nonatomic) BOOL isLoadingMore;

- (void)setupLoadMoreFooterView;
- (void)removeLoadMoreFootView;

- (void)loadingLatestData;
- (void)loadingMoreData;
- (void)loadLatestFinished;
- (void)loadMoreFinished;

@end
