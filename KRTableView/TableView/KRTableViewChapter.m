//
//  KRTableViewChapter.m
//  KRFexibleTableView
//
//  Created by RK on 2017/11/28.
//  Copyright © 2017年 KR. All rights reserved.

#import "KRTableViewChapter.h"

@implementation KRTableViewChapter

- (instancetype)initWithTarget:(id)target {
    if (self = [super init]) {
        self.target = target;
    }
    return self;
}

+ (instancetype)createWithTarget:(id)target {
    return [[KRTableViewChapter alloc]initWithTarget:target];
}

#pragma mark RKTableViewChapterProtocol

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (NSInteger)numberOfSectionsInChapter {
    NSInteger sections = 1;
    
    if (self.target && self.numberOfSectionsInChapterSEL) {
        id result = [self.target performSelector:self.numberOfSectionsInChapterSEL withObject:nil];
        sections = [result integerValue];
    }
    
    return sections;
}

- (NSInteger)numberOfRowsInSection:(NSNumber *)section sectionIndexInChapter:(NSNumber *)sectionIndexInChapter {
    NSInteger rows = 1;
    
    if (self.target && self.target) {
        id result = [self.target performSelector:self.numberOfRowsInSectionSEL withObject:section withObject:sectionIndexInChapter];
        rows = [result integerValue];
    }
   
    return rows;
}

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath sectionIndexInChapter:(NSNumber *)sectionIndexInChapter {
    UITableViewCell *tableViewCell = nil;
    
    if (self.target && self.cellForRowAtIndexPathSEL) {
        id result =  [self.target performSelector:self.cellForRowAtIndexPathSEL withObject:indexPath withObject:sectionIndexInChapter];
        tableViewCell = result;
    }
    
    return tableViewCell;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath sectionIndexInChapter:(NSNumber *)sectionIndexInChapter {
    CGFloat height = 0;
    
    if (self.target && self.heightForRowAtIndexPathSEL) {
        id result = [self.target performSelector:self.heightForRowAtIndexPathSEL withObject:indexPath withObject:sectionIndexInChapter];
        height = [result floatValue];
    }
    
    return height;
}

#pragma clang diagnostic pop

@end
