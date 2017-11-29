//
//  KRTableViewChapter.h
//  KRFexibleTableView
//
//  Created by RK on 2017/11/28.
//  Copyright © 2017年 KR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol KRTableViewChapterProtocol

- (NSInteger)numberOfSectionsInChapter;

- (NSInteger)numberOfRowsInSection:(NSNumber *)section sectionIndexInChapter:(NSNumber *)sectionIndexInChapter;

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath sectionIndexInChapter:(NSNumber *)sectionIndexInChapter;

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath sectionIndexInChapter:(NSNumber *)sectionIndexInChapter;

@end

@interface KRTableViewChapter : NSObject <KRTableViewChapterProtocol>

@property (nonatomic, weak) id target;

@property (nonatomic, assign) SEL numberOfSectionsInChapterSEL;

@property (nonatomic, assign) SEL numberOfRowsInSectionSEL;

@property (nonatomic, assign) SEL heightForRowAtIndexPathSEL;

@property (nonatomic, assign) SEL cellForRowAtIndexPathSEL;

- (instancetype)initWithTarget:(id)target;

+ (instancetype)createWithTarget:(id)target;

@end
