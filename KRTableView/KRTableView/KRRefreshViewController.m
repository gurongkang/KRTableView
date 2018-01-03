//
//  KRRefreshViewController.m
//  KRTableView
//
//  Created by RK on 2018/1/2.
//  Copyright © 2018年 KR. All rights reserved.
//

#import "KRRefreshViewController.h"

@interface KRRefreshViewController () {
    BOOL _isAppendToping;
}

@property (nonatomic, strong) UIView *activityHeadView;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end

@implementation KRRefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self canUpdate]) {
        MJRefreshHeader *refreshHeader = [self refreshHeaderView];
        //是否自定义刷新头
        if (refreshHeader) {
            [refreshHeader setRefreshingTarget:self refreshingAction:@selector(triggerUpdate)];
            self.tableView.mj_header = refreshHeader;
        } else {
            self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(triggerUpdate)];
        }
    }
    if ([self canApppend]) {
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(triggerAppend)];
    }
    
    if([self canTopAppend]) {
        [self.activityHeadView addSubview:self.activityView];
        self.tableView.tableHeaderView = self.activityHeadView;
        self.tableView.isAppendTop = YES;
    }
}

- (void)tableViewDidScroll:(UITableView *)tableView {
    if (tableView.contentOffset.y<0  && _isAppendToping == NO) {
        _activityHeadView.hidden = NO;
        [_activityView startAnimating];
        _isAppendToping = YES;
        [self triggerTopAppend];
    }
}

- (BOOL)canApppend {
    return NO;
}

- (BOOL)canTopAppend {
    return NO;
}

- (BOOL)canUpdate {
    return NO;
}

- (void)endUpdateRefreshing {
    [self.tableView.mj_header endRefreshing];
}

- (void)endAppendRefreshing {
    [self.tableView.mj_footer endRefreshing];
}

- (void)endTopAppendRefreshing {
    _activityHeadView.hidden = YES;
    [_activityView stopAnimating];
    _isAppendToping = NO;
}

-(void)triggerAppend {
    
}

-(void)triggerUpdate {
}

- (void)triggerTopAppend {
}

- (MJRefreshHeader *)refreshHeaderView {
    return nil;
}

#pragma mark lazy

- (UIView *)activityHeadView {
    if(_activityHeadView == nil) {
        _activityHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        _activityHeadView.backgroundColor = [UIColor clearColor];
    }
    return _activityHeadView;
}

- (UIActivityIndicatorView *)activityView {
    if(_activityView == nil) {
        _activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _activityView.frame = CGRectMake(_activityHeadView.frame.size.width/2, _activityHeadView.frame.size.height/2, 20, 20);
    }
    return _activityView;
}

@end
