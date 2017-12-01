//
//  ViewController.m
//  KRTableView
//
//  Created by RK on 2017/11/29.
//  Copyright © 2017年 KR. All rights reserved.
//

#import "KRRootViewController.h"
#import "KRFexibleTableView.h"
#import "KRSystemTableViewController.h"

@interface KRRootViewController () <KRFexibleTableViewDataSource> {
    NSMutableArray *_chapters;
    NSArray *_demoArray;
}

@property (nonatomic, strong) KRFexibleTableView *tableView;

@end

@implementation KRRootViewController

#pragma mark life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];

    [self registerCell];
    
    _demoArray = @[@"KRSystemTableViewController 系统写法", @"Demo2", @"Demo3"];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.frame;
}

#pragma mark chapter

- (NSNumber *)numberOfRowsForTest:(NSNumber *)section sectionIndexInChapter:(NSNumber *)sectionIndex {
    return @(_demoArray.count);
}

- (UITableViewCell *)cellForTestAtIndexPath:(NSIndexPath *)indexPath sectionIndexInChapter:(NSNumber *)sectionIndex {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"kUITableViewCell" forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text = _demoArray[indexPath.row];
    return cell;
}

- (NSNumber *)heightForTestAtIndexPath:(NSIndexPath *)indexPath sectionIndexInChapter:(NSNumber *)sectionIndex {
    return @40;
}

- (void)didSelectRowForTestAtIndexPath:(NSIndexPath *)indexPath sectionIndexInChapter:(NSNumber *)sectionIndex {
    NSLog(@"---%ld",(long)indexPath.row);
    if (indexPath.row == 0) {
        KRSystemTableViewController *systenVC = [[KRSystemTableViewController alloc]init];
        [self.navigationController pushViewController:systenVC animated:YES];
    }
}

#pragma mark KRFexibleTableViewDataSource

- (NSArray *)kr_fexibleTableViewChapters {
    if (_chapters == nil) {
        _chapters = [NSMutableArray array];
        
        KRTableViewChapter *chapter = [KRTableViewChapter createWithTarget:self];
        chapter.numberOfRowsInSectionSEL = @selector(numberOfRowsForTest:sectionIndexInChapter:);
        chapter.cellForRowAtIndexPathSEL = @selector(cellForTestAtIndexPath:sectionIndexInChapter:);
        chapter.heightForRowAtIndexPathSEL = @selector(heightForTestAtIndexPath:sectionIndexInChapter:);
        chapter.didSelectRowAtIndexPathSEL = @selector(didSelectRowForTestAtIndexPath:sectionIndexInChapter:);
        [_chapters addObject:chapter];
    }
    return _chapters;
}

- (void)registerCell {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"kUITableViewCell"];
}

#pragma mark lazy

- (KRFexibleTableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[KRFexibleTableView alloc]init];
        _tableView.fexibleTableViewDataSource = self;
    }
    return _tableView;
}

@end
