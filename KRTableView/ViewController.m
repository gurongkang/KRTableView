//
//  ViewController.m
//  KRTableView
//
//  Created by RK on 2017/11/29.
//  Copyright © 2017年 KR. All rights reserved.
//

#import "ViewController.h"
#import "KRFexibleTableView.h"

@interface ViewController () <KRFexibleTableViewDataSource> {
    NSMutableArray *_chapters;
}

@property (nonatomic, strong) KRFexibleTableView *tableView;

@end

@implementation ViewController

#pragma mark life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];

    [self registerCell];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.frame;
}

#pragma mark chapter

- (NSNumber *)numberOfRowsForTest:(NSNumber *)section sectionIndexInChapter:(NSNumber *)sectionIndex {
    return @3;
}

- (UITableViewCell *)cellForTestAtIndexPath:(NSIndexPath *)indexPath sectionIndexInChapter:(NSNumber *)sectionIndex {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"kUITableViewCell" forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text = [NSString stringWithFormat:@"index.row:%ld | index.section:%ld | sectionIndex:%@", (long)indexPath.row, indexPath.section, sectionIndex];
    return cell;
}

- (NSNumber *)heightForTestAtIndexPath:(NSIndexPath *)indexPath sectionIndexInChapter:(NSNumber *)sectionIndex {
    return @40;
}

#pragma mark KRFexibleTableViewDataSource

- (NSArray *)kr_fexibleTableViewChapters {
    if (_chapters == nil) {
        _chapters = [NSMutableArray array];
        
        KRTableViewChapter *chapter = [KRTableViewChapter createWithTarget:self];
        chapter.numberOfRowsInSectionSEL = @selector(numberOfRowsForTest:sectionIndexInChapter:);
        chapter.cellForRowAtIndexPathSEL = @selector(cellForTestAtIndexPath:sectionIndexInChapter:);
        chapter.heightForRowAtIndexPathSEL = @selector(heightForTestAtIndexPath:sectionIndexInChapter:);
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
