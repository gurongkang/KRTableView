//
//  KRRefreshViewController.h
//  KRTableView
//
//  Created by RK on 2018/1/2.
//  Copyright © 2018年 KR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh/MJRefresh.h>
#import "KRTableViewController.h"

@interface KRRefreshViewController : KRTableViewController

/**
 能否上提加载
 
 @return YES 能 NO 否
 */
- (BOOL)canApppend;

/**
 是否能下拉刷新
 
 @return YES 能 NO 否
 */
- (BOOL)canUpdate;

/**
 顶部加载更多
 
 @return YES 能 NO 否
 */
- (BOOL)canTopAppend;

/**
 关闭刷新
 */
- (void)closeUpdate;

/**
 关闭加载
 */
- (void)closeAppend;

/**
 关闭顶部加载更多
 */
- (void)closeTopAppend;


/**
 显示加载更多
 */
- (void)showAppend;

/**
 隐藏加载更多
 */
- (void)hideAppend;

/**
 
 上提加载
 */
- (void)triggerAppend;

/**
 下拉刷新
 */
- (void)triggerUpdate;


/**
 重写下拉刷新组件
 
 @return 下拉刷新
 */
- (MJRefreshHeader *)refreshHeaderView;

/**
 上提顶部加载更多
 */
- (void)triggerTopAppend;
@end
