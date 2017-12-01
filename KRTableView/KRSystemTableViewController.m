//
//  KRSystemTableViewController.m
//  KRTableView
//
//  Created by RK on 2017/12/1.
//  Copyright © 2017年 KR. All rights reserved.
//

#import "KRSystemTableViewController.h"
#import "KRHeadTableViewCell.h"
#import "KRBodySmallTableViewCell.h"
#import "KRBodyNormalTableViewCell.h"
#import "KRFooterTableViewCell.h"

static  NSString *kKRHeadTableViewCell = @"KRHeadTableViewCell";
static  NSString *kKRBodySmallTableViewCell = @"KRBodySmallTableViewCell";
static  NSString *kKRBodyNormalTableViewCell = @"KRBodyNormalTableViewCell";
static  NSString *kKRFooterTableViewCell = @"KRFooterTableViewCell";

@interface KRSystemTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation KRSystemTableViewController

#pragma mark life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self registerTableViewCell];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = 0;
    if (section == 0) {
        count = 1;
    }else if (section == 1) {
        count = 2;
    } else {
        count = 1;
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:kKRHeadTableViewCell forIndexPath:indexPath];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell = [self.tableView dequeueReusableCellWithIdentifier:kKRBodySmallTableViewCell forIndexPath:indexPath];
        } else {
            cell = [self.tableView dequeueReusableCellWithIdentifier:kKRBodyNormalTableViewCell forIndexPath:indexPath];
        }
    } else {
        cell =  [self.tableView dequeueReusableCellWithIdentifier:kKRFooterTableViewCell forIndexPath:indexPath];
    }
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellHeight = 0;
    if (indexPath.section == 0) {
       cellHeight = [KRHeadTableViewCell cellHegith];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 9) {
            cellHeight = [KRBodySmallTableViewCell cellHegith];
        } else {
            cellHeight = [KRBodyNormalTableViewCell cellHegith];
        }
    } else {
        cellHeight = [KRFooterTableViewCell cellHegith];
    }
    
    return cellHeight;
}


#pragma mark tableView

- (void)registerTableViewCell {
    UINib *nib = [UINib nibWithNibName:kKRHeadTableViewCell bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kKRHeadTableViewCell];
    
    nib = [UINib nibWithNibName:kKRBodySmallTableViewCell bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kKRBodySmallTableViewCell];
    
    nib = [UINib nibWithNibName:kKRBodyNormalTableViewCell bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kKRBodyNormalTableViewCell];
    
    nib = [UINib nibWithNibName:kKRFooterTableViewCell bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kKRFooterTableViewCell];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
