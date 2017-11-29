//
//  KRFexibleTableView.m
//  KRFexibleTableView
//
//  Created by RK on 2017/11/28.
//  Copyright © 2017年 KR. All rights reserved.
//

#import "KRFexibleTableView.h"
#import "KRTableViewChapter.h"

@interface KRFexibleTableView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation KRFexibleTableView

#pragma mark init

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame style:UITableViewStylePlain];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setUpInitValue];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setUpInitValue];
    }
    return self;
}

- (void)setUpInitValue {
    self.delegate = self;
    self.dataSource = self;
}

#pragma mark inside

- (NSArray *)chapters {
    if (self.fexibleTableViewDataSource != nil) {
        return [self.fexibleTableViewDataSource kr_fexibleTableViewChaters];
    }
    return [NSMutableArray array];
}

- (id<KRTableViewChapterProtocol>)chapterForSectionIndex:(NSInteger)section {
    NSInteger count = 0;
    for (id<KRTableViewChapterProtocol> chapter in self.chapters) {
        NSInteger secionCountInChapter = [chapter numberOfSectionsInChapter];
        if (secionCountInChapter != 0) {
            if (section >= count && section < count + secionCountInChapter) {
                return chapter;
            }
        }
        
        count += secionCountInChapter;
    }
    return nil;
}

- (NSInteger)sectionIndexInChapter:(NSInteger)section {
    id<KRTableViewChapterProtocol> chapter = [self chapterForSectionIndex:section];
    
    NSInteger count = 0;
    
    for (id<KRTableViewChapterProtocol> tempChapter in self.chapters) {
        if (tempChapter == chapter) {
            return section - count;
        }
        
        count += [chapter numberOfSectionsInChapter];
    }
    
    return section;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = 0;
    
    for (id<KRTableViewChapterProtocol> chapter in self.chapters) {
        count += [chapter numberOfSectionsInChapter];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<KRTableViewChapterProtocol> chapter = [self chapterForSectionIndex:section];
    NSInteger count = 0;

    count = [chapter numberOfRowsInSection:@(section) sectionIndexInChapter:@([self sectionIndexInChapter:section])];
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<KRTableViewChapterProtocol> chapter = [self chapterForSectionIndex:indexPath.section];
   
    UITableViewCell *cell = nil;

#ifndef DEBUG
    @try {
#endif
        cell = [chapter cellForRowAtIndexPath:indexPath sectionIndexInChapter:@([self sectionIndexInChapter:indexPath.section])];
#ifndef DEBUG
    } @catch (NSException *exception) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"__FUCK_ERROR__"];
        cell.textLabel.text = @"出错了~~";
    }
#endif
    
    return cell;
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    
    id<KRTableViewChapterProtocol> chapter = [self chapterForSectionIndex:indexPath.section];

    height = [chapter heightForRowAtIndexPath:indexPath sectionIndexInChapter:@([self sectionIndexInChapter:indexPath.section])];
    
    return height;
}

@end
