//
//  KRRewirteSystenTablViewController.m
//  KRTableView
//
//  Created by RK on 2017/12/1.
//  Copyright © 2017年 KR. All rights reserved.
//

#import "KRRewirteSystenTablViewController.h"
#import "KRFexibleTableView.h"
#import "KRHeadTableViewCell.h"
#import "KRBodySmallTableViewCell.h"
#import "KRBodyNormalTableViewCell.h"
#import "KRFooterTableViewCell.h"

static  NSString *kKRHeadTableViewCell = @"KRHeadTableViewCell";
static  NSString *kKRBodySmallTableViewCell = @"KRBodySmallTableViewCell";
static  NSString *kKRBodyNormalTableViewCell = @"KRBodyNormalTableViewCell";
static  NSString *kKRFooterTableViewCell = @"KRFooterTableViewCell";

@interface KRRewirteSystenTablViewController () <KRFexibleTableViewDataSource> {
    NSMutableArray *_chapters;
}

@property (nonatomic, strong) KRFexibleTableView *tableView;

@end

@implementation KRRewirteSystenTablViewController

#pragma mark life

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];

    [self registerCell];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark chapters

#pragma mark - head

- (NSNumber *)numberOfRowsForHead:(NSNumber *)section sectionIndexInChapter:(NSNumber *)sectionIndex {
    return @1;
}

- (UITableViewCell *)cellForHeadAtIndexPath:(NSIndexPath *)indexPath sectionIndexInChapter:(NSNumber *)sectionIndex {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kKRHeadTableViewCell forIndexPath:indexPath];
    return cell;
}

- (NSNumber *)heightForHeadAtIndexPath:(NSIndexPath *)indexPath sectionIndexInChapter:(NSNumber *)sectionIndex {
    return @([KRHeadTableViewCell cellHegith]);
}

#pragma mark - body

- (NSNumber *)numberOfRowsForBody:(NSNumber *)section sectionIndexInChapter:(NSNumber *)sectionIndex {
    return @2;
}

- (UITableViewCell *)cellForBodyAtIndexPath:(NSIndexPath *)indexPath sectionIndexInChapter:(NSNumber *)sectionIndex {
    UITableViewCell *cell = nil;
    if (indexPath.row == 1) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:kKRBodySmallTableViewCell forIndexPath:indexPath];
    } else {
        cell = [self.tableView dequeueReusableCellWithIdentifier:kKRBodyNormalTableViewCell forIndexPath:indexPath];
    }

    return cell;
}

- (NSNumber *)heightForBodyAtIndexPath:(NSIndexPath *)indexPath sectionIndexInChapter:(NSNumber *)sectionIndex {
    if (indexPath.row == 0) {
        return @([KRBodySmallTableViewCell cellHegith]);
    } else {
        return @([KRBodyNormalTableViewCell cellHegith]);
    }
}

#pragma mark - footer

- (NSNumber *)numberOfRowsForFooter:(NSNumber *)section sectionIndexInChapter:(NSNumber *)sectionIndex {
    return @1;
}

- (UITableViewCell *)cellForFooterAtIndexPath:(NSIndexPath *)indexPath sectionIndexInChapter:(NSNumber *)sectionIndex {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kKRFooterTableViewCell forIndexPath:indexPath];
    return cell;
}

- (NSNumber *)heightForFooterAtIndexPath:(NSIndexPath *)indexPath sectionIndexInChapter:(NSNumber *)sectionIndex {
    return @([KRFooterTableViewCell cellHegith]);
}

#pragma mark KRFexibleTableViewDataSource

- (NSArray *)kr_fexibleTableViewChapters {
    if (_chapters == nil) {
        _chapters = [NSMutableArray array];
        
        KRTableViewChapter *chapter = [KRTableViewChapter createWithTarget:self];
        chapter.numberOfRowsInSectionSEL = @selector(numberOfRowsForHead:sectionIndexInChapter:);
        chapter.cellForRowAtIndexPathSEL = @selector(cellForHeadAtIndexPath:sectionIndexInChapter:);
        chapter.heightForRowAtIndexPathSEL = @selector(heightForHeadAtIndexPath:sectionIndexInChapter:);
        [_chapters addObject:chapter];
        
        chapter = [KRTableViewChapter createWithTarget:self];
        chapter.numberOfRowsInSectionSEL = @selector(numberOfRowsForBody:sectionIndexInChapter:);
        chapter.cellForRowAtIndexPathSEL = @selector(cellForBodyAtIndexPath:sectionIndexInChapter:);
        chapter.heightForRowAtIndexPathSEL = @selector(heightForBodyAtIndexPath:sectionIndexInChapter:);
        [_chapters addObject:chapter];
        
        chapter = [KRTableViewChapter createWithTarget:self];
        chapter.numberOfRowsInSectionSEL = @selector(numberOfRowsForFooter:sectionIndexInChapter:);
        chapter.cellForRowAtIndexPathSEL = @selector(cellForFooterAtIndexPath:sectionIndexInChapter:);
        chapter.heightForRowAtIndexPathSEL = @selector(heightForFooterAtIndexPath:sectionIndexInChapter:);
        [_chapters addObject:chapter];
        
    }
    return _chapters;
}

#pragma mark tableView

- (void)registerCell {
    UINib *nib = [UINib nibWithNibName:kKRHeadTableViewCell bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kKRHeadTableViewCell];
    
    nib = [UINib nibWithNibName:kKRBodySmallTableViewCell bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kKRBodySmallTableViewCell];
    
    nib = [UINib nibWithNibName:kKRBodyNormalTableViewCell bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kKRBodyNormalTableViewCell];
    
    nib = [UINib nibWithNibName:kKRFooterTableViewCell bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kKRFooterTableViewCell];
}

- (KRFexibleTableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[KRFexibleTableView alloc]init];
        _tableView.fexibleTableViewDataSource = self;
    }
    return _tableView;
}

@end
