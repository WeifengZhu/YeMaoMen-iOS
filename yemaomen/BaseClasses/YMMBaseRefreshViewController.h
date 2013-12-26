//
//  YMMBaseRefreshViewController.h
//  yemaomen
//
//  Created by Zhu Weifeng on 11/17/13.
//  Copyright (c) 2013 yemaomen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMMBaseRefreshViewController : UITableViewController

/** 子类可以用到的属性放在头文件中 **/

@property (nonatomic, strong) NSMutableArray *tableViewContents; // TableView中Cells的数据源。
@property (nonatomic, strong) AFHTTPRequestOperationManager *requestOperationManager; // 共享的requestManager。
@property (nonatomic) CGFloat screenWidth; // 子类可以用到的屏幕宽度。viewDidLoad的时候进行设置，方便后续使用（不需要每次都使用self.tableView.frame.size.width来获取宽度）。

- (void)setupLoadMoreFooterView;
- (void)removeLoadMoreFootView;

- (void)loadingLatestData;
- (void)loadingMoreData;
- (void)loadLatestFinished;
- (void)loadMoreFinished;

@end
