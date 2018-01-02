//
//  KRTableViewController.m
//  KRTableView
//
//  Created by RK on 2018/1/2.
//  Copyright © 2018年 KR. All rights reserved.
//

#import "KRTableViewController.h"

#define kKRTableViewSeperatorCell @"KRTableViewSeperatorCell"

@interface KRTableViewController () <KRFexibleTableViewDataSource>

@end

@implementation KRTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerTableViewCell];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kKRTableViewSeperatorCell];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark 业务方法

-(NSArray *)kr_fexibleTableViewChapters {
    return [NSArray array];
}

#pragma mark - 分隔块

- (NSNumber *)splitSectionHeightOfCellWithIndexPath:(NSIndexPath *)indexPath {
    return @10;
}

- (UITableViewCell *)splitSectionCellForRowWithIndexPath:(NSIndexPath *)indexPath {
    return [self cellForSeperator];
}

- (NSNumber *)splitSectionNumberOfRowWithSection:(NSNumber *)section {
    return @1;
}

- (UITableViewCell *)cellForSeperator {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kKRTableViewSeperatorCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor colorWithRed:247/255.0 green:249/255.0 blue:251/255.0 alpha:1.0];
    return cell;
}

#pragma mark 控件

- (void)registerTableViewCell {
    
}

- (KRFexibleTableView *)tableView {
    if(_tableView == nil) {
        _tableView = [[KRFexibleTableView alloc]init];
        _tableView.fexibleTableViewDataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (KRTableViewChapter *)splitSection {
    if (_splitSection == nil) {
        _splitSection = [KRTableViewChapter createWithTarget:self];
        _splitSection.heightForRowAtIndexPathSEL =
        @selector(splitSectionHeightOfCellWithIndexPath:);
        _splitSection.numberOfRowsInSectionSEL =
        @selector(splitSectionNumberOfRowWithSection:);
        _splitSection.cellForRowAtIndexPathSEL = @selector(splitSectionCellForRowWithIndexPath:);
    }
    return _splitSection;
}

@end
